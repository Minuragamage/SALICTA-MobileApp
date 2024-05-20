import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salicta_mobile/db/model/product_model.dart';
import 'package:salicta_mobile/theme/constants.dart';
import 'package:salicta_mobile/ui/home_page/views/add_review_screen.dart';
import 'package:salicta_mobile/util/widgets/cards/product_review_card.dart';

import '../../profile_page/views/input/add_shipping_screen.dart';

class ProductReviewScreen extends StatelessWidget {
  const ProductReviewScreen({super.key, required this.productModel});

  final ProductModel productModel;

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
          "RATING & REVIEW",
          style: kMerriweatherBold16,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddReviewScreen(
                productModel: productModel,
              ),
            ),
          );
        },
        elevation: 8,
        backgroundColor: Colors.white,
        foregroundColor: kOffBlack,
        child: const Icon(
          Icons.add,
          size: 34,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    productModel.images[0],
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productModel.title,
                        style: kNunitoSans14.copyWith(
                          color: kGraniteGrey,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: SvgPicture.asset(
                              'assets/icons/star_icon.svg',
                              height: 20,
                              width: 20,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            productModel.rating.toString(),
                            style: kNunitoSansBold24,
                          ),
                        ],
                      ),
                      Text(
                        "${productModel.reviews.length} reviews",
                        style: kNunitoSansSemiBold18,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 14),
          const Divider(
            thickness: 1,
            indent: 20,
            endIndent: 20,
            color: kSnowFlakeWhite,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: productModel.reviews.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final review = productModel.reviews[index];

                return ProductReviewCard(
                  reviewerName: review.userName,
                  ratingValue: review.rate,
                  dateString: DateFormat("dd-MM-yyyy")
                      .format(review.addedDate.toDate()),
                  profileImageUrl:
                      "https://avatars.githubusercontent.com/u/62930521?v=4",
                  reviewDescription: review.review,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
