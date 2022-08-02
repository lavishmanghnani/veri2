import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? image;

  Future imagePicker() async {
    try {
      final image1 =
          await ImagePicker.platform.pickImage(source: ImageSource.gallery);
      if (image1 == null) return;
      final imageTemporary = File(image1.path);
      setState(() => this.image = imageTemporary);
      this.image = imageTemporary;
      print(image.toString());
    } on PlatformException catch (e) {
      print('Failed to pick image : $e');
    }
  }

  late File imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              image != null
                  ? Image.file(
                      image!,
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                    )
                  : Center(
                      child: ElevatedButton(
                      child: Text("Please Select a image"),
                      onPressed: () {
                        imagePicker();
                      },
                    ))
            ]),
      ),
    );
  }
}
