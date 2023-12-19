import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TODOTile extends StatelessWidget {
  final String taskName;
  final bool isTaskComplete;
  Function(bool?)? onChanged;
  Function(BuildContext?)? deleteFunction;
  Function()? onEdit;

  TODOTile({
    required this.taskName,
    required this.isTaskComplete,
    required this.onChanged,
    required this.deleteFunction,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.redAccent,
            )
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.deepPurpleAccent.shade200,
          ),
          child: Row(
            children: [
              Checkbox(value: isTaskComplete, onChanged: onChanged),
              Text(
                taskName,
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 1.5,
                  decoration: isTaskComplete
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              Spacer(),
              IconButton(
                  onPressed: onEdit,
                  icon: Icon(
                    Icons.edit,
                    color: Colors.white.withOpacity(0.5),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
