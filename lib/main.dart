import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/screens/cubit/cubit.dart';
import 'package:shop_app/screens/cubit/states.dart';
import 'package:shop_app/screens/login/LoginScreen.dart';
import 'package:shop_app/screens/homeScreen/homeScreen.dart';
import 'package:shop_app/screens/login/cubit/cubit_observer.dart';

import 'package:shop_app/screens/register/registerScreen.dart';
import 'package:shop_app/screens/onBoarding/OnBoardingScreen.dart';
import 'package:shop_app/shared/colors.dart';
import 'package:shop_app/shared/constants.dart';

import 'network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  bool onBoarding = false;
  Widget widget;
  try {
    onBoarding = CacheHelper.getData(key: 'onboarding');
    token = CacheHelper.getData(key: 'token');
  } catch (e) {
    print(e);
  }
  print('token is ');
  print(token);
  if (onBoarding != false) {
    if (token == '')
      widget = LoginScreen();
    else
      widget = HomeScreen();
  } else
    widget = OnBoardingScreen();

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({required this.startWidget});
  final Widget startWidget;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => ShopCubit()
                ..getHomeData()
                ..getCategories())
        ],
        child: BlocConsumer<ShopCubit, ShopStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                    bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      selectedItemColor: defaultColor,
                      unselectedItemColor: Colors.grey,
                    ),
                    fontFamily: 'Comfortaa',
                    primarySwatch: defaultColor,
                    primaryColor: Colors.deepOrange,
                    scaffoldBackgroundColor: Colors.white,
                    appBarTheme: AppBarTheme(
                      iconTheme: IconThemeData(color: Colors.black),
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
                          color: Colors.grey,
                          fontSize: 18.0),
                    )),
                home: startWidget,
                initialRoute: OnBoardingScreen.id,
                routes: {
                  LoginScreen.id: (context) => LoginScreen(),
                  RegisterScreen.id: (context) => RegisterScreen(),
                  HomeScreen.id: (context) => HomeScreen(),
                });
          },
        ));
  }
}
