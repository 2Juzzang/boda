import 'package:diary/global/api/api.dart';
import 'package:diary/global/controller/read_diary_list.dart';
import 'package:get/get.dart';

class ListController extends GetxController {
  Api api = Api();
  RxBool editMode = false.obs;
  RxBool visible = false.obs;

  listCreate(data, userId) async {
    await api.listCreate(data);

    await Get.find<ReadListController>().readList();

    visible(false);
  }

  listDelete(String listId) async {
    await api.listDelete(listId);
    await Get.find<ReadListController>().readList();
  }

  listUpdate(Map<String, dynamic> data, listId) async {
    await api.listUpdate(data, listId);
    await Get.find<ReadListController>().readList();
  }

  listEditMode(listId) {
    var list = Get.find<ReadListController>().diaryList;
    var res = list.where((e) => e['listId'] == listId).toList();

    return res[0]['listId'] == listId;
  }
}
