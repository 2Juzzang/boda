import 'package:diary/global/controller/read_diary_list.dart';
import 'package:diary/modules/user/controller/user_controller.dart';
import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:http/http.dart' as http;

class Api {
  final client = PocketBase('http://127.0.0.1:8090');

//User
  Future<void> userCreate(Map<String, dynamic> body) async {
    await client.users.create(body: body);
  }

  Future<Map<String, dynamic>> userLogin(String email, String password) async {
    return await client.users.authViaEmail(email, password).then((value) {
      return value.toJson();
    });
  }

  logout() {
    Get.find<UserController>().user.clear();
    Get.find<ReadListController>().readList();
    client.authStore.clear();
  }

  //List
  Future<List> readDiaryList() async {
    var res = await client.records
        .getFullList('diaryList', batch: 200, sort: '-created');

    return res.toList();
  }

  //List filter
  Future<List> readDiaryListByDiaryList(String diaryListId) async {
    var res = await client.records
        .getFullList('diary', batch: 200, filter: "feeling = '$diaryListId'");

    return res.toList();
  }

  Future listCreate(Map<String, dynamic> data) async {
    var res = await client.records.create('diaryList', body: data);
    return res;
  }

  Future<void> listDelete(String listId) async {
    await client.records.delete('diaryList', listId);
  }

  Future<void> listUpdate(Map<String, dynamic> data, String listId) async {
    await client.records.update('diaryList', listId, body: data);
  }

  //Diary
  Future<List> getDiarys() async {
    var list = await client.records.getList('diary');
    return list.items;
  }

  Future<Map<String, dynamic>> getTodayDiary(String id) async {
    RecordModel res = await client.records.getOne('diary', id);

    return res.toJson();
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

  Future<void> deleteAllDiarys(listId) async {
    var diarys = await getDiarys();
    var res = diarys
        .map((e) => e.toJson())
        .where((e) => e['listId'] == listId)
        .toList();

    for (int i = 0; i < res.length; i++) {
      await client.records.delete('diary', res[i]['id']);
    }
    return;
  }

  Future deleteDiary(diaryId) async {
    await client.records.delete('diary', diaryId);
    return;
  }
}
