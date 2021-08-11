import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shopLoginModel.dart';
import 'package:shop_app/network/end_point.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/screens/login/cubit/states.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialStates());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
  late ShopLoginModel loginModel;
  void userLogin({required String email, required String password}) {
    emit(ShopLoginLoadingStates());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      print('here');
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopLoginSuccessStates(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorStates(error.toString()));
    });
  }
}
