import 'package:diary/global/api/api.dart';
import 'package:diary/global/controller/read_diary_list.dart';
import 'package:get/get.dart';

class ListController extends GetxController {
  Api api = Api();
  RxBool visible = false.obs;

  listCreate(data, id) async {
    await api.listCreate(data);

    await Get.find<ReadListController>().readList();

    visible(false);
  }

  listDelete(listId) async {
    await api.listDelete(listId);
    await Get.find<ReadListController>().readList();
  }
}
