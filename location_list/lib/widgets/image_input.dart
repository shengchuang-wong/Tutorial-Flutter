import 'dart:io' as DartIO;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  DartIO.File _storedImage;
  final _picker = ImagePicker();

  Future<void> _takePicture() async {
    try {
      final imageFile =
          await _picker.getImage(source: ImageSource.camera, maxWidth: 600);
      if (imageFile == null) {
        return;
      }
      setState(() {
        _storedImage = DartIO.File(imageFile.path);
      });
      final appDir = await syspaths.getApplicationDocumentsDirectory();
      final filename = path.basename(_storedImage.path);
      final savedImage = await _storedImage.copy('${appDir.path}/$filename');
      widget.onSelectImage(savedImage);
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: FlatButton.icon(
            icon: Icon(Icons.camera),
            label: Text('Take Picture'),
            textColor: Theme.of(context).primaryColor,
            onPressed: () {
              _takePicture();
            },
          ),
        ),
      ],
    );
  }
}
