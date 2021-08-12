import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/screens/login/LoginScreen.dart';
import 'components.dart';

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      navigateAndFinish(context, LoginScreen());
      showToast(message: 'Signing Out Successful');
    }
  });
}

String token = '';
