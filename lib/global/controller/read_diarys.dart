import 'package:diary/global/api/api.dart';
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
    diarys(res.map((e) => e).toList());
    _isLoading(false);
  }
}
