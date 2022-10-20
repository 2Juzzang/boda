import 'package:diary/global/common/default_appbar.dart';
import 'package:diary/modules/user/controller/user_controller.dart';
import 'package:diary/modules/user/screens/signup_screen.dart';
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
      // appBar: DefaultAppbar(),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Image.asset(
                'assets/images/boda.png',
                width: 200,
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Color(0xFFA8A8A8))),
              child: TextFormField(
                controller: idController,
                decoration: InputDecoration(
                    hintText: 'example@boda.com', border: InputBorder.none),
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Color(0xFFA8A8A8))),
              child: TextFormField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                    hintText: 'password', border: InputBorder.none),
              ),
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
                  backgroundColor: MaterialStatePropertyAll(Color(0xFF00CCCC)),
                ),
                child: Obx(() {
                  return controller.isLoading
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                            strokeWidth: 3.0,
                          ),
                        )
                      : Text('로그인하기');
                }),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text('계정이 없으신가요?'),
            SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => SignUp());
              },
              child: Text(
                '회원가입',
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            )
          ],
        ),
      ),
    );
  }
}
