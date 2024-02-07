import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:provider/provider.dart';

import 'package:receipe/providers/auth_provider.dart';
import 'package:receipe/providers/ingredient_provider.dart';
import 'package:receipe/providers/read_ads_fire_provider.dart';
import 'package:receipe/providers/recipe_fire_provider.dart';
import 'package:receipe/screens/splash_screen.dart';
import 'package:receipe/services/shared_pref.dart';
import 'package:receipe/utilities/abstract_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );



  } catch (e) {
    print("*************** Error Firebase.initializeApp main page*************");
    print(e);
  }

  runApp(MultiProvider(providers: [

    ChangeNotifierProvider(
      create: (context) => AuthFirebaseProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => ReadFireAdsProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => RecipeFireProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => IngredientFireProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OverlayKit(
      appPrimaryColor:Color(ConstColors.titleColors) ,
      child: MaterialApp(
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
      ),
    );
  }
}
