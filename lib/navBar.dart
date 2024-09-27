import 'package:flutter/material.dart';
import 'package:antarmitra/screens/community_posts/comm_posts.dart';
import 'package:antarmitra/screens/exercise.dart';
import 'package:antarmitra/screens/meditation.dart';
import 'package:antarmitra/screens/profile.dart';
import 'package:antarmitra/utils/app_color.dart';
import 'package:antarmitra/screens/mediationDialog.dart';
import 'package:antarmitra/screens/homescreen.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    Home(),
    const CommunityPosts(),
    const DialogMeditation(),
    const Exercise(),
    const Profile()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: BottomNavigationBar(
            backgroundColor: AppColor.first,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: 'Community',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.video_camera_front_rounded),
                label: 'Meditation',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.sports_gymnastics),
                label: 'Exercise',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: AppColor.sixth,
            unselectedItemColor: AppColor.fifth,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }
}