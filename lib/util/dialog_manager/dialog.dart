import 'package:flutter/material.dart';
import 'package:task_manager/util/buttons.dart';

class DialogeBox extends StatelessWidget {
  final TextEditingController controller;
  VoidCallback onSave;
  VoidCallback onCancel;


  DialogeBox({required this.controller,required this.onSave, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 200,
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add Your Task'
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                MyButton(text: 'Add', callback: onSave),

                MyButton(text: 'Cancel', callback: onCancel),
              ],
            )
          ],
        ),
      ),
    );
  }
}
