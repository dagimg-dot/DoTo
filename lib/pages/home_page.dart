import 'dart:developer';

import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../widgets/horizontal_chip_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 9.0),
      decoration: BoxDecoration(
        color: ColorScheme.fromSwatch().surface,
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
      child: Column(
        children: [
          // horizontal list view for chips of categories like all, pending, completed and cancelled
          Container(
            height: 60,
            margin: const EdgeInsets.only(bottom: 15, top: 10),
            child: HorizontalChipList(
              chips: const [
                "All",
                "Pending",
                "Completed",
                "Cancelled",
              ],
              onTap: (index) {
                log("$index");
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return taskItem();
              },
            ),
          ),
        ],
      ),
    );
  }
}

Container taskItem() {
  return Container(
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
            children: const [
              Text(
                'Task 1',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 5.0),
              Text(
                'This is task 1',
                style: TextStyle(
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
  );
}
