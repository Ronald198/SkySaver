import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/constants.dart';
import 'package:travel_app/databaseHelper.dart';
import 'package:travel_app/main.dart';
import 'package:travel_app/widget/reuseable_text.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey();
  final EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 10.0);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    PreferredSize buildAppBar(Size size) {
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
    
    if (StaticVariables.userLoggedIn != null)
    {
      int skypoints = StaticVariables.userLoggedIn!.user_skypoints;
      int skypointsToAdvance;
      String tier;
      String advanceMessage;

      if (skypoints >= 0 && skypoints < 150)
      {
        tier = "Basic";
        skypointsToAdvance = 150 - skypoints;
        advanceMessage = "+$skypointsToAdvance to Silver";
      }
      else if (skypoints >= 150 && skypoints < 300)
      {
        tier = "Silver";
        skypointsToAdvance = 300 - skypoints;
        advanceMessage = "+$skypointsToAdvance to Gold";
      }
      else if (skypoints >= 300 && skypoints < 450)
      {
        tier = "Gold";
        skypointsToAdvance = 450 - skypoints;
        advanceMessage = "+$skypointsToAdvance to Diamond";
      }
      else
      {
        tier = "Diamond";
        advanceMessage = "Diamond Tier.";
      }

      return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: buildAppBar(size),
          body: SizedBox(
            width: size.width,
            height: size.height,
            child: Padding(
              padding: padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const AppText(
                        text: "My Profile",
                        size: 35,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      IconButton(
                        onPressed: () {
                          StaticVariables.userLoggedIn = null;
                          StaticVariables.skysaverSharedPreferences!.setString("loggedUserEmail", "");

                          setState(() {});
                        },
                        icon: const Icon(Icons.logout, color: Colors.black, size: 32,)
                      )
                    ],
                  ),
                  Padding( // KARTA
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 255,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/profilePage/cardWave.jpg"),
                              fit: BoxFit.cover
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(55),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(StaticVariables.userLoggedIn!.user_name, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w300),),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 4),
                                          child: Text(tier, style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w400),),
                                        ),
                                      ],
                                    ),
                                    const Text("SkyClub", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16, bottom: 16, right: 24),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${StaticVariables.userLoggedIn!.user_skypoints} SkyPoints", style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 4),
                                          child: Text(advanceMessage, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w300),),
                                        ),
                                      ],
                                    ),
                                    // const Text("SkyClub", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: 200,
                          height: 140,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(24)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color: Colors.white
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Miles travelled:", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 19),),
                                Text(StaticVariables.userLoggedIn!.user_miles.toString(), style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w200),),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {

                          },
                          borderRadius: const BorderRadius.all(Radius.circular(24)),
                          child: Ink(
                            width: 145,
                            height: 140,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(24)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3), // changes position of shadow
                                ),
                              ],
                              color: Colors.white
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(Icons.auto_graph, size: 40,),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text("Tiers", style: TextStyle(fontSize: 24),),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: InkWell(
                      onTap: () {
                        
                      },
                      borderRadius: const BorderRadius.all(Radius.circular(24)),
                      child: Ink(
                        width: double.infinity,
                        height: 140,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(24)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          image: const DecorationImage(
                            image: AssetImage("assets/profilePage/awardWave.jpg"),
                            fit: BoxFit.cover
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Color.fromARGB(232, 255, 255, 255),
                                    radius: 32,
                                    child: FaIcon(
                                      FontAwesomeIcons.gift,
                                      color: SkySaverPalette.mainColor,
                                      size: 26,
                                    )
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: Text("View your gifts", style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w200),),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
      child: SingleChildScrollView(
        child: Column(
          children: [
            FadeInUp(
              delay: const Duration(milliseconds: 300),
              child: const AppText(
                text: "My Profile                  ",
                size: 35,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            FadeInUp(
              delay: const Duration(milliseconds: 500),
              child: const Padding(
                padding:  EdgeInsets.only(top: 12),
                child: Text("Hello, log in to your SkyClub account.", style: TextStyle(fontSize: 36, fontWeight: FontWeight.w200),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 22),
              child: Form(
                key: loginFormKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: FadeInLeft(
                        delay: const Duration(milliseconds: 850),
                        child: TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Email",
                            labelStyle: TextStyle(color: Color.fromARGB(128, 0, 0, 0)),
                          ),
                          validator: (value) {
                            if (value == "") {
                              return "Add email!";
                            }
      
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: FadeInLeft(
                        delay: const Duration(milliseconds: 750),
                        child: TextFormField(
                          controller: passwordController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Password",
                            labelStyle: TextStyle(color: Color.fromARGB(128, 0, 0, 0)),
                          ),
                          validator: (value) {
                            if (value == "") {
                              return "Add password!";
                            }
      
                            return null;
                          },
                          obscureText: true,
                        ),
                      ),
                    ),
                  ],
                )
              ),
            ),
            FadeInLeft(
              delay: const Duration(milliseconds: 650),
              child: SizedBox(
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
                  onPressed: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
            
                    if (loginFormKey.currentState!.validate())
                    {
                      User? user = await DatabaseHelper.instance.getUserByUserEmail(emailController.text);

                      if (user == null)
                      {
                        if(context.mounted)
                        {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: const Text("User Not Found!"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Ok")
                                  )
                                ],
                              );
                            }
                          );
                        }
                      }
                      else
                      {
                        if (user.user_password == passwordController.text)
                        {
                          StaticVariables.userLoggedIn = user;

                          if(context.mounted)
                          {
                            StaticVariables.skysaverSharedPreferences!.setString("loggedUserEmail", emailController.text);

                            setState(() {});
                          }
                        }
                        else
                        {
                          if(context.mounted)
                          {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: const Text("Incorrect Password!"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Ok")
                                    )
                                  ],
                                );
                              }
                            );
                          }
                        }
                      }
                    }
                  },
                  child: const Text("Log in")
                ),
              ),
            ),
            FadeIn(
              delay: const Duration(milliseconds: 750),
              child: const Padding(
                padding: EdgeInsets.all(48),
                child: Text("or", style: TextStyle(color:Color.fromARGB(128, 0, 0, 0)),),
              ),
            ),
            FadeInUp (
              delay: const Duration(milliseconds: 750),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Not yet a member?", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),),
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: GestureDetector(
                        onTap: () {
                          
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/membershipBg.png"),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                          ),
                          width: double.infinity,
                          height: 128,
                          child: const Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("Join", style: TextStyle(fontSize: 14, color: Colors.white),),
                                Text("SkyClub", style: TextStyle(fontSize: 18, color: Colors.white),),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
