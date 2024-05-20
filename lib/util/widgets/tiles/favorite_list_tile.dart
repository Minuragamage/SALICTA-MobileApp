import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:salicta_mobile/db/model/product_model.dart';
import 'package:salicta_mobile/models/product.dart';
import 'package:salicta_mobile/ui/home_page/views/product_screen.dart';
import 'package:salicta_mobile/ui/root_page/root_cubit.dart';

import '../../../theme/constants.dart';

class FavoriteListTile extends StatelessWidget {
  final ProductModel product;

  const FavoriteListTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final rootCubit = BlocProvider.of<RootCubit>(context);

    return Container(
      height: 120,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {},
            child: Hero(
              tag: product.images[0],
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  cacheKey: product.images[0],
                  imageUrl: product.images[0],
                  placeholder: (context, url) {
                    return Image.asset(
                      'assets/furniture_loading.gif',
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    );
                  },
                  height: 100,
                  width: 100,
                  maxHeightDiskCache: (size.height * 2).toInt(),
                  maxWidthDiskCache: (size.width * 2).toInt(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: kNunitoSans14.copyWith(
                      color: kGraniteGrey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "\$ ${product.price}",
                    style: kNunitoSansBold16,
                  )
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  rootCubit.addToFavourite(product.ref!);
                },
                customBorder: const CircleBorder(),
                child: const Icon(
                  Icons.highlight_off,
                  size: 24,
                  color: Colors.red,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
