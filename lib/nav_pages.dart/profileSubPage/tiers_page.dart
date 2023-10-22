import 'package:flutter/material.dart';
import 'package:travel_app/main.dart';
import 'package:travel_app/widget/reuseable_text.dart';

class TiersPage extends StatefulWidget {
  const TiersPage({super.key});

  @override
  State<TiersPage> createState() => _TiersPageState();
}

class _TiersPageState extends State<TiersPage> {
  final EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 10.0);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: _buildAppBar(size),
      body: getBody(),
    );
  }

  Widget getBody() {
    double meterHeight = 150;
    double meterWidth = 95;
    double meterRadius = 25;
    int skypoints = StaticVariables.userLoggedIn!.user_skypoints;
    String tier;

    double tier1 = 1;
    double tier2 = 1;
    double tier3 = 1;
    double tier4 = 1;

    if (skypoints >= 0 && skypoints < 150)
    {
      tier = "Basic";
      tier1 = 1 - skypoints / 150;
    }
    else if (skypoints >= 150 && skypoints < 300)
    {
      tier = "Silver";
      tier1 = 0;
      tier2 = 1 - (skypoints  - 150) / 150;
    }
    else if (skypoints >= 300 && skypoints < 450)
    {
      tier = "Gold";
      tier1 = 0;
      tier2 = 0;
      tier3 = 1 - (skypoints  - 300) / 150;
    }
    else if(skypoints <= 600)
    {
      tier = "Diamond";
      tier1 = 0;
      tier2 = 0;
      tier3 = 0;
      tier4 = 1 - (skypoints  - 450) / 150;
    }
    else
    {
      tier1 = 0;
      tier2 = 0;
      tier3 = 0;
      tier4 = 0;
    }

    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                text: "Explore Tiers",
                size: 35,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 22),
                child: Column( //METER
                  children: [
                    Container(
                      height: meterHeight,
                      width: meterWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(meterRadius),
                          topRight: Radius.circular(meterRadius),
                        ),
                        border: Border.all(color: Colors.black, width: 2),
                        gradient: LinearGradient(
                          colors: const [
                            Color.fromARGB(0, 0, 0, 0),
                            Color(0xFFFFD700),
                          ],
                          stops: [
                            tier4, tier4
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter
                        ),
                      ),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text("Diamond")
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: const [
                            Color.fromARGB(0, 0, 0, 0),
                            Color(0xFFFFD700),
                          ],
                          stops: [
                            tier3, tier3
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter
                        ),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      height: meterHeight,
                      width: meterWidth,
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text("Gold")
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: const [
                            Color.fromARGB(0, 0, 0, 0),
                            Color(0xFFFFD700),
                          ],
                          stops: [
                            tier2, tier2
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter
                        ),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      height: meterHeight,
                      width: meterWidth,
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text("Silver")
                      ),
                    ),
                    Container(
                      height: meterHeight,
                      width: meterWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(meterRadius),
                          bottomRight: Radius.circular(meterRadius),
                        ),
                        gradient: LinearGradient(
                          colors: const [
                            Color.fromARGB(0, 0, 0, 0),
                            Color(0xFFFFD700),
                          ],
                          stops: [
                            tier1, tier1
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter
                        ),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text("Basic")
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text("Current Points:\n$skypoints SkyPoints", textAlign: TextAlign.center,),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Tiers help you take\nadvantage of\ndisocunts.", style: TextStyle(fontSize: 26),),
                    Divider(),
                    Text("Travel to gather\nmore SkyPoints.", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),),
                    Divider(),
                    Divider(),
                    Divider(),
                    Divider(),
                    Divider(),
                    Divider(),
                    Text("Progress through to\nget more coupons,\ngift and discounts.", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),),
                  ],
                ),
              ),
            ],
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