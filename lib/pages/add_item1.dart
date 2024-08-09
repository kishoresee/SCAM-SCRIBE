import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewAddItem extends StatefulWidget {
  const NewAddItem({Key? key}) : super(key: key);

  @override
  State<NewAddItem> createState() => _NewAddItemState();
}

class _NewAddItemState extends State<NewAddItem> {
  final User? user = FirebaseAuth.instance.currentUser;

  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerEstimate = TextEditingController();
  TextEditingController _controllerQuantity = TextEditingController();

  GlobalKey<FormState> key = GlobalKey();

  CollectionReference _reference =
      FirebaseFirestore.instance.collection('Post_details');

  String imageUrl = '';
  String? username;

  @override
  void initState() {
    super.initState();
    // Fetch the current user's username from Firestore
    FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          username = documentSnapshot['username'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add an item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: key,
          child: Column(
            children: [
              TextFormField(
                controller: _controllerName,
                decoration: InputDecoration(
                    hintText: 'Eg: financial, employment, real estate..etc'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the item name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _controllerEstimate,
                decoration: InputDecoration(hintText: 'Eg: ₹20,000'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the item estimate';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _controllerQuantity,
                decoration: InputDecoration(
                    hintText: 'Enter the drive link (optional)'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the item quantity';
                  }
                  return null;
                },
              ),
              IconButton(
                  onPressed: () async {
                    ImagePicker imagePicker = ImagePicker();
                    XFile? file = await imagePicker.pickImage(
                        source: ImageSource.gallery);
                    if (file == null) return;

                    String uniqueFileName =
                        DateTime.now().millisecondsSinceEpoch.toString();

                    Reference referenceRoot = FirebaseStorage.instance.ref();
                    Reference referenceDirImages = referenceRoot.child('event');

                    Reference referenceImageToUpload =
                        referenceDirImages.child(uniqueFileName);

                    try {
                      await referenceImageToUpload.putFile(
                        File(file.path),
                        SettableMetadata(contentType: 'image/jpg'),
                      );
                      imageUrl = await referenceImageToUpload.getDownloadURL();
                      setState(() {
                        imageUrl = imageUrl;
                      });
                    } catch (error) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Error uploading image: $error')));
                    }
                  },
                  icon: Icon(Icons.camera_alt)),
              ElevatedButton(
                  onPressed: () async {
                    if (imageUrl.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please upload an image')));
                      return;
                    }

                    if (key.currentState!.validate()) {
                      String itemName = _controllerName.text;
                      String itemEstimate = _controllerEstimate.text;
                      String itemQuantity = _controllerQuantity.text;

                      // Create a Map of data
                      Map<String, String> dataToSend = {
                        'name': itemName,
                        'estimate': itemEstimate,
                        'quantity': itemQuantity,
                        'image': imageUrl,
                        'userId': user?.uid ?? '',
                        'username': username ?? 'Anonymous',
                      };

                      // Add a new item
                      _reference.add(dataToSend);
                    }
                  },
                  child: Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }
}
