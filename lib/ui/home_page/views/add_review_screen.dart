import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:salicta_mobile/theme/constants.dart';
import 'package:salicta_mobile/ui/root_page/root_cubit.dart';
import 'package:salicta_mobile/ui/root_page/root_state.dart';
import 'package:salicta_mobile/ui/widgets/common_snack_bar.dart';
import 'package:salicta_mobile/util/context_extension.dart';
import 'package:salicta_mobile/util/widgets/buttons/custom_elevated_button.dart';
import 'package:salicta_mobile/util/widgets/input/custom_dropdown_box.dart';
import 'package:salicta_mobile/util/widgets/input/custom_input_box.dart';

import '../../../db/model/product_model.dart';

class AddReviewScreen extends StatefulWidget {
  final ProductModel productModel;

  const AddReviewScreen({super.key, required this.productModel});

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  final _formKey = GlobalKey<FormState>();
  final _reviewController = TextEditingController();

  int rate = 0;

  late FocusNode _viewFocus;
  late FocusNode _reviewFocus;

  late RootCubit rootBloc;

  Future<void> _addReview() async {
    FocusScope.of(context).requestFocus(_viewFocus);
    ScaffoldMessenger.of(context).showSnackBar(AppSnackBar.loadingSnackBar);

    final view = (_reviewController.text).trim();
    if (view.isEmpty) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
          AppSnackBar.showErrorSnackBar("Please enter your review"));
      return;
    }

    await rootBloc.addReview(
      view,
      rate,
      widget.productModel,
    );
  }

  @override
  void initState() {
    super.initState();
    rootBloc = BlocProvider.of<RootCubit>(context);
    _viewFocus = FocusNode();
    _reviewFocus = FocusNode();
  }

  @override
  void dispose() {
    _viewFocus.dispose();
    _reviewFocus.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: kOffBlack,
            size: 20,
          ),
        ),
        centerTitle: true,
        title: const Text(
          "ADD REVIEW",
          style: kMerriweatherBold16,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(_viewFocus);
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          reverse: true,
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      rate = rating.toInt();
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 150,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(16, 10, 4, 10),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: kChristmasSilver,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Review',
                          style: kNunitoSans12TrolleyGrey,
                        ),
                        const SizedBox(height: 4),
                        TextFormField(
                          focusNode: _reviewFocus,
                          controller: _reviewController,
                          onFieldSubmitted: (val) {},
                          maxLines: 3,
                          keyboardType: TextInputType.multiline,
                          cursorColor: kOffBlack,
                          decoration: const InputDecoration(
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.zero,
                            isCollapsed: true,
                            hintStyle: kNunitoSansSemiBold16NorgheiSilver,
                            counterText: "",
                            border: InputBorder.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                CustomElevatedButton(
                  height: context.dynamicHeight(0.05),
                  onTap: _addReview,
                  text: "ADD REVIEW",
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<RootCubit, RootState>(
          listenWhen: (pre, current) =>
              pre.addReviewStatus != current.addReviewStatus,
          listener: (context, state) {
            if (state.addReviewStatus == 2) {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
            }
          },
        ),
      ],
      child: scaffold,
    );
  }
}
