import 'package:flutter/material.dart';
import 'package:flutter_blogs_app/common_files/constants.dart';

import '../authentication/firebase_authentication.dart';

class BlogsHomePage extends StatefulWidget {
  const BlogsHomePage({Key? key}) : super(key: key);

  @override
  State<BlogsHomePage> createState() => _BlogsHomePageState();
}

class _BlogsHomePageState extends State<BlogsHomePage> {
  int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Blogs')),
      body: const Center(
        child: Text('Blogs page'),
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.logout), label: "Logout"),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add new blog"),
      ],
      backgroundColor: Colors.blueAccent,
      selectedItemColor: Colors.white,
      currentIndex: _selectedIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            setState(() {
              _selectedIndex = index;
            });
            AuthImplementation().signOutUser();
            Navigator.of(context).pushNamedAndRemoveUntil(
                Routes().loginPageRoute, (route) => false);
            break;
          case 1:
            setState(() {
              _selectedIndex = index;
            });
            break;
        }
      },
    );
  }
}
