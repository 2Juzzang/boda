import 'package:diary/global/controller/read_diarys.dart';
import 'package:diary/modules/diary/controller/create_controller.dart';
import 'package:diary/modules/diary/controller/view_controller.dart';
import 'package:diary/modules/user/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'dart:io';

class DiaryEdit extends StatefulWidget {
  Map<String, dynamic> data;
  DiaryEdit({required this.data, super.key});

  @override
  State<DiaryEdit> createState() => _DiaryEditState();
}

class _DiaryEditState extends State<DiaryEdit> {
  bool _visible = false;
  File? _image;
  String? _feeling;
  final ImagePicker _picker = ImagePicker();
  Future _getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  _selectFeeling(v) {
    setState(() {
      _feeling = v;
      _visible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    String endPoint = 'http://127.0.0.1:8090/api/files/ejd8zuc5jpk31lx';
    final data = widget.data;
    final controller = Get.put(CreateController(listId: data['listId']));
    final userController = Get.put(UserController());
    final viewController = Get.put(ViewController(id: data['diaryId']));
    final contentsController = TextEditingController();

    print(data['image']);
    print(contentsController.text);
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          //키보드 숨기기
          FocusManager.instance.primaryFocus?.unfocus();
          setState(() {
            _visible = false;
          });
        },
        onPanUpdate: ((details) {
          if (details.delta.dx > 0) {
            // print('왼오');
            setState(() {
              _visible = false;
            });
          }
          if (details.delta.dx < 0) {
            // print('오왼');
            setState(() {
              _visible = true;
            });
          }
        }),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  // DiaryWidget(),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xffececec),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: EdgeInsets.all(16),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _getImage();
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            margin: EdgeInsets.only(bottom: 8),
                            padding: data['image'] != ''
                                ? EdgeInsets.symmetric(vertical: 24)
                                : null,
                            child:
                                // data['image'] != ''
                                //     ? Image.network(
                                //         '$endPoint/${data['id']}/${data['image']}')
                                //     :
                                Container(),
                            // _image == null
                            //       ? Column(
                            //           children: const [
                            //             Icon(Icons.add_circle,
                            //                 color: Color(0xffd3d3d3), size: 32),
                            //             SizedBox(height: 8),
                            //             Text('이미지를 업로드해주세요',
                            //                 style: TextStyle(
                            //                     color: Color(0xff808080))),
                            //           ],
                            //         )
                            //       : AspectRatio(
                            //           aspectRatio: 4 / 3,
                            //           child: Image.file(
                            //             File(_image!.path),
                            //             fit: BoxFit.cover,
                            //           ),
                            //         )),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _visible = true;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text('오늘의 감정은?'),
                                SizedBox(height: 8),
                                SizedBox(
                                    child: _feeling == null
                                        ? Image.asset(
                                            'assets/images/${data['feeling']}.png')
                                        : Image(
                                            image: AssetImage(
                                            'assets/images/$_feeling.png',
                                          ))),
                              ],
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: contentsController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          maxLines: 8,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (contentsController.text.isEmpty) {
                            Get.snackbar('', '내용을 입력해주세요',
                                titleText: Container(),
                                snackPosition: SnackPosition.BOTTOM);
                            return;
                          }
                          // 수정은 피룡없
                          // if (_feeling == null) {
                          //   Get.snackbar('', '오늘의 감정을 선택해주세요',
                          //       titleText: Container(),
                          //       snackPosition: SnackPosition.BOTTOM);
                          //   return;
                          // }
                          await controller.createTodayDiary(<String, dynamic>{
                            'contents': contentsController.text.isEmpty
                                ? data['contents']
                                : contentsController.text,
                            'author': userController.user['user']['profile']
                                ['userId'],
                            'image': _image ?? data['image'],
                            'feeling': _feeling ?? data['feeling'],
                            'listId': data['listId'],
                            'createdAt': data['createdAt']
                          }).then((_) {
                            //back()으로 전페이지, filter 다시 함수 실행
                            Get.find<ReadDiarysController>()
                                .getDiarys(data['listId']);
                            Get.back();
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Color(0xFF00CCCC)),
                        ),
                        child: Obx(() {
                          return controller.isLoading
                              ? CircularProgressIndicator()
                              : Text('수정하기');
                        })),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (() {
                        viewController.editMode(false);
                      }),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Color(0xFFCC0000)),
                      ),
                      child: Text('취소하기'),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedSlide(
              offset: _visible ? Offset(49, 0.5) : Offset(48, 0.5),
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              child: Container(
                width: 8,
                height: 96,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                ),
              ),
            ),
            AnimatedSlide(
              offset: _visible ? Offset(4, 0.1) : Offset(5, 0.1),
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              child: Container(
                width: 80,
                height: 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(-0.1, 0.1),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:
                      ['normal', 'good', 'joy', 'sigh', 'anger', 'sadness']
                          .map(
                            (e) => GestureDetector(
                              onTap: () {
                                _selectFeeling(e);
                              },
                              child: Image.asset(
                                'assets/images/$e.png',
                                width: 50,
                              ),
                            ),
                          )
                          .toList(),
                  //   GestureDetector(
                  //     onTap: () {
                  //       _selectFeeling('normal');
                  //     },
                  //     child: Image.asset(
                  //       'assets/images/normal.png',
                  //       width: 50,
                  //     ),
                  //   ),
                  //   GestureDetector(
                  //     onTap: () {
                  //       _selectFeeling('good');
                  //     },
                  //     child: Image.asset(
                  //       'assets/images/good.png',
                  //       width: 50,
                  //     ),
                  //   ),
                  //   GestureDetector(
                  //     onTap: () {
                  //       _selectFeeling('joy');
                  //     },
                  //     child: Image.asset(
                  //       'assets/images/joy.png',
                  //       width: 50,
                  //     ),
                  //   ),
                  //   GestureDetector(
                  //     onTap: () {
                  //       _selectFeeling('sigh');
                  //     },
                  //     child: Image.asset(
                  //       'assets/images/sigh.png',
                  //       width: 50,
                  //     ),
                  //   ),
                  //   GestureDetector(
                  //     onTap: () {
                  //       _selectFeeling('anger');
                  //     },
                  //     child: Image.asset(
                  //       'assets/images/anger.png',
                  //       width: 50,
                  //     ),
                  //   ),
                  //   GestureDetector(
                  //     onTap: () {
                  //       _selectFeeling('sadness');
                  //     },
                  //     child: Image.asset(
                  //       'assets/images/sadness.png',
                  //       width: 50,
                  //     ),
                  //   ),
                  // ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
