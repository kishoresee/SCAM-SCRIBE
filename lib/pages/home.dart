import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spamexposeapp/pages/add_item1.dart';
import 'package:spamexposeapp/pages/help.dart';
import 'package:spamexposeapp/pages/item_list1.dart';
import 'package:spamexposeapp/pages/login.dart';
import 'package:spamexposeapp/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainHome extends StatefulWidget {
  final String? username; // Define username parameter
  const MainHome({Key? key, this.username}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  final RxString savedEvent = ''.obs;
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
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.post_add),
              label: 'Post',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          selectedItemColor: Colors.amber[800],
          onTap: (index) {
            switch (index) {
              case 0:
                Get.to(() => {}); // Replace with your home page widget
                break;
              case 1:
                Get.to(() =>
                    NewAddItem()); // Replace with your profile page widget
                break;
              case 2:
                Get.to(() => Help()); // Replace with your settings page widget
                break;
            }
          },
        ),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.notifications,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            const SizedBox(width: 0),
          ],
          title: Row(
            children: [
              const SizedBox(width: 10, height: 30),
              Text(
                '        SCAMscribe',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
          backgroundColor: const Color.fromARGB(255, 151, 11, 32),
        ),
        drawer: Drawer(
          backgroundColor: const Color.fromARGB(255, 151, 11, 32),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: 200,
                color: const Color.fromARGB(255, 151, 11, 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      child: ClipOval(
                        child: Image.asset(
                          'asset/download.png',
                          width: 120,
                          height: 120,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _username ?? 'Loading...',
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      currentUser?.email ?? 'No email available',
                      style: const TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ],
                ),
              ),
              const Divider(height: 7),
              ListTile(
                leading: const Icon(Icons.group, color: Colors.white),
                title: const Text(
                  'My Network',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Get.to(() => Help()); // Replace with your network page widget
                },
              ),
              ListTile(
                leading: const Icon(Icons.schedule, color: Colors.white),
                title: const Text(
                  'Schedule',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Get.to(
                      () => Help()); // Replace with your schedule page widget
                },
              ),
              ListTile(
                leading: const Icon(Icons.celebration, color: Colors.white),
                title: const Text(
                  'Events',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Get.to(() => Help()); // Replace with your events page widget
                },
              ),
              ListTile(
                leading: const Icon(Icons.feedback, color: Colors.white),
                title: const Text(
                  'Help and Support',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Get.to(() => Help()); // Replace with your help page widget
                },
              ),
              ListTile(
                leading: const Icon(Icons.library_books, color: Colors.white),
                title: const Text(
                  'LMS',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () async {
                  const urlString =
                      'https://sathyabama.cognibot.in/login/index.php';
                  final uri = Uri.parse(urlString);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                  } else {
                    Utils.showSnackBar(context, 'Could not launch $uri');
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.help, color: Colors.white),
                title: const Text(
                  'Categories',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Get.to(() => {}); // Replace with your categories page widget
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: Color.fromARGB(255, 189, 182, 182),
                ),
                title: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  FirebaseAuth.instance
                      .signOut(); // Ensure the user is logged out
                  Get.to(
                      () => const SigninPage()); // Navigate to the SigninPage
                },
              ),
            ],
          ),
        ),
        body: ItemLiyy() // Your main content goes here
        );
  }
}
