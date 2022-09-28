import 'package:flutter/material.dart';

class DiaryCreate extends StatelessWidget {
  const DiaryCreate({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('일기장 만들기');
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(96, 24, 96, 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey[200],
        ),
        child: Text('📒새로운 보다 일기장 만들기'),
      ),
    );
  }
}
