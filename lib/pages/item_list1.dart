import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spamexposeapp/pages/item_details1.dart';
import 'package:spamexposeapp/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemLiyy extends StatefulWidget {
  ItemLiyy({Key? key}) : super(key: key);

  @override
  _ItemLiyyState createState() => _ItemLiyyState();
}

class _ItemLiyyState extends State<ItemLiyy> {
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('Post_details');

  late Stream<QuerySnapshot> _stream;
  String? _username;

  @override
  void initState() {
    super.initState();
    _stream = _reference.snapshots();
    _fetchUsername();
  }

  Future<void> _fetchUsername() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('user')
            .doc(currentUser.uid)
            .get();

        setState(() {
          _username = userSnapshot['username'] ?? 'Anonymous';
        });
      }
    } catch (error) {
      print("Error fetching username: $error");
      setState(() {
        _username = 'Anonymous';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Some error occurred ${snapshot.error}'));
          }

          if (snapshot.hasData) {
            QuerySnapshot querySnapshot = snapshot.data!;
            List<QueryDocumentSnapshot> documents = querySnapshot.docs;
            List<Map<String, dynamic>> items = documents.map((e) {
              Map<String, dynamic> item = e.data() as Map<String, dynamic>;
              item['id'] = e.id;
              return item;
            }).toList();

            return SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: items.map((item) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => NewItemDetails(item['id']),
                          ));
                        },
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (item.containsKey('image'))
                                Image.network(
                                  item['image'],
                                  height: 450,
                                  fit: BoxFit.cover,
                                ),
                              SizedBox(height: 8),
                              // Display the username on top of the post
                              Text(
                                'Posted by: ${item['username'] ?? _username ?? 'Anonymous'}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 8),
                              Center(
                                child: Row(
                                  children: [
                                    SizedBox(width: 110),
                                    Text(
                                      'Victim of:',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      item['name'] ?? 'N/A',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Center(
                                child: Row(
                                  children: [
                                    SizedBox(width: 110),
                                    Text(
                                      'Estimate:',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      item['estimate'] ?? 'N/A',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 4),
                              ElevatedButton(
                                onPressed: () async {
                                  if (item.containsKey('quantity') &&
                                      item['quantity'] != null) {
                                    final urlString = '${item['quantity']}';
                                    final uri = Uri.parse(urlString);
                                    if (await canLaunchUrl(uri)) {
                                      await launchUrl(uri);
                                    } else {
                                      Utils.showSnackBar(
                                          context, 'Could not launch $uri');
                                    }
                                  } else {
                                    Utils.showSnackBar(context,
                                        'Quantity is not available for this item.');
                                  }
                                },
                                child: Text('Apply'),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  if (item['estimate'] != null) {
                                    print(
                                        'Deleting item with estimate: ${item['estimate']}');
                                  } else {
                                    print('Deleting item without estimate');
                                  }

                                  try {
                                    if (item.containsKey('image')) {
                                      var imageUrl = item['image'];
                                      var imageRef = FirebaseStorage.instance
                                          .refFromURL(imageUrl);
                                      await imageRef.delete();
                                      print('Image deleted successfully');
                                    }

                                    await FirebaseFirestore.instance
                                        .collection('Post_details')
                                        .doc(item['id'])
                                        .delete();

                                    Utils.showSnackBar(context, 'Item deleted');
                                  } catch (e) {
                                    Utils.showSnackBar(
                                        context, 'Error deleting item: $e');
                                    print('Error: $e');
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                child: Text('Delete'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
