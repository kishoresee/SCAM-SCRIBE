import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spamexposeapp/pages/home.dart';
import 'package:spamexposeapp/userImage.dart';

class AccountPage extends StatefulWidget {
  final String? username; // Define username parameter

  const AccountPage({Key? key, this.username}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final currentUser = FirebaseAuth.instance.currentUser;
  String? _username;

  @override
  void initState() {
    super.initState();
    _fetchUsername();
  }

  Future<void> _fetchUsername() async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('user')
          .doc(currentUser?.uid)
          .get();

      setState(() {
        _username = userSnapshot['username'];
      });
    } catch (error) {
      print("Error fetching username: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Builder(
              builder: (context) => IconButton(
                onPressed: () {
                  Get.to(MainHome());
                },
                icon: Icon(Icons.arrow_back),
              ),
            ),
            SizedBox(
              width: 80,
            ),
            Text('PROFILE'),
          ],
        ),
      ),
      body: Container(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: UserImagePicker(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Username: ${widget.username ?? _username ?? 'Loading...'}',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  currentUser?.email ?? 'No email available',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 7,
                ),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text(
                    '995266622',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.mail),
                  title: Text(
                    currentUser?.email ?? 'No email available',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.calendar_month),
                  title: Text(
                    'DOB:09/12/2003',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Divider(
                  thickness: 7,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
