import 'package:cached_network_image/cached_network_image.dart';
import 'package:diary/global/common/default_appbar.dart';
import 'package:diary/modules/diary/controller/view_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class DetailView extends StatefulWidget {
  const DetailView({super.key});

  @override
  State<DetailView> createState() => _DetailViewState();
}

// String? id = Get.arguments;
// final controller = Get.put(ViewController(id: id!));

class _DetailViewState extends State<DetailView> {
  @override
  Widget build(BuildContext context) {
    final id = Get.arguments;
    final controller = Get.put(ViewController(id: Get.arguments));
    String endPoint = 'http://127.0.0.1:8090/api/files/ejd8zuc5jpk31lx';
    final diary = controller.diary;
    return Scaffold(
      appBar: DefaultAppbar(),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Obx(() {
          print(id);
          print(diary);
          return controller.isLoading
              ? const CircularProgressIndicator()
              : Column(
                  children: [
                    diary['image'] != ''
                        ? Image.network('$endPoint/$id/${diary['image']}')
                        // CachedNetworkImage(
                        //     placeholder: (context, url) =>
                        //         CircularProgressIndicator(),
                        //     imageUrl: '$endPoint/$id/${diary['image']}')
                        : Container(),
                    Image.asset('assets/images/${diary['feeling']}.png'),
                    Text(diary['contents']),
                  ],
                );
        }),
      ),
    );
  }
}
