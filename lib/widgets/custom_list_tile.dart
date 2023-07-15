import 'package:doto/dao/task_dao_impl.dart';
import 'package:flutter/material.dart';

import '../models/task.dart';
import '../utils/constants.dart';

class CustomListTile extends StatefulWidget {
  final Task task;
  final Function() updateTasks;
  const CustomListTile(
      {super.key, required this.task, required this.updateTasks});

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  void handleLongPress() {
    // show a menu with options to edit or delete the task on long press
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      context: context,
      builder: (context) {
        return Container(
          height: 120,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
            boxShadow: [
              BoxShadow(
                color: secondaryColor.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              modalButton(context, "Edit", Icons.edit, handleEdit),
              const SizedBox(height: 10.0),
              modalButton(context, "Delete", Icons.delete, handleDelete)
            ],
          ),
        );
      },
    );
  }

  void handleDelete() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Task"),
          content: const Text(
            "Are you sure you want to delete this task?",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // delete the task
                TaskDAOImpl().deleteTask(widget.task.id);
                // update the list of tasks
                widget.updateTasks();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Task deleted"),
                    behavior: SnackBarBehavior.floating,
                    elevation: 10.0,
                  ),
                );
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  void handleEdit() {
    // edit the task
    print("editing ${widget.task.name}");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: handleLongPress,
      child: Container(
        margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: secondaryColor.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            // checkbox
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: secondaryColor,
                  width: 2.0,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            // task title
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.task.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    widget.task.description,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            // task time
            const Text(
              '10:00 AM',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

GestureDetector modalButton(
    BuildContext context, String text, IconData icon, Function() handler) {
  return GestureDetector(
    onTap: () {
      Navigator.pop(context);
      handler();
    },
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      // color: secondaryColor,
      child: Row(
        children: [
          Icon(icon, color: secondaryColor),
          const SizedBox(width: 10.0),
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: secondaryColor,
            ),
          ),
        ],
      ),
    ),
  );
}
