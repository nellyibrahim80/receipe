import 'package:flutter/material.dart';
import 'package:receipe/screens/splash_screen.dart';
import 'package:receipe/services/shared_pref.dart';
import 'package:receipe/utilities/abstract_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    SharedPrefClass.pref = await SharedPreferences.getInstance();
    if (SharedPrefClass.pref != null) {
      print("***************Pref Created Successfully*************");
    }
  } catch (e) {
    print("***************Pref Error*************");
    print(e);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe',
      theme: ThemeData(

        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(
                    const Color(ConstColors.whiteColor)),
                backgroundColor: MaterialStateProperty.all(
                    const Color(ConstColors.titleColors)),
                fixedSize: MaterialStateProperty.all(Size(350, 50)))),
        colorScheme: ColorScheme.fromSeed(
            primary: Color(ConstColors.whiteColor),
            seedColor: const Color(ConstColors.titleColors)),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
