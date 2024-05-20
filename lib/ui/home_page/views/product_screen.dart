import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salicta_mobile/db/model/cart_model.dart';
import 'package:salicta_mobile/theme/constants.dart';
import 'package:salicta_mobile/ui/home_page/views/product_review_screen.dart';
import 'package:salicta_mobile/ui/root_page/root_cubit.dart';
import 'package:salicta_mobile/ui/root_page/root_state.dart';
import 'package:salicta_mobile/ui/widgets/common_snack_bar.dart';
import 'package:salicta_mobile/util/widgets/animation/fade_in_widget.dart';
import 'package:salicta_mobile/util/widgets/buttons/custom_elevated_button.dart';
import 'package:salicta_mobile/util/widgets/tabbed/product_image_view.dart';

import '../../../db/model/product_model.dart';

class ProductScreen extends StatefulWidget {
  final ProductModel product;

  const ProductScreen({super.key, required this.product});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int count = 1;

  incrementCount() {
    setState(() {
      count = count + 1;
    });
  }

  decrementCount() {
    if (count - 1 > 0) {
      setState(() {
        count = count - 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final rootCubit = BlocProvider.of<RootCubit>(context);

    final scaffold = Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                ProductImageView(imagesList: widget.product.images),
                Positioned(
                  left: 27,
                  top: size.height * 0.06,
                  child: FadeInWidget(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: kOffBlack,
                        ),
                      ),
                    ),
                  ),
                ),
                // Positioned(
                //   left: 20,
                //   top: size.height * 0.15,
                //   child: FadeInWidget(
                //     child: ColorSelectionColumn(
                //       colorsList: product.colorsList,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.title,
                  style: kGelasio18.copyWith(
                    fontSize: 24,
                    color: kOffBlack,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$ ${widget.product.price}',
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: kOffBlack),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            incrementCount();
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            margin: const EdgeInsets.only(right: 15),
                            decoration: BoxDecoration(
                              color: kChristmasSilver,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: kTinGrey,
                            ),
                          ),
                        ),
                        Text(
                          count.toString(),
                          style: kNunitoSansSemiBold18,
                        ),
                        GestureDetector(
                          onTap: () {
                            decrementCount();
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            margin: const EdgeInsets.only(left: 15),
                            decoration: BoxDecoration(
                              color: kChristmasSilver,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.remove,
                              color: kTinGrey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductReviewScreen(
                          productModel: widget.product,
                        ),
                      ),
                    );
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/star_icon.svg',
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        widget.product.rating.toString() ?? '0',
                        style: kNunitoSansSemiBold18,
                      ),
                      const SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          '(${widget.product.reviews.length} reviews)',
                          style: kNunitoSans14.copyWith(
                            fontWeight: FontWeight.w600,
                            color: kGrey,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.product.description,
                  style: kNunitoSans14.copyWith(
                    fontWeight: FontWeight.w300,
                    color: kGraniteGrey,
                  ),
                ),
                const SizedBox(height: 20),
                BlocBuilder<RootCubit, RootState>(
                    buildWhen: (previous, current) =>
                        previous.currentUser != current.currentUser ||
                        previous.products != current.products,
                    builder: (context, state) {
                      bool isAdded = false;

                      final current = state.currentUser!.favourites;

                      final a = current
                          .where((element) => element == widget.product.ref)
                          .toList();

                      if (a.isNotEmpty) {
                        isAdded = true;
                      }

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            onTap: () {
                              rootCubit.addToFavourite(widget.product.ref!);
                            },
                            child: Ink(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: kChristmasSilver,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: SvgPicture.asset(
                                (!isAdded)
                                    ? 'assets/icons/favorite_icon_black.svg'
                                    : 'assets/icons/favorite_selected_icon.svg',
                                height: 24,
                                width: 24,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: CustomElevatedButton(
                              height: 50,
                              onTap: () async {
                                final data = CartModel(
                                  price: widget.product.price * count,
                                  itemRef: widget.product.ref!,
                                  color: '',
                                  addedDate: Timestamp.now(),
                                  count: count,
                                  userId: '',
                                  userRef: rootCubit.state.currentUser!.ref!,
                                  item: widget.product,
                                  status: 'pending',
                                );
                                await rootCubit.addToCart(data);
                              },
                              text: "Add to cart",
                            ),
                          )
                        ],
                      );
                    }),
              ],
            ),
          )
        ],
      ),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<RootCubit, RootState>(
          listenWhen: (pre, current) => pre.error != current.error,
          listener: (context, state) {
            if (state.error.isNotEmpty) {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context)
                  .showSnackBar(AppSnackBar.showErrorSnackBar(state.error));
            } else {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
            }
          },
        ),
        BlocListener<RootCubit, RootState>(
          listenWhen: (pre, current) =>
              pre.addToCartStatus != current.addToCartStatus,
          listener: (context, state) {
            log("STATUS >>>>>>>> ${state.addToCartStatus}",
                name: "PRODUCT SCREEN");
            if (state.addToCartStatus == 2) {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context)
                  .showSnackBar(AppSnackBar.showSnackBar('Item added..'));
            } else if (state.addToCartStatus == 3) {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                  AppSnackBar.showSnackBar('Item already in cart..',
                      color: Colors.red));
            }
          },
        ),
      ],
      child: scaffold,
    );
  }
}
