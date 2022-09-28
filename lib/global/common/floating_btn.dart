import 'package:diary/modules/diary/screens/diary_new.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FloatingBtn extends StatelessWidget {
  const FloatingBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Get.to(() => DiaryNew());
      },
      backgroundColor: Colors.white,
      child: Icon(
        Icons.create,
        color: Colors.amber,
      ),
    );
  }
}
