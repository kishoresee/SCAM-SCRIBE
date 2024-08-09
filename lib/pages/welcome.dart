import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spamexposeapp/pages/login.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 110, 50, 201),
                Color.fromARGB(255, 38, 41, 228),
              ],
            ),
            image: DecorationImage(
              image: AssetImage('asset/Splash.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 60),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.asset(
                          'asset/download.png',
                          width: 90,
                          height: 90,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 100),
                  Icon(
                    Icons.event_available_sharp,
                    color: const Color.fromARGB(255, 206, 190, 47),
                    size: 70,
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'SCAM',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 234, 51, 51),
                            fontSize: 25,
                          ),
                        ),
                        Text(
                          'scribe',
                          style: TextStyle(
                            color: Color.fromARGB(255, 19, 19, 19),
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  Padding(
                    padding: EdgeInsets.all(7.0),
                    child: Text(
                      "Scam Alerts, No More Hurts",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  SizedBox(height: 300),
                ],
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.to(() => SigninPage());
                      },
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                          color: Color.fromARGB(255, 16, 16, 15),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Color.fromARGB(255, 219, 73, 47),
                    ),SizedBox(height: 400,)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
