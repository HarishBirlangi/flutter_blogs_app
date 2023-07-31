import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../common_files/constants.dart';

class AddNewBlogPage extends StatefulWidget {
  const AddNewBlogPage({Key? key}) : super(key: key);

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  ImagePicker picker = ImagePicker();
  XFile? selectedImage;
  bool isLoading = false;

  TextEditingController descriptionTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add new blog'),
        ),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
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
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                String imageUrl =
                    await generateImageUrlFirebase(selectedImage!);
                await saveToDatabase(imageUrl);
                setState(() {
                  isLoading = false;
                });
                Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes().blogsHomePageRoute, (route) => false);
              },
              child: (isLoading)
                  ? const SizedBox(
                      width: 10,
                      height: 10,
                      child: CircularProgressIndicator(
                        color: Colors.black,
                        strokeWidth: 1.5,
                      ))
                  : const Text('Submit'),
            ),
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            getImage(ImageSource.gallery);
          },
          child: const Icon(Icons.add_a_photo),
        ),
      ),
    );
  }

  Future getImage(ImageSource media) async {
    XFile? img = await picker.pickImage(source: media);
    setState(() {
      selectedImage = img;
    });
  }

  Future<String> generateImageUrlFirebase(XFile image) async {
    Reference ref = FirebaseStorage.instance.ref().child("Blog Images");
    String timeKey = DateTime.now().toString();
    UploadTask uploadTask = ref.child("$timeKey.jpg").putFile(File(image.path));

    String imageUrl = await (await uploadTask).ref.getDownloadURL();
    return imageUrl;
  }

  Future<void> saveToDatabase(String url) async {
    DateTime dbTimeKey = DateTime.now();
    String date = DateFormat('MMM d, yyyy').format(dbTimeKey);
    String time = DateFormat('EEEE, hh:mm aaa').format(dbTimeKey);
    DatabaseReference ref = FirebaseDatabase.instance.ref();

    Map<String, String> data = {
      "image": url,
      "description": descriptionTextController.text,
      "date": date,
      "time": time,
    };
    await ref.child('Blogs').push().set(data);
  }
}
