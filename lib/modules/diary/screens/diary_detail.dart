import 'package:diary/global/common/default_appbar.dart';
import 'package:diary/global/controller/read_diarys.dart';
import 'package:diary/modules/diary/screens/detail_view.dart';
import 'package:diary/modules/diary/screens/diary_new.dart';
import 'package:diary/modules/user/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class DiaryDetail extends StatefulWidget {
  const DiaryDetail({super.key});

  @override
  State<DiaryDetail> createState() => _DiaryDetailState();
}

class _DiaryDetailState extends State<DiaryDetail> {
  final controller = Get.put(ReadDiarysController());
  final userController = Get.put(UserController());
  var listId = Get.arguments;

  DateTime? _selectedDay;
  DateTime? _focusedDay;

  @override
  Widget build(BuildContext context) {
    // print(controller.diarys);
    return Scaffold(
      appBar: DefaultAppbar(),
      body: TableCalendar(
        locale: 'ko-KR',
        headerStyle: HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
        ),
        calendarStyle: CalendarStyle(
          // 주말 날짜 색상
          weekendTextStyle: TextStyle(
            color: Colors.red,
          ),
          todayDecoration: BoxDecoration(
            color: Colors.blue.shade200,
            shape: BoxShape.rectangle,
            // borderRadius: BorderRadius.circular(16),
          ),
          todayTextStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          // 이전, 다음 달 날짜 표시여부
          outsideDaysVisible: false,
        ),
        availableGestures: AvailableGestures.none,
        rowHeight: 80,
        daysOfWeekHeight: 36,
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
        firstDay: DateTime.utc(2000, 1, 1),
        lastDay: DateTime.utc(2050, 12, 31),
        focusedDay: _selectedDay == null ? DateTime.now() : _focusedDay!,
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, day, focusedDay) {
            return Obx(
              () {
                var isWrited = controller.diarys
                    .where((e) =>
                        DateFormat("yyyy-MM-dd")
                            .format(DateTime.parse(e['createdAt'])) ==
                        DateFormat("yyyy-MM-dd").format(day))
                    .toList();
                return controller.isLoading
                    ? const CircularProgressIndicator()
                    : GestureDetector(
                        onTap: () async {
                          if (isWrited.isEmpty) {
                            if (focusedDay.compareTo(day) == -1) {
                              Get.snackbar('', '아직 작성하실 수 없습니다.',
                                  titleText: Container(),
                                  snackPosition: SnackPosition.BOTTOM);
                            } else {
                              Get.to(() => DiaryNew(),
                                  arguments: [listId, day]);
                            }
                          } else {
                            Get.to(() => DetailView(),
                                arguments: [isWrited[0]['id'], listId]);
                          }
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: 40,
                              child: Column(
                                children: [
                                  if (isWrited.isEmpty)
                                    Icon(
                                      Icons.add_circle_outline,
                                      color: Colors.grey.shade300,
                                    )
                                  else
                                    ...isWrited.map(((e) {
                                      return Image.asset(
                                          'assets/images/${e['feeling']}.png');
                                    })),
                                ],
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(day.day.toString())
                          ],
                        ),
                      );
              },
            );
          },
          todayBuilder: (context, day, focusedDay) {
            return Obx(
              () {
                var isWrited = controller.diarys
                    .where((e) =>
                        DateFormat("yyyy-MM-dd")
                            .format(DateTime.parse(e['createdAt'])) ==
                        DateFormat("yyyy-MM-dd").format(day))
                    .toList();
                return GestureDetector(
                  onTap: () async {
                    if (isWrited.isEmpty) {
                      if (focusedDay.compareTo(day) == -1) {
                        Get.snackbar('', '아직 작성하실 수 없습니다.',
                            titleText: Container(),
                            snackPosition: SnackPosition.BOTTOM);
                      } else {
                        Get.to(() => DiaryNew(), arguments: [listId, day]);
                      }
                    } else {
                      Get.to(() => DetailView(),
                          arguments: [isWrited[0]['id'], listId]);
                    }
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                        child: Column(
                          children: [
                            if (isWrited.isEmpty)
                              Icon(
                                Icons.add_circle_outline,
                                color: Colors.grey.shade300,
                              )
                            else
                              ...isWrited.map(((e) {
                                return Image.asset(
                                    'assets/images/${e['feeling']}.png');
                              })),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        width: 32,
                        decoration: BoxDecoration(
                          color: Color(0xFF00CCCC),
                        ),
                        child: Text(
                          day.day.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
