import 'package:doto/utils/constants.dart';
import 'package:doto/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';

import '../dao/task_dao_impl.dart';
import '../models/task.dart';
import '../widgets/horizontal_chip_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int globalFilter = 0;
  List<Task> tasks = [];

  // this function is passed to CustomListTile widget to update the list of tasks
  void updateTasks() {
    setState(() {
      filterTasks(globalFilter);
    });
  }

  filterTasks(int filter) async {
    globalFilter = filter;
    List<Task> fetchedTasks = await TaskDAOImpl().getAllTasks();
    List<Task> filteredTasks = [];
    switch (filter) {
      case 0:
        filteredTasks = fetchedTasks;
        break;
      case 1:
        filteredTasks = fetchedTasks
            .where((task) => task.status == TaskStatus.PENDING)
            .toList();
        break;
      case 2:
        filteredTasks = fetchedTasks
            .where((task) => task.status == TaskStatus.COMPLETED)
            .toList();
        break;
      case 3:
        filteredTasks = fetchedTasks
            .where((task) => task.status == TaskStatus.CANCELLED)
            .toList();
        break;
      default:
        filteredTasks = fetchedTasks;
    }
    setState(() {
      tasks = filteredTasks;
    });
  }

  @override
  void initState() {
    super.initState();
    filterTasks(0); // get all tasks when app starts
  }

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
                filterTasks(index);
              },
            ),
          ),
          Expanded(
            child: tasks.isNotEmpty
                ? ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return CustomListTile(
                          task: tasks[index], updateTasks: updateTasks);
                    },
                  )
                : Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    child: const Text(
                      "You have no tasks",
                      style: TextStyle(
                        fontSize: 22,
                        color: secondaryColor,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
