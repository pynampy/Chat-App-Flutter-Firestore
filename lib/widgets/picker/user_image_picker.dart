import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserImagePicker extends StatefulWidget {

  final Function(File pickedImage) imagePickFn;
  UserImagePicker(this.imagePickFn);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;
  final _picker = ImagePicker();

  void _pickImage() async {
    try{
      final pickedImageFile = await _picker.getImage(source: ImageSource.camera,imageQuality: 40,
      maxWidth: 150, maxHeight: 150);
      setState(() {
      _pickedImage = File(pickedImageFile.path);
      widget.imagePickFn(_pickedImage);
    });


    }catch(_){
      return;
    }
    
    
  
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      CircleAvatar(
        backgroundColor: Colors.grey,
        backgroundImage: _pickedImage != null ? FileImage(_pickedImage): null,
        radius: 40,
      ),
      FlatButton.icon(
          textColor: Theme.of(context).primaryColor,
          onPressed: () {
            _pickImage();

          },
          icon: Icon(Icons.image),
          label: Text(
            "Add Image",
          ))
    ]);
  }
}
