import 'dart:convert';

import 'package:diary/global/common/default_appbar.dart';
import 'package:diary/global/common/diary_widget.dart';
import 'package:diary/global/common/floating_btn.dart';
import 'package:diary/global/controller/read_diary_list.dart';
import 'package:diary/global/models/diary_list.dart';
import 'package:diary/modules/home/widgets/diary_create.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(Home());

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = Get.put(ReadController());

  @override
  Widget build(BuildContext context) {
    // print(controller.arr);
    // Map<String, dynamic> map = jsonDecode(controller.arr);

    return Scaffold(
      // AppBar 와 같은 기능
      appBar: DefaultAppbar(),
      body: Column(
        children: [
          Obx(() {
            return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.arr.length,
                itemBuilder: (context, index) {
                  // print(controller.arr[index]);
                  return DiaryWidget(controller.arr[index]['title'], index);
                });
          }),
          // DiaryWidget(diaryList.title, 1),
          DiaryCreate(),
        ],
      ),
      //  Column(
      //   children: [
      //     GestureDetector(
      //         onTap: () async {
      //           await controller.readDiaryList();
      //           Get.to(() => DiaryDetail());
      //         },
      //         child: DiaryWidget()),
      //     DiaryWidget(),
      //
      //   ],
      // ),

      floatingActionButton: FloatingBtn(),
    );
  }
}
