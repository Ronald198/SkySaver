import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/constants.dart';
import 'package:travel_app/databaseHelper.dart';
import 'package:travel_app/main.dart';
import 'package:travel_app/models/coupon_model.dart';
import 'package:travel_app/widget/reuseable_text.dart';

class CouponsPage extends StatelessWidget {
  final EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 10.0);
  final Function navigatorCallback;

  const CouponsPage({super.key, required this.navigatorCallback});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    if (StaticVariables.userLoggedIn == null)
    {
      return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: _buildAppBar(size),
          body: SizedBox(
            width: size.width,
            height: size.height,
            child: Padding(
              padding: padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppText(
                    text: "My Coupons",
                    size: 35,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 272, bottom: 16),
                    child: Center(
                      child: Text("Log in to access coupons :)", style: TextStyle(color: Colors.black, fontSize: 36, fontWeight: FontWeight.w200), textAlign: TextAlign.center,),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: TextButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(SkySaverPalette.mainColor),
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                      ),
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                
                        navigatorCallback(3);
                      },
                      child: const Text("Log in")
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    Future<List<Coupon>> getCoupons() async {
      return await DatabaseHelper.instance.getCouponsByUserId(StaticVariables.userLoggedIn!.user_id);
    }

    return FutureBuilder<List<Coupon>>(
      future: getCoupons(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData)
        {
          List<Coupon> coupons = snapshot.data!;
          
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              appBar: _buildAppBar(size),
              body: SizedBox(
                width: size.width,
                height: size.height,
                child: Padding(
                  padding: padding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppText(
                        text: "My Coupons",
                        size: 35,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: coupons.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: FadeInUp(
                                delay: Duration(milliseconds: 150 * index + 150),
                                child: HorizontalCoupon(coupon: coupons[index],)
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            appBar: _buildAppBar(size),
            body: SizedBox(
              width: size.width,
              height: size.height,
              child: Padding(
                padding: padding,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: "My Coupons",
                      size: 35,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    Center(
                      child: Text("Loading..."),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
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
