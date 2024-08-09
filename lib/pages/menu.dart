import 'dart:io';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spamexposeapp/pages/home.dart';
import 'package:spamexposeapp/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class NextPage extends StatefulWidget {
  final String? username; // Define username parameter
  const NextPage({Key? key, this.username}) : super(key: key);
  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  final RxString savedEvent = ''.obs;
  final currentUser = FirebaseAuth.instance.currentUser;
  String? _username;
  CarouselController controller = CarouselController();

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

  final currentuser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        actions: [
          SizedBox(
            width: 25,
          ),
          Image.asset(
            'asset/logo.png',
            width: 35,
            height: 35,
          ),
          SizedBox(
            width: 18,
          ),
          Text(
            'SATHYABAMA',
            style: TextStyle(
                fontSize: 17, color: Color.fromARGB(255, 228, 217, 8)),
          ),
          Text(
            ' EVENTS',
            style: TextStyle(
                fontSize: 17, color: Color.fromARGB(255, 245, 245, 240)),
          ),
          SizedBox(
            width: 10,
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            color: Colors.white,
            onPressed: () {
              //Get.offAll(SigninPage());
            },
          ),
          SizedBox(
            width: 20,
          )
        ],
        backgroundColor: Color.fromARGB(255, 151, 11, 32),
      ),
      drawer: Container(
        width: 300,
        child: Drawer(
          backgroundColor: Color.fromARGB(255, 151, 11, 32),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: 200, // Set the desired height for the header
                color: Color.fromARGB(
                    255, 151, 11, 32), // Color for the header background
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      child: ClipOval(
                        child: Image.asset(
                          'asset/logo1.png',
                          width: 120,
                          height: 120,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${widget.username ?? _username ?? 'Loading...'}',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    SizedBox(height: 5),
                    Text(
                      currentuser?.email ?? 'No email available',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Divider(
                    height: 7,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.next_plan,
                      color: Color.fromARGB(255, 192, 216, 94),
                    ),
                    title: Text(
                      'Upcoming Events',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () async {
                      Get.to({});
                    },
                  ),
                ],
              ),
              ListTile(
                leading: Icon(
                  Icons.done_all,
                  color: Colors.deepPurpleAccent,
                ),
                title: Text(
                  'Ongoing events',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () async {
                  const urlString = 'https://www.sathyabama.ac.in/events';
                  final uri = Uri.parse(urlString);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                  } else {
                    Utils.showSnackBar(context, 'Could not launch $uri');
                  }
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.online_prediction_sharp,
                  color: const Color.fromARGB(255, 231, 13, 85),
                ),
                title: Text(
                  'Social media',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () async {
                  const urlString =
                      'https://www.instagram.com/sathyabama.official/?hl=en';
                  final uri = Uri.parse(urlString);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                  } else {
                    Utils.showSnackBar(context, 'Could not launch $uri');
                  }
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Color.fromARGB(255, 189, 182, 182),
                ),
                title: Text(
                  'Settings',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Get.to({});
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.library_books,
                  color: Color.fromARGB(255, 220, 103, 202),
                ),
                title: Text(
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
                leading: Icon(
                  Icons.help,
                  color: Color.fromARGB(255, 6, 134, 112),
                ),
                title: Text(
                  'Help',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Get.to({});
                },
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: MainHome(),
      ),
    );
  }
}
