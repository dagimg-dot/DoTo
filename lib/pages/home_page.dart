import 'dart:developer';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:doto/widgets/horizontal_chip_list.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: ListTile(
          leading: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: secondaryColor,
                width: 2.0,
              ),
              image: const DecorationImage(
                image: AssetImage('assets/images/profile.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          title: const Text('Hello, Dagim'),
          subtitle: const Text(
            'Manage your tasks !',
            style: TextStyle(color: Colors.white),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.more_vert),
            color: Colors.white,
            onPressed: () {},
          ),
        ),
        toolbarHeight: MediaQuery.of(context).devicePixelRatio * 40.0,
        elevation: 0.0,
      ),
      body: Container(
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
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
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
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: secondaryColor,
        animationDuration: const Duration(milliseconds: 300),
        height: 50,
        items: [
          iconMaker(Icons.home),
          iconMaker(Icons.add),
          iconMaker(Icons.settings),
        ],
      ),
    );
  }

  Icon iconMaker(IconData icon) {
    return Icon(icon, color: Colors.white, size: 30);
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
}
