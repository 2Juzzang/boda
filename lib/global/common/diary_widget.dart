import 'package:diary/global/controller/read_diary_list.dart';
import 'package:diary/global/controller/read_diarys.dart';
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
  final controller = Get.put(ReadDiarysController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () async {
              await controller.getDiarys(widget.id);
              Get.to(() => DiaryDetail(), arguments: widget.id);
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '마지막 일기 : 3일 전',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    //circleAvatar 추가하기
                    Image.asset(
                      'assets/images/boda.png',
                      width: 96,
                    ),
                  ],
                ),
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
