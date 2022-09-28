import 'package:flutter/material.dart';

class FloatingBtn extends StatelessWidget {
  const FloatingBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        print('작성 페이지로');
      },
      backgroundColor: Colors.white,
      child: Icon(
        Icons.create,
        color: Colors.amber,
      ),
    );
  }
}
