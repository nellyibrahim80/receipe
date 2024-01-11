import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:receipe/screens/splash_screen.dart';
import 'package:receipe/services/shared_pref.dart';
import 'package:receipe/utilities/abstract_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cubit/adv_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    //SharedPrefClass.pref = await SharedPreferences.getInstance();
    var pref = await SharedPreferences.getInstance();
    GetIt.I.registerSingleton<SharedPreferences>(pref);

    if (SharedPrefClass.pref != null) {
      print("***************Pref Created Successfully*************");
      //SharedPrefClass.pref.clear();
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
    return BlocProvider(
      create: (context) => AdvCubit(),
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
