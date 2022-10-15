import 'package:diary/global/controller/read_diarys.dart';
import 'package:diary/modules/diary/controller/view_controller.dart';
import 'package:diary/modules/home/screens/main_screen.dart';
import 'package:diary/modules/login/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DefaultAppbar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReadDiarysController());
    return AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
        leadingWidth: 100,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: GestureDetector(
            onTap: () {
              controller.readDiarys();
              Get.off(() => Home());
            },
            child: Image.asset(
              'assets/images/boda.png',
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => Login());
            },
            child: Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Icon(
                Icons.notifications,
                color: Color(0xffCECECE),
              ),
            ),
          ),
        ]);
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
