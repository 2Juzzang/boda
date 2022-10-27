import 'package:diary/global/api/api.dart';
import 'package:diary/global/controller/read_diarys.dart';
import 'package:diary/modules/user/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:get/get.dart';
import 'dart:math';

class ReadListController extends GetxController {
  Api api = Api();
  final client = PocketBase('http://127.0.0.1:8090');
  final RxList diaryList = [].obs;
  final RxBool _isLoading = false.obs;
  final RxBool _edit = false.obs;
  // final RxList mostFeelingList = [].obs;
  final RxString latest = ''.obs;

  bool get isLoading => _isLoading.value;
  bool get edit => _edit.value;

  readList() async {
    _isLoading(true);
    var res = await api.readDiaryList();
    diaryList(res.map((e) {
      return {'listId': e.id, ...e.data};
    }).toList());
    await listFilter();
    _isLoading(false);
  }

  listFilter() {
    var user = Get.find<UserController>().user;
    if (user.isEmpty) {
      return;
    } else {
      return diaryList(diaryList
          .where((e) => e['author'] == user['user']['profile']['id'])
          .toList());
    }
  }

  feeling(listId) async {
    // _isLoading(true);
    var res = await api.test(listId);
    var mostFeeling = '';
    var count = <String, num>{};

    for (var feeling in res) {
      count[feeling] = 1 + (count[feeling] ?? 0);
    }
    //
    var result = count.values.toList();

    if (res.isEmpty) {
      return;
    } else {
      var most = result.reduce((value, element) {
        return value > element ? value : element;
      });

      for (var feeling in res) {
        if (count[feeling] == most) {
          mostFeeling = feeling;
        }
      }

      return mostFeeling;
    }
  }

  latestDiary(listId) async {
    _isLoading(false);
    var res = await api.latestDiary(listId);

    // date.sort();
    // print(date.runtimeType);
    if (res.isEmpty) {
      return;
    } else {
      latest(res.last);
      _isLoading(true);
      return res.last;
    }
  }

  @override
  void onInit() {
    ever(Get.put(UserController()).user, ((_) => readList()));
    super.onInit();
  }
}
