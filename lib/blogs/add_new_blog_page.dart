import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddNewBlogPage extends StatefulWidget {
  const AddNewBlogPage({Key? key}) : super(key: key);

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  ImagePicker picker = ImagePicker();
  XFile? selectedImage;

  TextEditingController descriptionTextController = TextEditingController();

  Future getImage(ImageSource media) async {
    XFile? img = await picker.pickImage(source: media);
    setState(() {
      selectedImage = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new blog'),
      ),
      body: Column(children: <Widget>[
        selectedImage != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    File(selectedImage!.path),
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                  ),
                ),
              )
            : const Text(
                "No Image",
                style: TextStyle(fontSize: 20),
              ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: TextField(
            maxLines: 3,
            controller: descriptionTextController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter description',
            ),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
            onPressed: () {
              print(descriptionTextController.text);
            },
            child: const Text('Submit')),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getImage(ImageSource.gallery);
        },
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
