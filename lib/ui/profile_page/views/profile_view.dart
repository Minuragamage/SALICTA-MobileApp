import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salicta_mobile/ui/profile_page/views/my_reviews_screen.dart';
import 'package:salicta_mobile/ui/profile_page/views/orders_screen.dart';
import 'package:salicta_mobile/ui/profile_page/views/payment_methods_screen.dart';
import 'package:salicta_mobile/ui/profile_page/views/settings_screen.dart';
import 'package:salicta_mobile/theme/constants.dart';
import 'package:salicta_mobile/ui/root_page/root_cubit.dart';
import 'package:salicta_mobile/ui/root_page/root_state.dart';
import 'package:salicta_mobile/ui/widgets/common_snack_bar.dart';
import 'package:salicta_mobile/util/widgets/tiles/profile_tile.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final imgPicker = ImagePicker();

  _imgFromGallery(RootCubit cubit) async {
    final XFile? image = await imgPicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      cubit.updateProfileImage(image);
    }
  }

  @override
  Widget build(BuildContext context) {
    final rootCubit = BlocProvider.of<RootCubit>(context);

    final scaffold = PopScope(
      canPop: false,
      onPopInvoked: (_) => kOnExitConfirmation(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              _imgFromGallery(rootCubit);
            },
            icon: const Icon(
              Icons.add_a_photo,
              color: kGraniteGrey,
            ),
          ),
          centerTitle: true,
          title: const Text(
            "PROFILE",
            style: kMerriweatherBold16,
          ),
          actions: [
            IconButton(
              onPressed: () {
                // _userController.signOut();
              },
              icon: SvgPicture.asset(
                "assets/icons/logout_icon.svg",
                color: Colors.red,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              BlocBuilder<RootCubit, RootState>(
                  buildWhen: (previous, current) =>
                      previous.currentUser != current.currentUser,
                  builder: (context, state) {
                    final user = state.currentUser;

                    if (user == null) {
                      return Container();
                    }

                    return Row(
                      children: [
                        (user.profileImage.isEmpty)
                            ? const CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.white,
                                foregroundImage:
                                    AssetImage("assets/default_avatar.png"),
                              )
                            : CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.white,
                                foregroundImage: CachedNetworkImageProvider(
                                  user.profileImage,
                                  maxHeight: 240,
                                  maxWidth: 240,
                                ),
                              ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name ?? '',
                              style: kNunitoSansBold20,
                            ),
                            Text(
                              user.email,
                              style: kNunitoSans14.copyWith(
                                color: kGrey,
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  }),
              const SizedBox(height: 40),
              ProfileTile(
                name: "My Orders",
                description: "Already have 10 orders",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OrdersScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              // BlocBuilder<RootCubit, RootState>(
              //     buildWhen: (previous, current) =>
              //     previous.currentUser != current.currentUser,
              //   builder: (context, state) {
              //     return ProfileTile(
              //       name: "Shipping Addresses",
              //       description: "${state.currentUser?.address.length ?? 0} Addresses",
              //       onTap: () {
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) => const ShippingAddressScreen(),
              //           ),
              //         );
              //       },
              //     );
              //   }
              // ),
              // const Spacer(),
              ProfileTile(
                name: "Payment Method",
                description: "You have cards",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentMethodsScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              ProfileTile(
                name: "My Reviews",
                description: "Reviews for 5 items",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyReviewsScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              ProfileTile(
                name: "Setting",
                description: "Notification, Password, FAQ, Contact",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsScreen(),
                    ),
                  );
                },
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<RootCubit, RootState>(
          listenWhen: (pre, current) =>
              pre.isImageAdding != current.isImageAdding,
          listener: (context, state) {
            if (state.isImageAdding) {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context)
                  .showSnackBar(AppSnackBar.loadingSnackBar);
            } else {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
            }
          },
        ),
        BlocListener<RootCubit, RootState>(
          listenWhen: (pre, current) =>
              pre.isImageAdding != current.isImageAdding,
          listener: (context, state) {
            if (state.isImageAdding) {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context)
                  .showSnackBar(AppSnackBar.loadingSnackBar);
            } else {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
            }
          },
        ),
      ],
      child: scaffold,
    );
  }
}
