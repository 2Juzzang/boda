import 'package:diary/modules/user/screens/login_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:diary/modules/home/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 로그인 정보 받아오는 로직 추가하기
    Future.delayed(Duration(seconds: 3), () {
      FlutterNativeSplash.remove();
    });
    return GetMaterialApp(
      home: Home(),
    );
  }
}
