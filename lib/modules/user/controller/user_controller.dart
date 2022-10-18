import 'package:diary/global/api/api.dart';
import 'package:diary/global/controller/read_diary_list.dart';
import 'package:diary/global/controller/read_diarys.dart';
import 'package:diary/modules/home/screens/main_screen.dart';
import 'package:diary/modules/user/screens/login_screen.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  Api api = Api();
  RxString? token = ''.obs;
  RxMap user = RxMap<String, dynamic>({});
  RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;
  signUp(body) {
    api
        .userCreate(body)
        .then((_) => print('가입완료'))
        .then((_) => Get.to(() => Login()));
  }

  login(email, password) async {
    _isLoading(true);
    var res = await api.userLogin(email, password);
    user(res);
    _isLoading(false);
    Get.offAll(() => Home());
  }

  listFilter() {
    var list = Get.find<ReadListController>().arr;
    if (user.isEmpty) {
      return;
    } else {
      return list(list
          .where((e) => e['author'] == user['user']['profile']['id'])
          .toList());
    }
  }

  logout() {
    user.clear();
    Get.find<ReadListController>().readList();
    Get.find<ReadDiarysController>().diarys.clear();
    api.logout();
    Get.offAll(() => Login());
  }

  @override
  void onInit() {
    ever(user, ((_) => listFilter()));
    super.onInit();
  }
}
