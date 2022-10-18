import 'package:diary/global/common/default_appbar.dart';
import 'package:diary/global/common/diary_widget.dart';
import 'package:diary/global/controller/read_diary_list.dart';
import 'package:diary/global/controller/read_diarys.dart';
import 'package:diary/modules/diary/controller/create_controller.dart';
import 'package:diary/modules/user/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class DiaryNew extends StatefulWidget {
  const DiaryNew({super.key});

  @override
  State<DiaryNew> createState() => _DiaryNewState();
}

class _DiaryNewState extends State<DiaryNew> {
  final contentsController = TextEditingController();
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
    String? diaryListId = Get.arguments[0];
    DateTime? date = Get.arguments[1];
    final controller = Get.put(CreateController(id: diaryListId!));
    final userController = Get.put(UserController());
    print(userController.user['user']['profile']['userId']);
    String? dateTime =
        "${date?.year.toString()}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}";

    return Scaffold(
      appBar: DefaultAppbar(),
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
            print('오왼');
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
                              padding: _image == null
                                  ? EdgeInsets.symmetric(vertical: 24)
                                  : null,
                              child: _image == null
                                  ? Column(
                                      children: const [
                                        Icon(Icons.add_circle,
                                            color: Color(0xffd3d3d3), size: 32),
                                        SizedBox(height: 8),
                                        Text('이미지를 업로드해주세요',
                                            style: TextStyle(
                                                color: Color(0xff808080))),
                                      ],
                                    )
                                  : AspectRatio(
                                      aspectRatio: 4 / 3,
                                      child: Image.file(
                                        File(_image!.path),
                                        fit: BoxFit.cover,
                                      ),
                                    )),
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
                                      ? Icon(Icons.add_circle,
                                          color: Color(0xffd3d3d3), size: 32)
                                      : Image(
                                          image: AssetImage(
                                          'assets/images/$_feeling.png',
                                        )),
                                ),
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
                        if (_feeling == null) {
                          Get.snackbar('', '오늘의 감정을 선택해주세요',
                              titleText: Container(),
                              snackPosition: SnackPosition.BOTTOM);
                          return;
                        }
                        controller.createTodayDiary(<String, dynamic>{
                          'contents': contentsController.text,
                          'author': userController.user['user']['profile']
                              ['userId'],
                          'image': _image == null ? null : _image!.path,
                          'feeling': _feeling,
                          'listId': diaryListId.toString(),
                          'createdAt': dateTime
                        }).then((_) {
                          //back()으로 전페이지, filter 다시 함수 실행
                          Get.find<ReadDiarysController>().filter(diaryListId);
                          Get.back();
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.green),
                      ),
                      child: controller.isLoading
                          ? CircularProgressIndicator()
                          : Text('작성하기'),
                    ),
                  )
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
  }
}
