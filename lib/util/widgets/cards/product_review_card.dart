import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salicta_mobile/theme/constants.dart';

class ProductReviewCard extends StatelessWidget {
  final String reviewerName;
  final String dateString;
  final int ratingValue;
  final String reviewDescription;
  final String profileImageUrl;
  const ProductReviewCard(
      {super.key,
      required this.reviewerName,
      required this.dateString,
      required this.ratingValue,
      required this.reviewDescription,
      required this.profileImageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color(0x408A959E),
              offset: Offset(0, 8),
              blurRadius: 40,
            )
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    reviewerName,
                    style: kNunitoSans14.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    dateString,
                    style: kNunitoSans12Grey,
                  ),
                ],
              ),
              const SizedBox(height: 12,),
              Row(
                children: [
                  for (int i = 0; i < ratingValue; i++)
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: SvgPicture.asset(
                        'assets/icons/star_icon.svg',
                        height: 12,
                        width: 12,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 2,),
              Text(
                reviewDescription,
                maxLines: 5,
                style: kNunitoSans14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
