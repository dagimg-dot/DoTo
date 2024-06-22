import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:doto/pages/home_page.dart';
import 'package:doto/pages/login_page.dart';
import 'package:doto/pages/settings_page.dart';
import 'package:doto/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'add_task_page.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({super.key, required int selectedPage});

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  int _selectedPage = 0;
  final List<Widget> _pages = const [
    HomePage(),
    AddTaskPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
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
          title: Text(
            _getUserName(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          subtitle: const Text(
            'Manage your tasks !',
            style: TextStyle(color: Colors.white),
          ),
          trailing: PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (String result) {
              if (result == 'logout') {
                _logout();
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'logout',
                child: Text('Logout'),
              ),
            ],
          ),
        ),
        toolbarHeight: MediaQuery.of(context).devicePixelRatio * 40.0,
        elevation: 0.0,
      ),
      body: _pages[_selectedPage],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: secondaryColor,
        animationDuration: const Duration(milliseconds: 300),
        height: 50,
        onTap: (index) {
          setState(() {
            _selectedPage = index;
          });
        },
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

  void _logout() async {
    await AuthService().signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  String _getUserName() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && user.email != null) {
      String name = user.email!.split('@')[0];
      return "Hello $name !";
    } else {
      return 'Hello User';
    }
  }
}
