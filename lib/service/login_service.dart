import 'package:v2es/api/login_api.dart';
import 'package:v2es/model/login_model.dart';

class LoginService {



  static Future<LoginKey?> getCaptcha() async {
    LoginKey? loginKey = await LoginApi.getLoginKey();



    return null;
  }

  Future<String?>? login() {

    return null;
  }

}