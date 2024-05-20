import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salicta_mobile/db/model/product_model.dart';
import 'package:salicta_mobile/theme/constants.dart';
import 'package:salicta_mobile/ui/root_page/root_cubit.dart';

import '../../../db/model/review.dart';
import '../../root_page/root_state.dart';

class MyReviewsScreen extends StatelessWidget {
  const MyReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "MY REVIEWS",
          style: kMerriweatherBold16,
        ),
      ),
      body: BlocBuilder<RootCubit, RootState>(
          buildWhen: (previous, current) =>
              previous.currentUser != current.currentUser ||
              previous.products != current.products,
          builder: (context, state) {
            List<ProductModel> all = [];
            List<Review> re = [];

            for (ProductModel product in state.products!) {
              final reviews = product.reviews;

              final a = reviews.where(
                  (element) => element.userRef == state.currentUser!.ref);

              if (a.isNotEmpty) {
                re.addAll(a);
              }
            }

            return ListView.builder(
              itemCount: re.length,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final review = re[index];

                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x408A959E),
                        offset: Offset(0, 8),
                        blurRadius: 40,
                      )
                    ],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          for (int i = 0; i < review.rate; i++)
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: SvgPicture.asset(
                                'assets/icons/star_icon.svg',
                                height: 16,
                                width: 16,
                              ),
                            ),
                          const Spacer(),
                          Text(
                            DateFormat("dd-MM-yyyy")
                                .format(review.addedDate.toDate()),
                            style: kNunitoSans12Grey,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12,),
                      Text(
                        review.review,
                        style: kNunitoSans14,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            );
          }),
    );
  }
}
