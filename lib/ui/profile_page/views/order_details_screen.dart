import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:salicta_mobile/ui/profile_page/views/edit_personal_info_screen.dart';
import 'package:salicta_mobile/theme/constants.dart';
import 'package:salicta_mobile/util/widgets/input/settings_text_box.dart';
import 'package:salicta_mobile/util/widgets/tiles/settings_row_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailsScreen extends StatelessWidget {
  OrderDetailsScreen({super.key});

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
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditPersonalInformationScreen(),
                    ),
                  );
                },
                icon: SvgPicture.asset("assets/icons/edit_icon.svg"),
              ),
            ],
          ),
          const SettingsTextBox(
            fieldName: "Name",
            value:" _userController.userData.name",
          ),
          const SizedBox(height: 15),
          const SettingsTextBox(
            fieldName: "Email",
            value: "_userController.userData.email",
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Password",
                style: kNunitoSansSemiBold16TinGrey,
              ),
              IconButton(
                onPressed:(){},
                icon: SvgPicture.asset("assets/icons/edit_icon.svg"),
              ),
            ],
          ),
          const SettingsTextBox(
            fieldName: "Password",
            value: "*************",
          ),
          const SizedBox(height: 25),
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
          const SizedBox(height: 25),
          const Text(
            "Help Center",
            style: kNunitoSansSemiBold16TinGrey,
          ),
          const SizedBox(height: 10),

        ],
      ),
    );
  }
}
