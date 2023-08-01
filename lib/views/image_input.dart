import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart'as path;
import 'package:path_provider/path_provider.dart' as sysPath;

class ImageInput extends StatefulWidget {
  final Function imagesaveat;
  const ImageInput(this.imagesaveat, {super.key});
  


  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File?   _imageFile;
  

Future<void> _cameraImage() async{
  final picker=ImagePicker();
  final imageFile=await picker.pickImage(source:ImageSource.camera,maxWidth:600);
  if(imageFile==null){
    return;

  }
  setState(() {
    _imageFile=File(imageFile.path);
  });

  final appDir=await sysPath.getApplicationDocumentsDirectory();
  final fileName=path.basename(imageFile.path);
  final saveImagePath=await _imageFile!.copy('${appDir.path}/$fileName');
  widget.imagesaveat(saveImagePath);
  }
  Future<void> _galleryImage() async{
  final picker=ImagePicker();
  final imageFile=await picker.pickImage(source:ImageSource.gallery,maxWidth:600);
  if(imageFile==null){
    return ;

  }
  setState(() {
    _imageFile=File(imageFile.path);
  });

  final appDir=await sysPath.getApplicationDocumentsDirectory();
  final fileName=path.basename(imageFile.path);
  final saveImagePath=await _imageFile!.copy('${appDir.path}/$fileName');
  widget.imagesaveat(saveImagePath);
  
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 200,
            height: 200,
            decoration:
                BoxDecoration(border: Border.all(width: 2, color: Colors.black)),
                child: _imageFile !=null?Image.file(_imageFile!,fit: BoxFit.cover,):const Center(child: Text("No Image, Add One")),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          TextButton.icon(onPressed: (){
           _galleryImage();

          }, icon: const Icon(Icons.image),label: const Text("Add your Image"),),
          TextButton.icon(onPressed: (){

          _cameraImage();
          }, icon: const Icon(Icons.camera_alt), label:const Text ("Take Picture"))
        ],)
      ],
    );
  }
}
