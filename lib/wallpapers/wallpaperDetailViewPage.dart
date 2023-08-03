import 'package:flutter/material.dart';

class WallpaperDetailView extends StatefulWidget {
  final String imageUrl;
  const WallpaperDetailView({Key? key, required this.imageUrl})
      : super(key: key);

  @override
  State<WallpaperDetailView> createState() => _WallpaperDetailViewState();
}

class _WallpaperDetailViewState extends State<WallpaperDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Image.network(widget.imageUrl),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                height: 60,
                width: double.infinity,
                color: Colors.blueAccent,
                child: const Center(
                  child: Text(
                    'Set as wallpaper',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
