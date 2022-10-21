import 'package:diary/global/api/api.dart';
import 'package:diary/modules/user/controller/user_controller.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:get/get.dart';

class ReadListController extends GetxController {
  Api api = Api();
  final client = PocketBase('http://127.0.0.1:8090');
  final RxList diaryList = [].obs;
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  readList() async {
    _isLoading(true);
    var res = await api.readDiaryList();
    diaryList(res.map((e) {
      return {'listId': e.id, ...e.data};
    }).toList());
    await listFilter();
    _isLoading(false);
  }

  listFilter() {
    var user = Get.find<UserController>().user;
    if (user.isEmpty) {
      return;
    } else {
      return diaryList(diaryList
          .where((e) => e['author'] == user['user']['profile']['id'])
          .toList());
    }
  }

  @override
  void onInit() {
    ever(Get.put(UserController()).user, ((_) => readList()));
    super.onInit();
  }
}
