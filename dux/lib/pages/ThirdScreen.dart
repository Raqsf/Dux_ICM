import 'dart:io';
import 'package:flutter/material.dart';

  
class ThirdScreen extends StatefulWidget {  
  @override  
  _ProfilePageState createState() => _ProfilePageState();
}  

class _ProfilePageState extends State<ThirdScreen> {
  final double coverHeight = 280;
  final double profileHeight = 144;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(30.0),
        children: <Widget>[
          buildTop(),
          buildContent(),
        ],
      ), 
    );
  }

  Widget buildContent() => Column(
    children: [
      const SizedBox(height: 8),
      Text('Flávio Pereira', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      Text('Software Engineer', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal)),
     
      const SizedBox(height: 16),
      Divider(),
      const SizedBox(height: 16),
    ],
  );
  
  Widget buildTop() {
    final top = coverHeight - profileHeight/2;
    final bottom = profileHeight / 2;
    return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: bottom),
            child: buildCoverImage()
          ),
          Positioned(
            top: top,
            child: buildProfileImage()
            ),
        ],
      );
  }

  Widget buildCoverImage() => Container( 
    color: Colors.grey,
    child: Image.network('https://data.whicdn.com/images/344678427/original.jpg',
      width: double.infinity,
      fit: BoxFit.cover,
      height: coverHeight,
    ),
  );

  Widget buildProfileImage() => CircleAvatar(
    radius: profileHeight / 2,
    backgroundColor: Colors.white,
    child: CircleAvatar(
      backgroundImage: NetworkImage('http://www.mandysam.com/img/random.jpg'),
      radius: profileHeight / 2 - 10),
     );
}