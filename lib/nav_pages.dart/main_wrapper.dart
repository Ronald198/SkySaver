import 'package:flutter/material.dart';
import 'package:travel_app/constants.dart';
import 'package:travel_app/main.dart';

import 'offers_page.dart';
import 'profile_page.dart';
import 'coupons_page.dart';
import '../pages/home_page.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  late final PageController pageController;
  int currentIndex = 0;
  late List<Widget> pages;

  @override
  void initState() {
    pages = [
      const HomePage(),
      OffersPage(),
      CouponsPage(navigatorCallback: onTap),
      const ProfilePage(),
    ];

    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 400), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: StaticVariables.rootPageIndex,
        onTap: onTap,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedLabelStyle: const TextStyle(color: SkySaverPalette.mainColor),
        unselectedLabelStyle: const TextStyle(color: SkySaverPalette.mainColor),
        selectedItemColor:  SkySaverPalette.mainColor,
        unselectedItemColor: SkySaverPalette.mainColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: SkySaverPalette.mainColor,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.discount, color: SkySaverPalette.mainColor,),
            label: 'Offers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet_giftcard_rounded, color: SkySaverPalette.mainColor,),
            label: 'My coupons',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: SkySaverPalette.mainColor,),
            label: 'Profile',
          ),
        ],
      ),
    ));
  }
}


//  BottomNavigationBar(
//           unselectedFontSize: 0,
//           selectedFontSize: 0,
//           type: BottomNavigationBarType.fixed,
//           currentIndex: currentIndex,
//           showSelectedLabels: false,
//           showUnselectedLabels: false,
//           backgroundColor: Colors.white,
//           onTap: onTap,
//           elevation: 0,
//           unselectedItemColor: Colors.grey,
//           selectedItemColor: SkySaverPalette.mainColor,
//           items: const [
//             BottomNavigationBarItem(
//               label: "Home",
//               icon: Icon(
//                 Icons.apps_rounded,
//               ),
//             ),
//             BottomNavigationBarItem(
//               label: "Bar",
//               icon: Icon(
//                 Icons.bar_chart_sharp,
//               ),
//             ),
//             BottomNavigationBarItem(
//               label: "Search",
//               icon: Icon(
//                 Icons.search,
//               ),
//             ),
//             BottomNavigationBarItem(
//               label: "My Profile",
//               icon: Icon(
//                 Icons.person,
//               ),
//             ),
//           ],
//         ),