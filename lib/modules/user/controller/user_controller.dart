import 'package:diary/global/api/api.dart';
import 'package:diary/global/controller/read_diary_list.dart';
import 'package:flutter/material.dart';
import 'package:diary/modules/home/screens/main_screen.dart';
import 'package:diary/modules/user/screens/login_screen.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  Api api = Api();
  RxString? token = ''.obs;
  RxMap user = RxMap<String, dynamic>({});
  RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;
  signUp(body) async {
    _isLoading(true);
    await api.userCreate(body).then((_) => Get.snackbar(
        '', '가입완료! 로그인을 진행해주세요.',
        titleText: Container(), snackPosition: SnackPosition.BOTTOM));
    _isLoading(false);
    Get.to(() => Login());
  }

  login(email, password) async {
    _isLoading(true);
    var res = await api.userLogin(email, password);
    user(res);

    _isLoading(false);
    Get.offAll(() => Home());
  }

  logout() async {
    await api.logout();
    Get.offAll(() => Login());
  }
}
