import 'package:doto/models/task.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

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
            style: TextStyle(
              color: Colors.white
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.more_vert),
            color: Colors.white,
            onPressed: () {},
          ),
        ),
        toolbarHeight: MediaQuery.of(context).devicePixelRatio * 43.0,
        elevation: 0.0,
      ),
      body: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 15,
                blurRadius: 20,
                offset: const Offset(0, 0), // changes position of shadow
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: -15,
                blurRadius: 20,
                offset: const Offset(0, 0), // changes position of shadow
              )
            ],
          ),
          child: const Center(
            child: Text(
              'App Content',
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
