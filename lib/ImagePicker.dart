import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TestImage extends StatefulWidget {
  const TestImage({Key? key}) : super(key: key);

  @override
  State<TestImage> createState() => _TestImageState();
}

class _TestImageState extends State<TestImage> {
  File? _image;

  Future getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;

    final imageTemporary = File(image.path);

    setState(() {
      this._image = imageTemporary;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Je test les images'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            _image != null
                ? Image.file(
                    _image!,
                    width: 250,
                    height: 250,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    'https://media.gettyimages.com/id/1291894999/fr/photo/vue-rouge-de-c%C3%B4t%C3%A9-de-voiture-de-sport-disolement-sur-le-blanc.jpg?s=612x612&w=0&k=20&c=f3HIlXlpOwLo5Wloh5IYwNwMrrEh-IPa2dhyupCaF54='),
            CustomButton(
                title: 'Prendre une image depuis le tel',
                icon: Icons.image_outlined,
                onClick: () => getImage(ImageSource.gallery)),
            CustomButton(
                title: 'Prendre une photo',
                icon: Icons.camera_alt,
                onClick: () => getImage(ImageSource.camera)),
          ],
        ),
      ),
    );
  }
}

Widget CustomButton({
  required String title,
  required IconData icon,
  required VoidCallback onClick,
}) {
  return Container(
    width: 280,
    child: ElevatedButton(
      onPressed: onClick,
      child: Row(
        children: [
          Icon(icon),
          SizedBox(
            width: 20,
          ),
          Text(title)
        ],
      ),
    ),
  );
}
