import 'package:diary/global/api/api.dart';
import 'package:get/get.dart';

class ViewController extends GetxController {
  String id;
  ViewController({required this.id});
  Api api = Api();
  RxMap diary = RxMap<String, dynamic>({});
  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  getDetailView(id) async {
    _isLoading(true);
    var res = await api.getTodayDiary(id);
    diary(res);
    _isLoading(false);
  }

  void removeData() {
    diary.value = {};
  }

  @override
  void onInit() {
    getDetailView(id);
    super.onInit();
  }
}
