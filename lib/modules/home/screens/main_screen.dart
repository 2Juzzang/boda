import 'package:diary/global/common/default_appbar.dart';
import 'package:diary/global/common/diary_widget.dart';
import 'package:diary/global/common/floating_btn.dart';
import 'package:diary/modules/home/widgets/diary_create.dart';
import 'package:flutter/material.dart';

void main() => runApp(Home());

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar 와 같은 기능
      appBar: DefaultAppbar(),
      body: Column(
        children: [
          DiaryWidget(),
          DiaryWidget(),
          DiaryCreate(),
        ],
      ),
      floatingActionButton: FloatingBtn(),
    );
  }
}
