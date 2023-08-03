import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blogs_app/wallpapers/wallpaperDetailViewPage.dart';
import 'package:http/http.dart' as http;

class WallpapersHomePage extends StatefulWidget {
  const WallpapersHomePage({Key? key}) : super(key: key);

  @override
  State<WallpapersHomePage> createState() => _WallpapersHomePageState();
}

class _WallpapersHomePageState extends State<WallpapersHomePage> {
  List images = [];
  int pageNumber = 1;
  @override
  void initState() {
    super.initState();
    wallpapersAPI();
  }

  Future wallpapersAPI() async {
    await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=30'),
        headers: {
          'Authorization':
              'wlR4eqScsiblnKkUQLQfk91qIfxwQa32MAIeSidj2tUHOz0kWV3BKPdt'
        }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images = result['photos'];
      });
    });
  }

  Future loadMoreWallpapers() async {
    pageNumber += 1;
    String url =
        'https://api.pexels.com/v1/curated?per_page=30&page=$pageNumber';
    await http.get(Uri.parse(url), headers: {
      'Authorization':
          'wlR4eqScsiblnKkUQLQfk91qIfxwQa32MAIeSidj2tUHOz0kWV3BKPdt'
    }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images.addAll(result['photos']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallpapers'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.blueGrey,
              child: GridView.builder(
                itemCount: images.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  childAspectRatio: 2 / 3,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return WallpaperDetailView(
                            imageUrl: images[index]['src']['large2x'],
                          );
                        },
                      ));
                    },
                    child: Container(
                      color: Colors.white,
                      child: Image.network(
                        images[index]['src']['tiny'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          InkWell(
            onTap: () {
              loadMoreWallpapers();
            },
            child: Container(
              height: 60,
              width: double.infinity,
              color: Colors.blueAccent,
              child: const Center(
                child: Text(
                  'Load more',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
