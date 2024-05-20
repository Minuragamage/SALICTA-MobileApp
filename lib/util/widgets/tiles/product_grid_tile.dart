import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salicta_mobile/db/model/product_model.dart';
import 'package:salicta_mobile/models/product.dart';
import 'package:salicta_mobile/theme/constants.dart';
import 'package:salicta_mobile/ui/home_page/views/product_screen.dart';

class ProductGridTile extends StatelessWidget {
  final ProductModel product;
  final bool heroMode;
  const ProductGridTile({super.key, required this.product, this.heroMode = true});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ProductScreen(product: product);
            },
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 0.7,
            child: HeroMode(
              enabled: heroMode,
              child: Hero(
                tag: product.images[0],
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        cacheKey: product.images[0],
                        imageUrl: product.images[0],
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) {
                          if (downloadProgress.progress == null) {
                            return const SizedBox();
                          } else {
                            return Image.asset(
                              'assets/furniture_loading.gif',
                              height: 500,
                              width: 500,
                              fit: BoxFit.cover,
                            );
                          }
                        },
                        height: 500,
                        width: 500,
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
          const SizedBox(height: 10),
          Text(
            product.title,
            style: kNunitoSans14.copyWith(
              color: kGraniteGrey,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'LKR ${product.price}',
            style: kNunitoSans14.copyWith(
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
