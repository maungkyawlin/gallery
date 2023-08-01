import 'dart:io';

import 'package:flutter/material.dart';
import 'package:signin_sqflite/database/db_connection.dart';

class Image {
  final String? id;
  final String? title;
  final String? content;
  final File? image;
  Image(this.id, this.title, this.content, this.image);
}

class ImageFile with ChangeNotifier {
  List<Image> _items = [];
  List<Image> get items {
    return [
      ..._items.reversed,
    ];
  }

  Future<void> addImagePlace(String title, String content, File? image) async {
    final newImage = Image(DateTime.now().toString(), title, content, image!);

    _items.add(newImage);
    notifyListeners();

    DbConn.insert("images", {
      "id": newImage.id!,
      "title": newImage.title!,
      "content": newImage.content!, 
      "image": newImage.image!.path,
    });
    
  }

  Image findImage(String imageId) {
    return _items.firstWhere((image) => image.id == imageId);
  }

  Future<void> fatchImage() async {
    final list = await DbConn.getData('images');
    _items =list.map((item) =>Image((item['image']),item['title'],item['content'],item['id'])).toList();
    notifyListeners();
  }
}
