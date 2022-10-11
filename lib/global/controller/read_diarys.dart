import 'package:pocketbase/pocketbase.dart';
import 'package:get/get.dart';

class ReadDiarysController extends GetxController {
  final client = PocketBase('http://127.0.0.1:8090');
  final RxList diarys = [].obs;

  Future readDiarys() async {
    var res =
        await client.records.getFullList('diary', batch: 200, sort: '-created');
    return diarys(res.map((e) => e.data).toList());
  }

  filter(id) {
    // print(id);
    var res = diarys.where((element) => element['parent'] == id);
    return diarys(res.map((e) => e).toList());
  }

  @override
  void onInit() {
    readDiarys();
    super.onInit();
  }
}
