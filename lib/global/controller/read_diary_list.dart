import 'package:diary/global/api/api.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:get/get.dart';

class ReadListController extends GetxController {
  Api api = Api();
  final client = PocketBase('http://127.0.0.1:8090');
  final RxList arr = [].obs;

  readList() async {
    var res = await api.readDiaryList();

    return arr(res.map((e) {
      return {'listId': e.id, ...e.data};
    }).toList());
  }

  @override
  void onInit() {
    readList();
    super.onInit();
  }
}
