import 'package:diary/global/common/default_appbar.dart';
import 'package:diary/modules/diary/screens/diary_new.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class DiaryDetail extends StatefulWidget {
  const DiaryDetail({super.key});

  @override
  State<DiaryDetail> createState() => _DiaryDetailState();
}

class _DiaryDetailState extends State<DiaryDetail> {
  DateTime? _selectedDay;
  DateTime? _focusedDay;
  @override
  Widget build(BuildContext context) {
    print(_selectedDay);
    print(_focusedDay);
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
        // eventLoader: (day) {
        //   if (day.day % 2 == 0) {
        //     return [Container()];
        //   }
        //   return [];
        // },
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
            print(day.day);
            return GestureDetector(
              onTap: () {
                Get.to(() => DiaryNew());
              },
              child: Column(
                children: [
                  day.day % 2 == 0
                      ? Image.asset(
                          'assets/images/anger.png',
                          width: 40,
                        )
                      : Image.asset(
                          'assets/images/good.png',
                          width: 40,
                        ),
                  SizedBox(height: 8),
                  Text(day.day.toString())
                ],
              ),
            );
          },
          todayBuilder: (context, day, focusedDay) {
            return GestureDetector(
              onTap: () {
                Get.to(() => DiaryNew());
              },
              child: Column(
                children: [
                  day.day % 2 == 0
                      ? Image.asset(
                          'assets/images/anger.png',
                          width: 40,
                        )
                      : Image.asset(
                          'assets/images/good.png',
                          width: 40,
                        ),
                  SizedBox(height: 8),
                  Container(
                    // padding: EdgeInsets.symmetric(horizontal: 8),
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.amber.shade700,
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
        ),
      ),
    );
  }
}
