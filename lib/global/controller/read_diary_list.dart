import 'package:diary/global/api/api.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:get/get.dart';

class ReadListController extends GetxController {
  Api api = Api();
  final client = PocketBase('http://127.0.0.1:8090');
  final RxList diaryList = [].obs;
  final RxBool _isLoading = false.obs;

  readList() async {
    var res = await api.readDiaryList();
    return diaryList(res.map((e) {
      return {'listId': e.id, ...e.data};
    }).toList());
  }

  List(userId) async {
    _isLoading(true);
    var list = await api.DiaryList();
    diaryList(list.map((e) => e.toJson()).toList());
    var res = diaryList.where((e) => e['author'] == userId);
    diaryList(res.map((e) {
      print(e);
      return e;
    }).toList());
    _isLoading(false);
  }

  @override
  void onInit() {
    readList();
    super.onInit();
  }
}
