import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:signin_sqflite/views/details_screen.dart';
import 'package:signin_sqflite/views/text_input.dart';

import '../models/image_model.dart' as ima;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Gallery"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, MyInputScreen.route);
        },
        child: const Icon(Icons.image),
      ),
      body: FutureBuilder(
        future: Provider.of<ima.ImageFile>(context, listen: false).fatchImage(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<ima.ImageFile>(
                    child: const Center(child:  Text("Start adding your story",style: TextStyle(color: Colors.black),)),

                    builder: (ctx, uimages, ch) {
                      if (uimages.items.isEmpty) {
                        return ch!;
                      } else {
                        return GridView.builder(
                          itemCount:uimages.items.length ,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                          ),
                          itemBuilder: (ctx, i) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridTile(
                              footer: GridTileBar(
                                leading: Text(
                                  "${uimages.items[i].title}",
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              
                                trailing: Text(
                                  "${uimages.items[i].id}",
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(22),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, DetailScreen.route,
                                        arguments: uimages.items[i].id);
                                  },
                                  child: Image.file(
                                    uimages.items[i].image!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          
                        );
                      }
                    },
                  ),
      ),
    );
  }
}
