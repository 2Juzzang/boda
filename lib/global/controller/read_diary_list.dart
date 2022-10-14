import 'package:pocketbase/pocketbase.dart';
import 'package:get/get.dart';

class ReadListController extends GetxController {
  final client = PocketBase('http://127.0.0.1:8090');
  final RxList id = [].obs;
  final RxList arr = [].obs;

  Future readDiaryList() async {
    var res = await client.records
        .getFullList('diaryList', batch: 200, sort: '-created');

    id(res.map((e) => e.id).toList());

    return arr(res.map((e) => e.data).toList());
  }

  @override
  void onInit() {
    readDiaryList();
    super.onInit();
  }
}
