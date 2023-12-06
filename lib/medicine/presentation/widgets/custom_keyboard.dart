import 'package:flutter/material.dart';

class CustomKeyboard extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onKeyPressed;

  const CustomKeyboard(
      {super.key, required this.controller, required this.onKeyPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: 27, // 26 alphabets + 1 for "ALL"
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (index == 0) {
            return InkWell(
              onTap: () {
                onKeyPressed('ALL');
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Text('ALL'),
              ),
            );
          } else {
            final char = String.fromCharCode('A'.codeUnitAt(0) + index - 1);
            return InkWell(
              onTap: () {
                onKeyPressed(char);
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(char),
              ),
            );
          }
        },
      ),
    );
  }
}