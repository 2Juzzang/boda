import 'package:cached_network_image/cached_network_image.dart';
import 'package:diary/global/common/default_appbar.dart';
import 'package:diary/modules/diary/controller/view_controller.dart';
import 'package:diary/modules/diary/screens/diary_edit.dart';
import 'package:diary/modules/diary/screens/diary_new.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class DetailView extends StatefulWidget {
  const DetailView({super.key});

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  @override
  Widget build(BuildContext context) {
    final diaryId = Get.arguments[0];
    final controller = Get.put(ViewController(id: diaryId));
    final listId = Get.arguments[1];
    String endPoint = 'http://127.0.0.1:8090/api/files/ejd8zuc5jpk31lx';
    final diary = controller.diary;
    // print(diaryId);

    return Scaffold(
      appBar: DefaultAppbar(),
      body: Obx(() {
        // print(diary);
        return controller.isLoading
            ? const CircularProgressIndicator()
            : controller.editMode.value
                ? DiaryEdit(
                    data: {
                      'diaryId': diary['id'],
                      'listId': diary['listId'],
                      'createdAt': diary['createdAt'],
                      'author': diary['author'],
                      'contents': diary['contents'],
                      'image': diary['image'],
                      'feeling': diary['feeling'],

                      // 'contents'
                    },
                  )
                : Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xffececec),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.all(16.0),
                    margin: EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          diary['image'] != ''
                              ? Image.network(
                                  '$endPoint/$diaryId/${diary['image']}')
                              : Container(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Image.asset(
                                'assets/images/${diary['feeling']}.png'),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                diary['createdAt'],
                                style: TextStyle(color: Colors.grey),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        controller.editMode.value = true;
                                        // listController.listDelete(widget.id);
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.grey,
                                      )),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Get.dialog(AlertDialog(
                                          content: (Text(
                                              '일기장은 복구되지 않습니다.\n삭제하시겠습니까?')),
                                          contentPadding: EdgeInsets.all(24),
                                          actions: [
                                            TextButton(
                                                onPressed: (() async {
                                                  await controller.deleteDiary(
                                                      diaryId, listId);
                                                  Get.back();
                                                }),
                                                child: Text(
                                                  '예',
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                )),
                                            TextButton(
                                                onPressed: (() => Get.back()),
                                                child: Text('아니오'))
                                          ],
                                        ));
                                        // listController.listDelete(widget.id);
                                      },
                                      child: Icon(Icons.delete,
                                          color: Colors.grey)),
                                ],
                              ),
                            ],
                          ),
                          Container(
                              alignment: Alignment.topLeft,
                              child: Text(diary['contents'])),
                        ],
                      ),
                    ),
                  );
      }),
    );
  }
}
