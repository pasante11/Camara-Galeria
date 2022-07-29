import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

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
      debugShowCheckedModeBanner: false,
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
  File? imageC;

  Widget _setImageView() {
    if (imageC!= null) {
      return Image.file(imageC!, width: 500, height: 500);
    } else {
      return Text("Please select an image");
    }
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);
      

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);

      //setState(() => this.image = imageTemp);
      setState(() => this.imageC = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

      // body: SafeArea(
      //   child: Center(
      //       child: image == null
      //           ? const Text('Agregar Imagen')
      //           //: Image.file(image!)),
      //           :Image.file(image!,width: 500,height: 500)
      //       ),
      // ),

      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Center(
            child: image == null
                ? const Text('Agregar Imagen')
                //: Image.file(image!)),
                :Image.file(image!)
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: _setImageView(),
            //  child: Center(
            // child: imageC == null
            //     ? const Text('Agregar Imagen')
            //     //: Image.file(image!)),
            //     :Image.file(imageC!)
            // ),
            // child:Image.file(image!)
            
          ),

          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            onPressed: () {
              print('Se Guardo');
             },
            child: Text('Guardar'),
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: const Icon(Icons.camera),
                          title: const Text('Camera'),
                          onTap: () {
                            pickImageC();
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.image),
                          title: const Text('Galeria'),
                          onTap: () {
                            pickImage();
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                });
          },

          tooltip: 'New Image',
          child: const Icon(Icons.add_a_photo_rounded)
   
          // child: FlatButton(
          //     onPressed: null, 
          //     child: Image.asset('path/the_image.png')
          //     )
       ),
    );
  }
}

