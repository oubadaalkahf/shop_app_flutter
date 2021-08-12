import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/homeScreen/categories/categories_screen.dart';
import 'package:shop_app/screens/homeScreen/cubit/states.dart';
import 'package:shop_app/screens/homeScreen/favorites/favorites_screen.dart';
import 'package:shop_app/screens/homeScreen/products/products_screen.dart';
import 'package:shop_app/screens/homeScreen/settings/settings_screen.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialStates());
  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(index) {
    currentIndex = index;

    emit(ShopChangeBottomNavStates());
  }
}
