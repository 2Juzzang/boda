import 'package:pocketbase/pocketbase.dart';
import 'package:http/http.dart' as http;

class Api {
  final client = PocketBase('http://127.0.0.1:8090');

  Future<Map<String, dynamic>> getTodayDiary(String id) async {
    RecordModel res = await client.records.getOne('diary', id);

    return res.data;
  }

  Future<void> createTodayDiary(Map<String, dynamic> diary) async {
    if (diary['images'] == null) {
      await client.records.create('diary', body: diary);
    } else {
      await client.records.create('diary',
          body: diary,
          files: [await http.MultipartFile.fromPath('image', diary['image'])]);
    }
  }
}
