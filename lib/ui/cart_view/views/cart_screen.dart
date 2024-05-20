import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salicta_mobile/theme/constants.dart';
import 'package:salicta_mobile/ui/cart_view/views/check_out_screen.dart';
import 'package:salicta_mobile/ui/root_page/root_cubit.dart';
import 'package:salicta_mobile/ui/root_page/root_state.dart';
import 'package:salicta_mobile/ui/widgets/common_snack_bar.dart';
import 'package:salicta_mobile/util/context_extension.dart';
import 'package:salicta_mobile/util/widgets/buttons/custom_elevated_button.dart';
import 'package:salicta_mobile/util/widgets/tiles/cart_list_tile.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "MY CART",
          style: kMerriweatherBold16,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(children: [
          Expanded(
            child: BlocBuilder<RootCubit, RootState>(
                buildWhen: (previous, current) =>
                    previous.cartItems != current.cartItems,
                builder: (context, state) {
                  if (state.cartItems.isEmpty) {
                    return Column(
                      children: [
                        SizedBox(
                          height: context.dynamicHeight(0.1),
                        ),
                        const Text("No items in cart .. "),
                      ],
                    );
                  }

                  return ListView.separated(
                    itemCount: state.cartItems.length,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return CartListTile(
                        cartItem: state.cartItems[index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: 12,
                        thickness: 1,
                        color: kSnowFlakeWhite,
                      );
                    },
                  );
                }),
          ),
          BlocBuilder<RootCubit, RootState>(
              buildWhen: (previous, current) =>
                  previous.cartItems != current.cartItems,
              builder: (context, state) {
                int total = 0;

                for (var item in state.cartItems) {
                  total = total + item.price;
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Container(
                        height: 45,
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x258A959E),
                              offset: Offset(0, 2),
                              blurRadius: 20,
                            )
                          ],
                        ),
                        child: TextField(
                          style: kNunitoSansSemiBold16,
                          maxLength: 6,
                          cursorColor: kOffBlack,
                          decoration: InputDecoration(
                            counter: const Offstage(),
                            contentPadding: const EdgeInsets.only(left: 25, top: 25),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0x128A959E),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0x128A959E),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            isDense: true,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: kOffBlack,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            hintText: "Enter your Promo Code",
                            hintStyle: kNunitoSans16.copyWith(
                              fontWeight: FontWeight.normal,
                              height: 1,
                              color: kBasaltGrey,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total: ",
                              style: kNunitoSansBold20.copyWith(
                                color: kGrey,
                              ),
                            ),
                            Text(
                              "LKR : $total",
                              style: kNunitoSansBold20,
                            )
                          ],
                        ),
                      ),
                      CustomElevatedButton(
                        height: context.dynamicHeight(0.06),
                        onTap: () {
                          if (state.cartItems.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CheckOutScreen(
                                  orderAmount: total,
                                  cartItems: state.cartItems,
                                ),
                              ),
                            );
                          }
                        },
                        text: 'CHECK OUT',
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                );
              })
        ]),
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
          listenWhen: (pre, current) => pre.stockExceeded != current.stockExceeded,
          listener: (context, state) {
            if (state.stockExceeded) {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context)
                  .showSnackBar(AppSnackBar.showErrorSnackBar("Stock Exceeded.."));
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
                AppSnackBar.showSnackBar(
                  'Item already in cart..',
                  color: Colors.red,
                ),
              );
            }
          },
        ),
      ],
      child: scaffold,
    );
  }
}
