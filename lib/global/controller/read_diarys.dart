import 'package:pocketbase/pocketbase.dart';
import 'package:get/get.dart';

class ReadDiarysController extends GetxController {
  final client = PocketBase('http://127.0.0.1:8090');
  final RxList diarys = [].obs;
  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;
  Future<List> readDiarys() async {
    var res =
        await client.records.getFullList('diary', batch: 200, sort: '-created');

    //res[0] .을 찍어 메서드를 확인하고
    //spread 문법을 쓸 수도 있다.
    // res.map((e) {
    //   return {
    //     ...e.data,
    //     'id': e.id,
    //     'created': e.created,
    //   };
    // }).toList();
    return diarys(res.map((e) => e.toJson()).toList());
  }

  filter(id) {
    _isLoading(true);
    var res = diarys.where((element) => element['parent'] == id);
    diarys(res.map((e) => e).toList());
    _isLoading(false);
  }

  @override
  void onInit() {
    readDiarys();
    super.onInit();
  }
}
