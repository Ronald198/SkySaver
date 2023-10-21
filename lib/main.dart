
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/databaseHelper.dart';
import 'package:travel_app/nav_pages.dart/main_wrapper.dart';

import '../pages/welcome_page.dart';

class StaticVariables {
  static User? userLoggedIn;
  static SharedPreferences? skysaverSharedPreferences;
  static int rootPageIndex = 0;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  StaticVariables.skysaverSharedPreferences = await SharedPreferences.getInstance();

  if (StaticVariables.skysaverSharedPreferences!.containsKey("loggedUserEmail"))
  {
    String? userEmail = StaticVariables.skysaverSharedPreferences!.getString("loggedUserEmail");

    if (userEmail != "")
    {
      StaticVariables.userLoggedIn = await DatabaseHelper.instance.getUserByUserEmail(userEmail!);
    }
  }
  else
  {
    await StaticVariables.skysaverSharedPreferences!.setString("loggedUserEmail", "");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) { 
    return MaterialApp(
      title: 'SkySaver',
      debugShowCheckedModeBanner: false,
      home: StaticVariables.userLoggedIn == null ? const WelcomePage() : const MainWrapper()
    );
  }
}
