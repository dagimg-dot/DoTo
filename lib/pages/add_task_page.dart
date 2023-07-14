import 'dart:math';

import 'package:doto/utils/constants.dart';
import 'package:flutter/material.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final taskNameController = TextEditingController();
  final taskDescController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _addTask() {
    final String name = taskNameController.text;
    final String description = taskDescController.text;
    print(name);
    print(description);
    // add task to list or database
    // clear text fields
    taskNameController.clear();
    taskDescController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        margin: const EdgeInsets.only(top: 9),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 4,
              blurRadius: 4,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 30.0, bottom: 10.0, left: 10.0, right: 10.0),
          child: Container(
            height: double.infinity,
            color: Colors.white,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Add Task",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: secondaryColor,
                      )),
                  const SizedBox(height: 25.0),
                  textField('Task Name', taskNameController),
                  const SizedBox(height: 25.0),
                  textField('Task Description', taskDescController),
                  const SizedBox(height: 25.0),
                  FloatingActionButton.extended(
                    label: const Text(
                      'Add Task',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ), // <-- Text
                    backgroundColor: secondaryColor,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextField textField(String label, TextEditingController controller) {
    return TextField(
      style: const TextStyle(
        color: secondaryColor,
        fontSize: 17,
      ),
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.grey.withOpacity(0.6),
          fontSize: 14,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.6),
          ),
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }
}
