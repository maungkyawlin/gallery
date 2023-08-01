import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signin_sqflite/views/image_input.dart';

import '../models/image_model.dart';

class MyInputScreen extends StatefulWidget {
  static const route = 'MyInputScreen';
  const MyInputScreen({super.key});

  @override
  State<MyInputScreen> createState() => _MyInputScreenState();
}

class _MyInputScreenState extends State<MyInputScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  File? savedImage;
  void savedImages(File image) {
    savedImage = image;
  }

  void onSave() {
    if (_titleController.text.isEmpty ||
        _contentController.text.isEmpty ||
        savedImage == null) {
      return;
    } else {
      Provider.of<ImageFile>(context, listen: false).addImagePlace(
          _titleController.text, _contentController.text, savedImage!);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Input Data"),
        actions: [
          IconButton(
              onPressed: () {
                onSave();
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:8.0),
          child: Column(
            children: [
              Container(
                margin:const  EdgeInsets.all(10),
                child: TextField(
                  controller: _titleController,
                  
                  decoration: const InputDecoration(
                    
                    border: OutlineInputBorder(),
                    prefixIcon:Icon(Icons.title),
                    labelText: "Title",),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: TextField(
                  controller: _contentController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    
                    prefixIcon: Icon(Icons.description),
                    labelText: "Content",border: OutlineInputBorder()),
                ),
              ),
              ImageInput(savedImages),
            ],
          ),
        ),
      ),
    );
  }
}
