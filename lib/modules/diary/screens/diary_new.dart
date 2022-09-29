import 'package:diary/global/common/default_appbar.dart';
import 'package:diary/global/common/diary_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class DiaryNew extends StatefulWidget {
  const DiaryNew({super.key});

  @override
  State<DiaryNew> createState() => _DiaryNewState();
}

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
    print(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppbar(),
      body: GestureDetector(
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              DiaryWidget(),
              GestureDetector(
                onTap: () {
                  _getImage();
                },
                child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xffececec),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: EdgeInsets.all(16),
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
                                  style: TextStyle(color: Color(0xff808080))),
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
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffececec),
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(16),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  maxLines: 8,
                ),
              ),
              ElevatedButton(onPressed: () {}, child: Text('작성하기'))
            ],
          ),
        ),
      ),
    );
  }
}
