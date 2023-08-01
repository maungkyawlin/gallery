import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/image_model.dart' as ima;

class DetailScreen extends StatelessWidget {
  static const route = "DetailScreen";
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final imageId = ModalRoute.of(context)!.settings.arguments.toString();
    final image =
        Provider.of<ima.ImageFile>(context, listen: false).findImage(imageId);
    return Scaffold(
      appBar: AppBar(
        title: Text("${image.title}"),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            height: 350,
            width: double.infinity,
            child: Image.file(
              image.image!,
              fit: BoxFit.cover,
            ),
          ),
          Text("${image.title}" ,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
           Text("${image.content}" ,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
            Text("${image.id}" ,style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
        ],
      )),
    );
  }
}
