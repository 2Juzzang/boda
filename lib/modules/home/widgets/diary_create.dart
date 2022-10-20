import 'package:diary/modules/user/controller/user_controller.dart';
import 'package:get/get.dart';
import 'package:diary/global/common/diary_widget.dart';
import 'package:diary/modules/home/controller/list_create_controller.dart';
import 'package:flutter/material.dart';

class DiaryCreate extends StatefulWidget {
  const DiaryCreate({super.key});

  @override
  State<DiaryCreate> createState() => _DiaryCreateState();
}

class _DiaryCreateState extends State<DiaryCreate> {
  final listTitleController = TextEditingController();
  // final userController = UserController();
  final user = Get.find<UserController>().user;
  final controller = ListCreateController();
  @override
  Widget build(BuildContext context) {
    return user.isEmpty
        ? CircularProgressIndicator()
        : GestureDetector(
            onTap: () {
              controller.visible.value = true;
            },
            child: Obx(
              () {
                return controller.visible.value
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 40.0),
                        child: Stack(
                          children: [
                            GestureDetector(
                              onTap: () async {},
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
                                  padding:
                                      const EdgeInsets.fromLTRB(18, 16, 16, 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 180,
                                            child: TextFormField(
                                              controller: listTitleController,
                                              decoration: InputDecoration(
                                                  hintText: '일기장 제목을 입력해주세요.',
                                                  hintStyle:
                                                      TextStyle(fontSize: 14)),
                                              // style: TextStyle(
                                              //   fontSize: 16,
                                              //   fontWeight: FontWeight.bold,
                                              // ),
                                            ),
                                          ),
                                          // Text(
                                          //   '마지막 일기 : 3일 전',
                                          //   style: TextStyle(color: Colors.grey),
                                          // ),
                                        ],
                                      ),
                                      //circleAvatar 추가하기
                                      // Image.asset(
                                      //   'assets/images/boda.png',
                                      //   width: 96,
                                      // ),

                                      ElevatedButton(
                                          onPressed: ((() {
                                            controller.listCreate({
                                              'title': listTitleController.text,
                                              'author': user['user']['profile']
                                                  ['id']
                                            }, user['user']['profile']['id']);
                                          })),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Color(0xFF00CCCC)),
                                          ),
                                          child: Text(
                                            '생성',
                                          )),
                                      ElevatedButton(
                                          onPressed: ((() {
                                            controller.visible.value = false;
                                          })),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Color(0xFFCC0000)),
                                          ),
                                          child: Text('취소'))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 32,
                              height: 96,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                      )
                    : Container(
                        margin: EdgeInsets.only(bottom: 40),
                        padding: EdgeInsets.fromLTRB(96, 24, 96, 24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey[200],
                        ),
                        child: Text('📒새로운 보다 일기장 만들기'),
                      );
              },
            ),
          );
  }
}
