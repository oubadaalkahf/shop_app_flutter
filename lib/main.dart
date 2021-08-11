import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/screens/login/LoginScreen.dart';
import 'package:shop_app/screens/homeScreen/homeScreen.dart';
import 'package:shop_app/screens/login/cubit/cubit_observer.dart';

import 'package:shop_app/screens/register/registerScreen.dart';
import 'package:shop_app/screens/onBoarding/OnBoardingScreen.dart';
import 'package:shop_app/shared/colors.dart';

import 'network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  bool onBoarding = false;
  try {
    onBoarding = CacheHelper.getData(key: 'onboarding');
  } catch (e) {
    print(e);
  }

  runApp(MyApp(
    onBoarding: onBoarding,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({required this.onBoarding});
  bool onBoarding;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'Comfortaa',
            primarySwatch: defaultColor,
            primaryColor: Colors.deepOrange,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 25.0,
                color: Colors.black,
              ),
              backwardsCompatibility: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
              ),
              backgroundColor: Colors.white,
              elevation: 0.0,
            ),
            textTheme: TextTheme(
              bodyText1: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 18.0),
            )),
        home: onBoarding ? LoginScreen() : OnBoardingScreen(),
        initialRoute: OnBoardingScreen.id,
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          RegisterScreen.id: (context) => RegisterScreen(),
          HomeScreen.id: (context) => HomeScreen(),
        });
  }
}
