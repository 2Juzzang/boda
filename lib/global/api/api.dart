import 'package:pocketbase/pocketbase.dart';
import 'package:http/http.dart' as http;

class Api {
  final client = PocketBase('http://127.0.0.1:8090');

  Future<List> readDiaryList() async {
    var res = await client.records
        .getFullList('diaryList', batch: 200, sort: '-created');

    return res.toList();
  }

  Future<List> getDiarys() async {
    var list = await client.records.getList('diary');
    return list.items;
  }

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

  Future<void> userCreate(Map<String, dynamic> body) async {
    await client.users.create(body: body).then((value) => print(value));
  }

  Future<Map<String, dynamic>> userLogin(String email, String password) async {
    return await client.users.authViaEmail(email, password).then((value) {
      return value.toJson();
    });
  }

  logout() {
    client.authStore.clear();
  }
}
