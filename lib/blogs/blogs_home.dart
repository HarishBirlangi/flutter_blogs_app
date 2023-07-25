import 'package:flutter/material.dart';
import 'package:flutter_blogs_app/common_files/constants.dart';

import '../authentication/firebase_authentication.dart';

class BlogsHomePage extends StatefulWidget {
  const BlogsHomePage({Key? key}) : super(key: key);

  @override
  State<BlogsHomePage> createState() => _BlogsHomePageState();
}

class _BlogsHomePageState extends State<BlogsHomePage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Blogs')),
      body: Center(
        child: Text(AuthImplementation().getCurrentUser().toString()),
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add new blog"),
        BottomNavigationBarItem(icon: Icon(Icons.logout), label: "Logout"),
      ],
      backgroundColor: Colors.blueAccent,
      selectedItemColor: Colors.white,
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
        switch (index) {
          case 0:
            Navigator.of(context).pushNamed(Routes().blogsHomePageRoute);
            break;
          case 1:
            Navigator.of(context).pushNamed(Routes().addNewBlogPageRoute);
            break;
          case 2:
            AuthImplementation().signOutUser();
            Navigator.of(context).pushNamedAndRemoveUntil(
                Routes().loginPageRoute, (route) => false);
            break;
        }
      },
    );
  }
}
