import 'package:pocketbase/pocketbase.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CreateController extends GetxController {
  final client = PocketBase('http://127.0.0.1:8090');

  Future createTodayDiary(Map<String, dynamic> diary) async {
    if (diary['images'] == null) {
      await client.records.create('diary', body: diary);
    } else {
      await client.records.create('diary',
          body: diary,
          files: [await http.MultipartFile.fromPath('image', diary['image'])]);
    }
  }
}
