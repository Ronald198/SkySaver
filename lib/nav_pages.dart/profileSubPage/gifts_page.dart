import 'dart:async';

import 'package:flutter/material.dart';
import 'package:travel_app/constants.dart';
import 'package:travel_app/main.dart';
import 'package:travel_app/widget/reuseable_text.dart';

class GiftsPage extends StatefulWidget {
  const GiftsPage({super.key});

  @override
  State<GiftsPage> createState() => _GiftsPageState();
}

class _GiftsPageState extends State<GiftsPage> {
  final EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 10.0);
  Timer? timer;
  PageController pageController = PageController(initialPage: 0,);
  int currentPage = 0;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (currentPage < 3) {
        currentPage++;
      } else {
        currentPage = 0;
      }

      pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    
    timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: _buildAppBar(size),
      body: getBody(),
    );
  }

  Widget getBody() {
    int miles = StaticVariables.userLoggedIn!.user_miles;

    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
              const AppText(
                text: "Milestones",
                size: 35,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 30),
            child: Text("Every 5000 miles travelled, you earn a gift from us!", style: TextStyle(fontSize: 26), textAlign: TextAlign.center,),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32),
            child: Container(
              height: 350,
              width: 350,
              decoration: const BoxDecoration(
                color: SkySaverPalette.mainColor,
                borderRadius: BorderRadius.all(Radius.circular(500))
              ),
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                children: [
                  Image.asset("assets/gifts/luggage.png", scale: 7,),
                  Image.asset("assets/gifts/keyring2.png", scale: 2,),
                  Image.asset("assets/gifts/coupons.png", scale: 2,),
                  Image.asset("assets/gifts/keyring1.png", scale: 2.5,),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text("Your miles: $miles", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w300), textAlign: TextAlign.center,),
          ),
        ],
      ),
    );
  }

  PreferredSize _buildAppBar(Size size) {
    return PreferredSize(
      preferredSize: Size.fromHeight(size.height * 0.05),
      child: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
    );
  }
}