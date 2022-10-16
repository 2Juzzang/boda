import 'package:diary/global/api/api.dart';
import 'package:diary/modules/home/screens/main_screen.dart';
import 'package:diary/modules/user/screens/login_screen.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  Api api = Api();
  RxString? token = ''.obs;
  RxMap user = RxMap<String, dynamic>({});
  signUp(body) {
    api
        .userCreate(body)
        .then((_) => print('가입완료'))
        .then((_) => Get.to(() => Login()));
  }

  login(email, password) async {
    var res = await api.userLogin(email, password);
    user(res);
    return Get.to(() => Home());
  }

  logout() async {
    user.clear();
    await api.logout();
    Get.offAll(() => Login());
  }
}
