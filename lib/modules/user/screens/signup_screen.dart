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
      // appBar: DefaultAppbar(),
      body: Container(
        // color: Colors.blue.shade100,
        // width: MediaQuery.of(context).size.width,
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
                  borderRadius: BorderRadius.circular(8),
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
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0xFFA8A8A8))),
              child: TextFormField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                    hintText: 'create password', border: InputBorder.none),
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0xFFA8A8A8))),
              child: TextFormField(
                obscureText: true,
                controller: passwordConfirmController,
                decoration: InputDecoration(
                    hintText: 'confirm password', border: InputBorder.none),
              ),
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
                      : Text('가입하기');
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
