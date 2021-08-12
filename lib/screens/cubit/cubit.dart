import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/network/end_point.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/screens/categories/categories_screen.dart';
import 'package:shop_app/screens/cubit/states.dart';
import 'package:shop_app/screens/favorites/favorites_screen.dart';
import 'package:shop_app/screens/products/products_screen.dart';
import 'package:shop_app/screens/settings/settings_screen.dart';
import 'package:shop_app/shared/constants.dart';

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

  HomeModel? homeModel;

  void getHomeData() {
    emit(ShopLoadingHomeDataStates());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJason(value.data);
      // print(homeModel.status);
      // print(homeModel.data.banners[0].image);
      emit(ShopSuccessHomeDataStates());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataStates());
    });
  }
}
