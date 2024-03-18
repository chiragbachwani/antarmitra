import 'package:antarmitra/screens/Homesceen.dart';
import 'package:antarmitra/screens/community.dart';
import 'package:antarmitra/screens/exercise.dart';
import 'package:antarmitra/screens/meditation.dart';
import 'package:antarmitra/screens/profile.dart';
import 'package:antarmitra/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key, required this.apiCode});

  final String apiCode;

  @override
  Widget build(BuildContext context) {
    PersistentTabController controller;

    controller = PersistentTabController(initialIndex: 0);

    List<Widget> buildScreens() {
      return [
        Home(
          apiCode: apiCode,
        ),
        const Community(),
        const Meditation(),
        const Exercise(),
        const Profile()
      ];
    }

    List<PersistentBottomNavBarItem> navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          inactiveColorPrimary: AppColor.fifth,
          activeColorPrimary: AppColor.sixth,
          title: ("Home"),
          // activeColorPrimary: CupertinoColors.activeBlue,
          // inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.people),
          title: ("Community"),
          inactiveColorPrimary: AppColor.fifth,
          activeColorPrimary: AppColor.sixth,
          // activeColorPrimary: CupertinoColors.activeBlue,
          // inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.video_call),
          title: ("Meditation"),
          inactiveColorPrimary: AppColor.fifth,
          activeColorPrimary: AppColor.sixth,
          // activeColorPrimary: CupertinoColors.activeBlue,
          // inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.sports_gymnastics),
          title: ("Exercise"),
          inactiveColorPrimary: AppColor.fifth,
          activeColorPrimary: AppColor.sixth,
          // activeColorPrimary: CupertinoColors.activeBlue,
          // inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.person),
          title: ("Profile"),
          inactiveColorPrimary: AppColor.fifth,
          activeColorPrimary: AppColor.sixth,
          // activeColorPrimary: CupertinoColors.activeBlue,
          // inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
      ];
    }

    return PersistentTabView(
      context,
      controller: controller,
      screens: buildScreens(),
      items: navBarsItems(),
      confineInSafeArea: true,

      backgroundColor: AppColor.first, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: AppColor.first,
      ),
      navBarHeight: 70,
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 500),
      ),
      navBarStyle:
          NavBarStyle.style15, // Choose the nav bar style with this property.
    );
  }
}
