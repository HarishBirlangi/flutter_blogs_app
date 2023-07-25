import 'package:flutter/material.dart';

class AddNewBlogPage extends StatefulWidget {
  const AddNewBlogPage({Key? key}) : super(key: key);

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new blog'),
      ),
      body: Column(children: <Widget>[
        const TextField(),
        ElevatedButton(onPressed: () {}, child: const Text('Submit')),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: IconButton(
          icon: const Icon(Icons.image),
          onPressed: () {},
        ),
      ),
    );
  }
}
