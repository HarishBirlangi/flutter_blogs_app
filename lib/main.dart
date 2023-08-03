import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blogs_app/authentication/firebase_authentication.dart';
import 'package:flutter_blogs_app/authentication/user_login_page.dart';
import 'package:flutter_blogs_app/blogs/add_new_blog_page.dart';
import 'package:flutter_blogs_app/blogs/blogs_home.dart';
import 'package:flutter_blogs_app/common_files/constants.dart';
import 'package:flutter_blogs_app/wallpapers/wallpapersHomePage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool currentUserLogin() {
      String? currentUser = AuthImplementation().getCurrentUser();
      if (currentUser == null) {
        return false;
      } else {
        return true;
      }
    }

    return MaterialApp(
      title: 'Flutter Blogs App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: currentUserLogin()
          ? Routes().blogsHomePageRoute
          : Routes().loginPageRoute,
      routes: {
        Routes().loginPageRoute: (context) => const LoginPage(),
        Routes().blogsHomePageRoute: (context) => const BlogsHomePage(),
        Routes().addNewBlogPageRoute: (context) => const AddNewBlogPage(),
        Routes().wallpapersHomePageRoute: (context) =>
            const WallpapersHomePage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
