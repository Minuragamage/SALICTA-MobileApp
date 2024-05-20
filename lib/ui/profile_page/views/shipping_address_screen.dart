import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salicta_mobile/theme/constants.dart';
import 'package:salicta_mobile/ui/profile_page/views/input/add_shipping_screen.dart';
import 'package:salicta_mobile/ui/root_page/root_cubit.dart';
import 'package:salicta_mobile/ui/root_page/root_state.dart';
import 'package:salicta_mobile/util/widgets/cards/address_card.dart';

class ShippingAddressScreen extends StatelessWidget {
  const ShippingAddressScreen({super.key});

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
          "SHIPPING ADDRESS",
          style: kMerriweatherBold16,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  AddShippingScreen(),
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
      body: BlocBuilder<RootCubit, RootState>(
          buildWhen: (previous, current) =>
              previous.currentUser != current.currentUser,
          builder:(context, state) {

            final user = state.currentUser;

            if (user == null) {
              return Container();
            }
            if (user.address.isEmpty) {
              return Center(
                child: Text(
                  "No Shipping Addresses have been entered",
                  style: kNunitoSans14.copyWith(
                    color: kGrey,
                  ),
                ),
              );
            }
            return ListView.builder(
              itemCount: user.address.length,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                          child: Checkbox(
                            value: (true) ? true : false,
                            onChanged: (isSelected) {
                              // addressController.setDefaultShippingAddress(index);
                            },
                            activeColor: kOffBlack,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            splashRadius: 20,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                        Text(
                          "Use as the shipping address",
                          style: kNunitoSans18.copyWith(
                            color: kGrey,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    AddressCard(
                      address: user.address[index],
                      index: index,
                    ),
                    const SizedBox(height: 30),
                  ],
                );
              },
            );
          }),
    );
  }
}
