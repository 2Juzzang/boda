import 'package:diary/global/api/api.dart';
import 'package:diary/global/controller/read_diary_list.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:get/get.dart';

class ReadDiarysController extends GetxController {
  Api api = Api();
  final client = PocketBase('http://127.0.0.1:8090');
  final RxList diarys = [].obs;
  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  getDiarys(listId) async {
    _isLoading(true);
    var list = await api.getDiarys();
    diarys(list.map((e) => e.toJson()).toList());
    var res = diarys.where((e) => e['listId'] == listId);
    // print(res);
    diarys(res.map((e) => e).toList());
    // print(diarys);
    _isLoading(false);
  }

  deleteAllDiarys(listId) async {
    _isLoading(true);
    // 리스트 삭제를 위해서 연결된 일기들 삭제
    await api.deleteAllDiarys(listId);
    await api.listDelete(listId);
    _isLoading(false);
    Get.find<ReadListController>().readList();
  }

  // feeling(listId) async {
  //   // _isLoading(true);
  //   var res = await api.test(listId);
  //   // print(res);

  //   // _isLoading(false);
  // }

  // @override
  // void onInit() {
  //   ever(diarys, ((_) => feeling(_)));
  //   super.onInit();
  // }
}
