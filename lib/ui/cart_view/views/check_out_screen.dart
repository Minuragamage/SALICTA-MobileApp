import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:salicta_mobile/db/model/cart_model.dart';
import 'package:salicta_mobile/theme/constants.dart';
import 'package:salicta_mobile/theme/styled_colors.dart';
import 'package:salicta_mobile/ui/cart_view/views/add_shipping_address_screen.dart';
import 'package:salicta_mobile/ui/profile_page/views/shipping_address_screen.dart';
import 'package:salicta_mobile/ui/root_page/root_cubit.dart';
import 'package:salicta_mobile/ui/root_page/root_state.dart';
import 'package:salicta_mobile/ui/widgets/common_snack_bar.dart';
import 'package:salicta_mobile/util/widgets/buttons/custom_elevated_button.dart';
import 'package:salicta_mobile/util/widgets/cards/address_card.dart';

class CheckOutScreen extends StatelessWidget {
  final int orderAmount;
  final List<CartModel> cartItems;

  const CheckOutScreen(
      {super.key, required this.orderAmount, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    final rootCubit = BlocProvider.of<RootCubit>(context);

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
          "CHECK-OUT",
          style: kMerriweatherBold16,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Shipping Address",
                  style: kNunitoSansSemiBold18.copyWith(
                    color: kTinGrey,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddShippingAddressScreen(),
                      ),
                    );
                  },
                  icon: SvgPicture.asset("assets/icons/edit_icon.svg"),
                ),
              ],
            ),
            BlocBuilder<RootCubit, RootState>(
                buildWhen: (previous, current) =>
                    previous.shippingAddress != current.shippingAddress,
                builder: (context, state) {
                  if (state.shippingAddress.isNotEmpty) {
                    return AddressCard(
                      isEditable: false,
                      address: state.shippingAddress[0],
                      index: 0,
                    );
                  } else {
                    return Center(
                      child: Text(
                        "Please add shipping address",
                        style: kNunitoSans14.copyWith(
                          color: kGrey,
                        ),
                      ),
                    );
                  }
                }),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Payment",
                  style: kNunitoSansSemiBold18.copyWith(
                    color: kTinGrey,
                  ),
                ),
                // IconButton(
                //   onPressed: () {
                //     // Navigator.push(
                //     //   context,
                //     //   MaterialPageRoute(
                //     //     builder: (context) => PaymentMethodsScreen(),
                //     //   ),
                //     // );
                //   },
                //   icon: SvgPicture.asset("assets/icons/edit_icon.svg"),
                // ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              height: 69,
              width: double.infinity,
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
              child: Row(
                children: [
                  Checkbox(
                    activeColor: StyledColors.primaryColorDark,
                    checkColor: Colors.white,
                    value: true,
                    onChanged: (bool? value) {},
                  ),
                  Text(
                    "Cash on Delivery",
                    style: kNunitoSans14.copyWith(
                      fontWeight: FontWeight.w600,
                      color: kRaisinBlack,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            const Spacer(flex: 2),
            Container(
              height: 135,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Order:",
                        style: kNunitoSansTinGrey18,
                      ),
                      Text(
                        "LKR :  $orderAmount.00",
                        style: kNunitoSansSemiBold18,
                      ),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Delivery:",
                        style: kNunitoSansTinGrey18,
                      ),
                      Text(
                        "LKR :  3000.00",
                        style: kNunitoSansSemiBold18,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total:",
                        style: kNunitoSansTinGrey18,
                      ),
                      Text(
                        "LKR : ${orderAmount + 3000}.00",
                        style: kNunitoSansSemiBold18,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            CustomElevatedButton(
              height: 50,
              onTap: () {
                rootCubit.createOrder(
                  itemCount: cartItems.length,
                  price: orderAmount + 3000,
                  items: cartItems,
                );
              },
              text: 'Submit Order',
            ),
            const Spacer(),
          ],
        ),
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
              pre.addOrderStatus != current.addOrderStatus,
          listener: (context, state) async {
            if (state.addOrderStatus == 1) {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context)
                  .showSnackBar(AppSnackBar.loadingSnackBar);
            } else if (state.addOrderStatus == 2) {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                AppSnackBar.showSnackBar(
                  'Order added successfully ',
                ),
              );
              await Future.delayed(const Duration(seconds: 2));
              Navigator.pop(context);
            } else if (state.addOrderStatus == 4) {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                AppSnackBar.showErrorSnackBar("Please enter shipping address"),
              );
            }
          },
        ),
      ],
      child: scaffold,
    );
  }
}
