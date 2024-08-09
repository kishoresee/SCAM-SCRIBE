import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spamexposeapp/pages/edit_item.dart';

class NewItemDetails extends StatelessWidget {
  NewItemDetails(this.itemId, {Key? key}) : super(key: key) {
    _reference =
        FirebaseFirestore.instance.collection('Post_details').doc(itemId);
    _futureData = _reference.get();
  }

  String itemId;
  late DocumentReference _reference;

  late Future<DocumentSnapshot> _futureData;
  late Map data;

  Future<void> _updateLikes(int currentLikes) async {
    await _reference.update({'likes': currentLikes + 1});
  }

  Future<void> _updateDislikes(int currentDislikes) async {
    await _reference.update({'dislikes': currentDislikes + 1});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scam details'),
        actions: [
          IconButton(
              onPressed: () {
                data['id'] = itemId;

                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => EditItem(data)));
              },
              icon: Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                _reference.delete();
              },
              icon: Icon(Icons.delete))
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: _futureData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Some error occurred ${snapshot.error}'));
          }

          if (snapshot.hasData) {
            DocumentSnapshot documentSnapshot = snapshot.data;
            data = documentSnapshot.data() as Map;

            return Column(
              children: [
                if (data.containsKey('image'))
                  Image.network(
                    data['image'],
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                SizedBox(height: 8),
                Text('${data['name']}'),
                Text('${data['quantity']}'),
                Text('${data['estimate']}'),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.thumb_up),
                      onPressed: () {
                        _updateLikes(data['likes'] ?? 0);
                      },
                    ),
                    Text('${data['likes'] ?? 0}'),
                    SizedBox(width: 16),
                    IconButton(
                      icon: Icon(Icons.thumb_down),
                      onPressed: () {
                        _updateDislikes(data['dislikes'] ?? 0);
                      },
                    ),
                    Text('${data['dislikes'] ?? 0}'),
                  ],
                ),
              ],
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
