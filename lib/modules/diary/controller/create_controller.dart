import 'package:diary/global/controller/read_diarys.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../global/controller/read_diary_list.dart';

class CreateController extends GetxController {
  String id;
  CreateController({required this.id});
  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final client = PocketBase('http://127.0.0.1:8090');

  Future<bool> createTodayDiary(Map<String, dynamic> diary) async {
    if (diary['images'] == null) {
      _isLoading(true);
      client.records.create('diary', body: diary);
      await Get.find<ReadDiarysController>().readDiarys();

      _isLoading(false);
    } else {
      client.records.create('diary',
          body: diary,
          files: [await http.MultipartFile.fromPath('image', diary['image'])]);
      await Get.find<ReadDiarysController>().readDiarys();
    }
    return true;
  }
}
