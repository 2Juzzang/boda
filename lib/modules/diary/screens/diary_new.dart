import 'package:diary/global/common/default_appbar.dart';
import 'package:diary/global/common/diary_widget.dart';
import 'package:diary/modules/diary/controller/create_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class DiaryNew extends StatefulWidget {
  const DiaryNew({super.key});

  @override
  State<DiaryNew> createState() => _DiaryNewState();
}

final contentsController = TextEditingController();

class _DiaryNewState extends State<DiaryNew> {
  bool _visible = false;
  File? _image;
  final ImagePicker _picker = ImagePicker();
  Future _getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  final controller = Get.put(CreateController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppbar(),
      body: GestureDetector(
        onTap: () {
          //키보드 숨기기
          FocusManager.instance.primaryFocus?.unfocus();
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
                  DiaryWidget(),
                  Container(
                    decoration: BoxDecoration(),
                    child: Column(
                      children: [],
                    ),
                  ),
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
                      onPressed: () {
                        controller.createTodayDiary(<String, dynamic>{
                          'contents': contentsController.text,
                          'author': '022vbnqxnk2fsn7',
                          'image': _image!.path,
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.green),
                      ),
                      child: Text('작성하기'),
                    ),
                  )
                ],
              ),
            ),
            AnimatedSlide(
              offset: _visible ? Offset(49, 0.5) : Offset(48, 0.5),
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              child: Positioned(
                top: 40,
                right: 0,
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
            ),
            AnimatedSlide(
              offset: _visible ? Offset(4, 0.1) : Offset(5, 0.1),
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              child: Positioned(
                top: 32,
                right: 0,
                child: Container(
                  width: 80,
                  height: 400,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(-0.1, 0.1),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
