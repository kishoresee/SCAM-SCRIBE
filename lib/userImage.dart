import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
class UserImagePicker extends StatefulWidget {
  const UserImagePicker({Key? key});

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile;

  void _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 120,
    );

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentuser = FirebaseAuth.instance.currentUser;

    return Container(
      
      
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          CircleAvatar(
            radius: 36,
            backgroundColor: Colors.grey,
            foregroundImage:
                _pickedImageFile != null ? FileImage(_pickedImageFile!) : null,
          ),
          TextButton.icon(
            onPressed: _pickImage,
            icon: const Icon(Icons.image, color: Colors.black),
            label: Text(
              'Add image',
              style: TextStyle(color: Colors.black),
            ),
          ),
          Container(height: 70,width: 00,
            child: UserAccountsDrawerHeader(
              accountName: Text(
                'Kishore S',
                style: TextStyle(fontSize: 18),
              ),
              accountEmail: Text(
                currentuser?.email ?? 'No email available',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
