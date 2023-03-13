import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallpapers/pages/settings.dart';
import 'package:wallpapers/pages/home.dart';
import 'package:wallpapers/pages/search.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _index = 0;

  void _onTap(int index) {
    setState(() {
      _index = index;
    });
  }

  final List _pages = [const Home(), const Search(), const Settings()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        showUnselectedLabels: false,
        onTap: _onTap,
        currentIndex: _index,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/home.svg',
              height: 23,
            ),
            label: 'Home',
            activeIcon: SvgPicture.asset(
              'assets/icons/home.svg',
              color: Colors.lightBlue,
              height: 23,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/search.svg',
              height: 24,
            ),
            label: 'Search',
            activeIcon: SvgPicture.asset(
              'assets/icons/search.svg',
              height: 24,
              color: Colors.lightBlue,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/settings.svg',
              height: 24,
            ),
            label: 'Settings',
            activeIcon: SvgPicture.asset(
              'assets/icons/settings.svg',
              color: Colors.lightBlue,
              height: 24,
            ),
          )
        ],
      ),
      body: _pages[_index],
    );
  }
}
