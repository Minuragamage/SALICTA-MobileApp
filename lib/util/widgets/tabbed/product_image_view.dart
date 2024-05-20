import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/constants.dart';

class ProductImageView extends StatelessWidget {
  final List<String> imagesList;
  ProductImageView({super.key, required this.imagesList});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: Hero(
            tag: imagesList[0],
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(50),
              ),
              child: SizedBox(
                height: size.height * 0.5,
                width: size.width - 50,
                child: PageView(
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (index) {
                    // _controller.imageIndex.value = index;
                  },
                  children: [
                    for (int i = 0; i < imagesList.length; i++)
                      CachedNetworkImage(
                        cacheKey: imagesList[i],
                        imageUrl: imagesList[i],
                        maxHeightDiskCache: (size.height * 2).toInt(),
                        maxWidthDiskCache: (size.width * 2).toInt(),
                        fit: BoxFit.cover,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 35,
          bottom: 30,
          child: Row(
            children: [
              for (int i = 0; i < imagesList.length; i++)
                AnimatedContainer(
                  width: (true) ? 30 : 15,
                  height: 4,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.bounceOut,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: (true)
                        ? kOffBlack
                        : kSnowFlakeWhite,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
