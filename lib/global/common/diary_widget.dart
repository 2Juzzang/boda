import 'package:diary/global/controller/read_diary_list.dart';
import 'package:diary/global/controller/read_diarys.dart';
import 'package:diary/modules/home/controller/list_controller.dart';
import 'package:diary/modules/user/controller/user_controller.dart';
import 'package:get/get.dart';
import 'package:diary/modules/diary/screens/diary_detail.dart';
import 'package:flutter/material.dart';

class DiaryWidget extends StatefulWidget {
  final String title;
  final int index;
  final String id;

  const DiaryWidget(this.title, this.index, this.id, {super.key});

  @override
  State<DiaryWidget> createState() => _DiaryWidgetState();
}

class _DiaryWidgetState extends State<DiaryWidget> {
  bool editMode = false;
  final controller = Get.put(ReadDiarysController());
  final diaryListController = Get.put(ReadListController());
  final listController = Get.put(ListController());
  final userController = Get.put(UserController());
  _editMode() {
    setState(() {
      editMode = !editMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final listTitleController = TextEditingController(text: widget.title);

    final listId = widget.id;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () async {
              await controller.getDiarys(listId);
              Get.to(() => DiaryDetail(), arguments: listId);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 1,
                      spreadRadius: 1.0,
                      offset: Offset(1, 1)),
                ],
              ),
              // width: double.infinity,
              height: 96,
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(18, 16, 16, 16),
                  child:
                      // Obx(() {
                      //   return
                      Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: editMode
                            ? [
                                Column(
                                  children: [
                                    SizedBox(
                                      width: 180,
                                      child: TextFormField(
                                        controller: listTitleController,
                                        decoration: InputDecoration(
                                            hintText: '일기장 제목을 입력해주세요.',
                                            hintStyle: TextStyle(fontSize: 14)),
                                      ),
                                    ),
                                  ],
                                ),
                              ]
                            : [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      widget.title,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(8, 0, 0, 2),
                                      child: GestureDetector(
                                          onTap: () {
                                            _editMode();
                                          },
                                          child: Icon(
                                            Icons.edit,
                                            size: 16,
                                            color: Colors.grey.shade400,
                                          )),
                                    ),
                                  ],
                                ),
                                FutureBuilder(
                                    future:
                                        diaryListController.latestDiary(listId),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        // var res = snapshot.data
                                        return snapshot.data == null
                                            ? Text(
                                                '최근 작성 일기 : 없음',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              )
                                            : Text(
                                                '최근 작성 일기 : ${snapshot.data}',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              );
                                      }
                                      return CircularProgressIndicator();
                                    }),
                              ],
                      ),
                      editMode
                          ? ElevatedButton(
                              onPressed: ((() async {
                                if (listTitleController.text.isEmpty) {
                                  Get.snackbar('', '제목을 입력해주세요',
                                      titleText: Container(),
                                      snackPosition: SnackPosition.BOTTOM);
                                  return;
                                }
                                if (listTitleController.text.length > 14) {
                                  Get.snackbar('', '제목은 최대 14자까지 입력할 수 있습니다.',
                                      titleText: Container(),
                                      snackPosition: SnackPosition.BOTTOM);
                                  return;
                                }
                                await listController.listUpdate({
                                  'author': userController.user['user']
                                      ['profile']['id'],
                                  'title': listTitleController.text,
                                }, listId);
                                _editMode();
                              })),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Color(0xFF00CCCC)),
                              ),
                              child: Text(
                                '확인',
                              ))
                          : SizedBox.shrink(),
                      editMode
                          ? ElevatedButton(
                              onPressed: ((() {
                                _editMode();
                                listTitleController.text = widget.title;
                              })),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Color(0xFFCC0000)),
                              ),
                              child: Text(
                                '취소',
                              ))
                          : SizedBox.shrink(),
                      editMode
                          ? SizedBox.shrink()
                          : diaryListController.isLoading
                              ? CircularProgressIndicator()
                              : FutureBuilder(
                                  future: diaryListController
                                      .mostFeeling(widget.id),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      // var res = snapshot.data
                                      return snapshot.data == null
                                          ? Image.asset(
                                              'assets/images/boda.png',
                                              width: 80,
                                            )
                                          : CircleAvatar(
                                              radius: 44,
                                              backgroundColor:
                                                  Colors.grey.shade200,
                                              child: Image.asset(
                                                'assets/images/${snapshot.data}.png',
                                                width: 96,
                                              ),
                                            );
                                    }
                                    return CircularProgressIndicator();
                                  }),
                    ],
                  )),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.dialog(AlertDialog(
                content: (Text('일기장은 복구되지 않습니다.\n삭제하시겠습니까?')),
                contentPadding: EdgeInsets.all(24),
                actions: [
                  TextButton(
                      onPressed: (() async {
                        Get.back();
                        await controller.deleteAllDiarys(listId);
                      }),
                      child: Text(
                        '예',
                        style: TextStyle(color: Colors.red),
                      )),
                  TextButton(onPressed: (() => Get.back()), child: Text('아니오'))
                ],
              ));
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 8, 24, 0),
              alignment: Alignment.topRight,
              child: Icon(
                Icons.highlight_off_rounded,
                size: 18,
                color: Colors.grey.shade400,
              ),
            ),
          ),
          SizedBox(
            width: 32,
            height: 96,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 16,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                Container(
                  width: 16,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                Container(
                  width: 16,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(15),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
