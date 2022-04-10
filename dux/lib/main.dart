import 'package:flutter/material.dart';
import './pages/FirstScreen.dart';
import './pages/SecondScreen.dart';
import './pages/ThirdScreen.dart';
import 'pages/Profile_Data/ProfilePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      //theme: ThemeData(primaryColor: Colors.black),
      home: const MyFirstScreen(),
    );
  }
}

class MyFirstScreen extends StatefulWidget {
  const MyFirstScreen({Key? key}) : super(key: key);

  @override
  State<MyFirstScreen> createState() => _MyFirstScreenState();
}

class _MyFirstScreenState extends State<MyFirstScreen> {
  // state variables
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<Widget> _widgetOptions = <Widget>[
    FirstScreen(),
    SecondScreen(),
    ThirdScreen(),
    Container(
      child: const Text("Fourth page"),
    ),
    Container(
      child: const Text("Fifth page"),
    ),
    ProfilePage(),
  ];

  static const List<Widget> _pages = <Widget>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My App'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(250, 5, 156, 156),
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(canvasColor: Color(0xfff0f0f0)),
            child: BottomNavigationBar(
                showSelectedLabels: false,
                showUnselectedLabels: false,
                unselectedItemColor: const Color(0xffbbbbbb),
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home_filled), label: ""),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.calendar_month_outlined), label: ""),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.calendar_view_week_outlined), label: ""),
                  BottomNavigationBarItem(icon: Icon(Icons.timer), label: ""),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.edit_calendar_rounded), label: ""),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person_pin_rounded), label: "")
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: const Color(0xff777777),
                onTap: _onItemTapped)));
  }
}
