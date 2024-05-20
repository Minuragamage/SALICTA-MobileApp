import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:salicta_mobile/ui/profile_page/views/edit_personal_info_screen.dart';
import 'package:salicta_mobile/theme/constants.dart';
import 'package:salicta_mobile/ui/root_page/root_cubit.dart';
import 'package:salicta_mobile/ui/root_page/root_state.dart';
import 'package:salicta_mobile/util/widgets/input/settings_text_box.dart';
import 'package:salicta_mobile/util/widgets/tiles/settings_row_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _toFAQ() {
    launchUrl(Uri.parse("https://www.youtube.com/watch?v=dQw4w9WgXcQ"));
  }

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
          "SETTING",
          style: kMerriweatherBold16,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        physics: const BouncingScrollPhysics(),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Personal Information",
                style: kNunitoSansSemiBold16TinGrey,
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const EditPersonalInformationScreen(),
                    ),
                  );
                },
                icon: SvgPicture.asset("assets/icons/edit_icon.svg"),
              ),
            ],
          ),
          BlocBuilder<RootCubit, RootState>(
              buildWhen: (previous, current) =>
                  previous.currentUser != current.currentUser,
              builder: (context, snapshot) {
                return SettingsTextBox(
                  fieldName: "Name",
                  value: "${snapshot.currentUser!.name}",
                );
              }),
          const SizedBox(height: 15),
          BlocBuilder<RootCubit, RootState>(
              buildWhen: (previous, current) =>
                  previous.currentUser != current.currentUser,
              builder: (context, snapshot) {
                return SettingsTextBox(
                  fieldName: "Email",
                  value: snapshot.currentUser!.email,
                );
              }),
          const SizedBox(height: 45),
          const Text(
            "Notifications",
            style: kNunitoSansSemiBold16TinGrey,
          ),
          const SizedBox(height: 10),
          SettingRowTile(
            fieldName: "Sales",
            action: CupertinoSwitch(
              value: true,
              onChanged: (val) {
                // controller.setSalesNotification(val);
              },
              activeColor: kSeaGreen,
            ),
          ),
          const SizedBox(height: 10),
          SettingRowTile(
            fieldName: "New Arrivals",
            action: CupertinoSwitch(
              value: true,
              onChanged: (val) {
                // controller.setNewArrivalsNotification(val);
              },
              activeColor: kSeaGreen,
            ),
          ),
          const SizedBox(height: 10),
          SettingRowTile(
            fieldName: "Delivery Status",
            action: CupertinoSwitch(
              value: true,
              onChanged: (val) {
                // _userController.setDeliveryStatusNotification(val);
              },
              activeColor: kSeaGreen,
            ),
          ),
          const SizedBox(height: 45),
          const Text(
            "Help Center",
            style: kNunitoSansSemiBold16TinGrey,
          ),
          const SizedBox(height: 15),
          SettingRowTile(
            fieldName: "FAQ",
            action: GestureDetector(
              onTap: _toFAQ,
              child: const Icon(
                Icons.arrow_forward_ios,
                color: kTinGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
