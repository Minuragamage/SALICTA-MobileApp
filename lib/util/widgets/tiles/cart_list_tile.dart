import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salicta_mobile/db/model/cart_model.dart';
import 'package:salicta_mobile/theme/constants.dart';
import 'package:salicta_mobile/theme/styled_colors.dart';
import 'package:salicta_mobile/ui/root_page/root_cubit.dart';

class CartListTile extends StatelessWidget {
  final CartModel cartItem;
  const CartListTile({super.key, required this.cartItem});

  void _productOnTap() {
    // Get.to(
    //   () => ProductScreen(product: cartItem.getProduct()),
    //   duration: const Duration(milliseconds: 500),
    //   transition: Transition.fadeIn,
    // );
  }


  @override
  Widget build(BuildContext context) {

    final rootCubit = BlocProvider.of<RootCubit>(context);

    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: _productOnTap,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: StyledColors.primaryColorDark, width: 0.8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Hero(
                tag: cartItem.item.images[0],
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    cacheKey: cartItem.item.images[0],
                    imageUrl: cartItem.item.images[0],
                    placeholder: (context, url) {
                      return Image.asset(
                        'assets/furniture_loading.gif',
                        height: 500,
                        width: 500,
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
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cartItem.item.title,
                      style: kNunitoSans14.copyWith(
                        color: kGraniteGrey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await rootCubit.removeFromCart(cartItem);
                      },
                      customBorder: const CircleBorder(),
                      child: const Icon(
                        Icons.delete,
                        size: 22,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await rootCubit.increaseItemCount(cartItem);
                      },
                      child: Container(
                        height: 25,
                        width: 25,
                        margin: const EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                          color: kChristmasSilver,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: kTinGrey,
                        ),
                      ),
                    ),
                    Text(
                      "${cartItem.count}",
                      style: kNunitoSansSemiBold18,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await rootCubit.decreaseItemCount(cartItem);
                      },
                      child: Container(
                        height: 25,
                        width: 25,
                        margin: const EdgeInsets.only(left: 15),
                        decoration: BoxDecoration(
                          color: kChristmasSilver,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Icon(
                          Icons.remove,
                          color: kTinGrey,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'LKR : ${cartItem.price}',
                      style: kNunitoSansBold16,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
