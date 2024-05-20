import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:salicta_mobile/ui/cart_view/cart_provider.dart';
import 'package:salicta_mobile/ui/home_page/views/favorite_screen.dart';
import 'package:salicta_mobile/theme/constants.dart';
import 'package:salicta_mobile/ui/home_page/home_provider.dart';
import 'package:salicta_mobile/ui/notification_page/views/notification_screen.dart';
import 'package:salicta_mobile/ui/profile_page/profile_provider.dart';
import 'package:salicta_mobile/ui/profile_page/views/profile_view.dart';

import '../../../ui/home_page/views/home_view.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<StatefulWidget> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedPos = 0;

  @override
  Widget build(BuildContext context) {
    final navBar = BottomNavigationBar(
      landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
      elevation: 12,
      currentIndex: selectedPos,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color(0xe7edf6f1),
      onTap: (pos) {
        setState(() {
          selectedPos = pos;
        });
      },
      items: [
        BottomNavigationBarItem(
          label: "home",
          icon: SvgPicture.asset(
            'assets/icons/home_icon.svg',
              color: kOffBlack.withOpacity(0.6)
          ),
          activeIcon: SvgPicture.asset("assets/icons/home_selected_icon.svg",color: kOffBlack),
        ),
        BottomNavigationBarItem(
          label: "favorite",
          icon: SvgPicture.asset(
            'assets/icons/cart-outline.svg',
              color: kOffBlack.withOpacity(0.6),
            height: 30,
          ),
          activeIcon:
              SvgPicture.asset('assets/icons/cart_solid.svg',color: kOffBlack,  height: 30,fit: BoxFit.fill),
        ),
        BottomNavigationBarItem(
          label: "notification",
          icon: SvgPicture.asset(
            'assets/icons/notification_icon.svg',
              color: kOffBlack.withOpacity(0.6)
          ),
          activeIcon:
              SvgPicture.asset('assets/icons/notification_selected_icon.svg',color: kOffBlack),
        ),
        BottomNavigationBarItem(
          label: "person",
          icon: SvgPicture.asset(
            'assets/icons/person_icon.svg',
              color: kOffBlack.withOpacity(0.6)
          ),
          activeIcon: SvgPicture.asset('assets/icons/person_selected_icon.svg',color: kOffBlack),
        ),
      ],
    );

    List<Widget> tabs = [
      HomeProvider(),
      CartProvider(),
      const NotificationScreen(),
      ProfileProvider(),
    ];

    final scaffold = Scaffold(
      body: tabs[selectedPos],
      bottomNavigationBar: navBar,
    );

    return scaffold;
  }
}
