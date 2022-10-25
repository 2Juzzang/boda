import 'package:diary/global/controller/read_diarys.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../global/controller/read_diary_list.dart';

class CreateController extends GetxController {
  String listId;
  CreateController({required this.listId});
  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final client = PocketBase('http://127.0.0.1:8090');

  Future<bool> createTodayDiary(Map<String, dynamic> diary) async {
    if (diary['image'] == null) {
      _isLoading(true);
      await client.records.create('diary', body: diary);
      _isLoading(false);
    } else {
      _isLoading(true);
      await client.records.create('diary', body: diary, files: [
        await http.MultipartFile.fromPath('image', diary['image'])
      ]).then((_) => _isLoading(false));
    }
    return true;
  }
}
