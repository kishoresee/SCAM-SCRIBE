import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Help extends StatelessWidget {
  const Help({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back, color: Colors.white)),
        title: Text('          Contact Us',style: TextStyle(color: Colors.white),),
        backgroundColor: Color.fromARGB(255, 151, 11, 32),
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
         // mainAxisAlignment: MainAxisAlignment.center,
         
          children: [
           
            SizedBox(height: 20,),
            Center(
            
              child: 
              Text('Dean of Student : dean.studentaffairs@sathyabama.ac.in',style: TextStyle(fontWeight: FontWeight.bold),),
            ),
             SizedBox(
              height: 40,
            ),
             Center(
              child: Text(
                'Dean of Computing : dean.computing@sathyabama.ac.in',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
             SizedBox(
              height: 40,
            ),
             Center(
              child: Text(
                'Student helpdesk : studenthelpdesk@sathyabama.ac.in',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 40,
            ),
             Center(
              child: Text(
                'Feedback :                feedback@sathyabama.ac.in.',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
            children: [
              Icon(Icons.phone,color: Colors.green,),
              Text('  Computer Science and Engineering:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
            ],
            ),
             SizedBox(
              height: 10,
            ),
            Text('044 – 2450 3159',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
             SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Icon(Icons.phone,color: Colors.green,),
                Text('  Information Technology:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text('044 – 2450 3160',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}