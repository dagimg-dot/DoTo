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
  void handleLongPress(BuildContext context) {
    List<Widget> buttons = [
      modalButton(context, "Edit", Icons.edit, handleEdit),
      const SizedBox(height: 10.0),
      modalButton(context, "Delete", Icons.delete, handleDelete)
    ];
    // show a menu with options to edit or delete the task on long press
    modalBottomSheet(
      context,
      buttons,
    );
  }

  void handleTap(BuildContext context) {
    List<Widget> buttons = [
      modalButton(context, "Mark as Pending", Icons.timelapse, handlePending),
      const SizedBox(height: 10.0),
      modalButton(
          context, "Mark as Done", Icons.check_circle_outline, handleDone),
      const SizedBox(height: 10.0),
      modalButton(context, "Mark as Cancelled", Icons.close, handleCancelled)
    ];
    modalBottomSheet(context, buttons);
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
                showSnack(context, "Task deleted successfully");
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  // This function has bugs
  void handleEdit() {
    // edit the task
    print("editing ${widget.task.name}");
    // change the page to index 1
    // Navigator.pop(context);
    // GlobalState.isEditing = true;
    // setState(() {
    //   GlobalState.selectedPage = 1;
    // });
    // GlobalState.selectedTask = widget.task;
  }

  void handleDone() async {
    // mark the task as done
    Task task = await TaskDAOImpl().getTask(widget.task.id);
    if (task.getStatus() != 1) {
      TaskDAOImpl().updateStatus(widget.task.id, 1);
      // update the list of tasks
      widget.updateTasks();
      showSnack(context, "Task marked as done");
    } else {
      showSnack(context, "The task is already done");
    }
  }

  void handleCancelled() async {
    // mark the task as cancelled
    Task task = await TaskDAOImpl().getTask(widget.task.id);
    if (task.getStatus() != 2) {
      TaskDAOImpl().updateStatus(widget.task.id, 2);
      // update the list of tasks
      widget.updateTasks();
      showSnack(context, "Task marked as cancelled");
    } else {
      showSnack(context, "The task is already cancelled");
    }
  }

  void handlePending() async {
    Task task = await TaskDAOImpl().getTask(widget.task.id);
    if (task.getStatus() != 0) {
      TaskDAOImpl().updateStatus(widget.task.id, 0);
      // update the list of tasks
      widget.updateTasks();
      showSnack(context, "Task marked as pending");
    } else {
      showSnack(context, "The task is already pending");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        handleLongPress(context);
      },
      onTap: () {
        handleTap(context);
      },
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
                      fontWeight: FontWeight.w700,
                      color: secondaryColor,
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
            taskStatusIcon(widget.task.status)
          ],
        ),
      ),
    );
  }

  Icon taskStatusIcon(int status) {
    switch (status) {
      case 0:
        return const Icon(
          Icons.timelapse,
          color: secondaryColor,
        );
      case 1:
        return const Icon(
          Icons.check_circle_outline,
          color: secondaryColor,
        );
      case 2:
        return const Icon(
          Icons.cancel_outlined,
          color: secondaryColor,
        );
      default:
        return const Icon(
          Icons.timelapse,
          color: secondaryColor,
        );
    }
  }
}

Future<dynamic> modalBottomSheet(context, List<Widget> buttons) {
  return showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(40),
        topRight: Radius.circular(40),
      ),
    ),
    context: context,
    builder: (context) {
      return Container(
        height: buttons.length == 3 ? 120 : 180,
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
            ...buttons,
          ],
        ),
      );
    },
  );
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

showSnack(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
      behavior: SnackBarBehavior.floating,
      elevation: 10.0,
      backgroundColor: secondaryColor,
      margin: const EdgeInsets.all(20.0),
      duration: const Duration(seconds: 2),
    ),
  );
}
