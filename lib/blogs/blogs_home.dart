import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blogs_app/blogs/blog_post.dart';
import 'package:flutter_blogs_app/common_files/constants.dart';

import '../authentication/firebase_authentication.dart';

class BlogsHomePage extends StatefulWidget {
  const BlogsHomePage({Key? key}) : super(key: key);

  @override
  State<BlogsHomePage> createState() => _BlogsHomePageState();
}

class _BlogsHomePageState extends State<BlogsHomePage> {
  int _selectedIndex = 0;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('Blogs');

  Future<List<BlogPost>> snapshot() async {
    List<BlogPost> blogPosts = [];
    var value;
    await ref.once().then((snapData) {
      value = snapData.snapshot.value;
    });

    if (value != null) {
      value.forEach(
        (key, value) {
          BlogPost blogPost = BlogPost(
              image: value['image'],
              description: value['description'],
              date: value['date'],
              time: value['time']);
          blogPosts.add(blogPost);
        },
      );
    } else {
      print('No Data Available');
    }

    return blogPosts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Blogs')),
      body: FutureBuilder(
        future: snapshot(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            int? itemCount = snapshot.data?.length;
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: itemCount,
              itemBuilder: (context, index) {
                return blogUI(
                  snapshot.data![index].image,
                  snapshot.data![index].description,
                  snapshot.data![index].date,
                  snapshot.data![index].time,
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Text("No data found");
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add new blog"),
        BottomNavigationBarItem(
            icon: Icon(Icons.wallpaper), label: "Wallpapers"),
        BottomNavigationBarItem(icon: Icon(Icons.logout), label: "Logout"),
      ],
      backgroundColor: Colors.lightBlue,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.blueGrey,
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
            Navigator.of(context).pushNamed(Routes().wallpapersHomePageRoute);
            break;
          case 3:
            AuthImplementation().signOutUser();
            Navigator.of(context).pushNamedAndRemoveUntil(
                Routes().loginPageRoute, (route) => false);
            break;
        }
      },
    );
  }

  Widget blogUI(String image, String description, String date, String time) {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.all(15),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date,
                  textAlign: TextAlign.center,
                ),
                Text(
                  time,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Image.network(
              image,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            Text(
              description,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
