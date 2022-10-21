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

class _DetailViewState extends State<DetailView> {
  @override
  Widget build(BuildContext context) {
    final id = Get.arguments[0];
    final listId = Get.arguments[1];
    final controller = Get.put(ViewController(id: id));
    String endPoint = 'http://127.0.0.1:8090/api/files/ejd8zuc5jpk31lx';
    final diary = controller.diary;
    print(id);
    return Scaffold(
      appBar: DefaultAppbar(),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Obx(() {
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
                    GestureDetector(
                        onTap: () {
                          Get.dialog(AlertDialog(
                            content: (Text('일기장은 복구되지 않습니다.\n삭제하시겠습니까?')),
                            contentPadding: EdgeInsets.all(24),
                            actions: [
                              TextButton(
                                  onPressed: (() async {
                                    await controller.deleteDiary(id, listId);
                                    Get.back();
                                  }),
                                  child: Text(
                                    '예',
                                    style: TextStyle(color: Colors.red),
                                  )),
                              TextButton(
                                  onPressed: (() => Get.back()),
                                  child: Text('아니오'))
                            ],
                          ));
                          // listController.listDelete(widget.id);
                        },
                        child: Icon(Icons.delete)),
                  ],
                );
        }),
      ),
    );
  }
}
