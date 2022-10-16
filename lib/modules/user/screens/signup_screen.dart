import 'package:diary/global/common/default_appbar.dart';
import 'package:diary/modules/user/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final idController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final controller = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    // print(controller.signUp());
    return Scaffold(
      appBar: DefaultAppbar(),
      body: Container(
        color: Colors.blue.shade100,
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
            Text('비번 확인 필드'),
            TextFormField(
              obscureText: true,
              controller: passwordConfirmController,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await controller.signUp({
                    'email': idController.text,
                    'password': passwordController.text,
                    'passwordConfirm': passwordConfirmController.text
                  });
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.green),
                ),
                child: Text('가입하기'),
              ),
            )
          ],
        ),
      ),
    );
    ;
  }
}
