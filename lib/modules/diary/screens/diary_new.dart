import 'package:diary/global/common/default_appbar.dart';
import 'package:diary/global/common/diary_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class DiaryNew extends StatefulWidget {
  const DiaryNew({super.key});

  @override
  State<DiaryNew> createState() => _DiaryNewState();
}

class _DiaryNewState extends State<DiaryNew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DiaryWidget(),
            GestureDetector(
              onTap: () {
                print('aa');
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xffececec),
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Column(
                  children: const [
                    Icon(Icons.add_circle, color: Color(0xffd3d3d3), size: 32),
                    SizedBox(height: 8),
                    Text('이미지를 업로드해주세요',
                        style: TextStyle(color: Color(0xff808080))),
                  ],
                ),
              ),
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
                maxLines: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
