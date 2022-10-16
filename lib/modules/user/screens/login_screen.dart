import 'package:diary/global/common/default_appbar.dart';
import 'package:diary/modules/user/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final idController = TextEditingController();
  final passwordController = TextEditingController();
  final controller = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppbar(),
      body: Container(
        color: Colors.amber,
        // width: MediaQuery.of(context).size.width,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('아이디 필드'),
            TextFormField(
              controller: idController,
            ),
            Text('비번 필드'),
            TextFormField(
              obscureText: true,
              controller: passwordController,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await controller.login(
                      idController.text, passwordController.text);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.green),
                ),
                child: Text('로그인하기'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
