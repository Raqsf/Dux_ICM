import 'package:dux/pages/Schedule_Data/schedule.dart';
import 'package:flutter/material.dart';
import './pages/SecondScreen.dart';
import './pages/ThirdScreen.dart';
import 'pages/Profile_Data/ProfilePage.dart';
import 'package:dux/pages/Home_Data/HomePage.dart';
import 'pages/Calendar_Data/Calendar.dart';
import 'pages/Pomodoro_Data/Pomodoro.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // Define the default brightness and colors.
        // brightness: Brightness.dark,
        primaryColor: const Color.fromARGB(250, 46, 168, 137),

        // Define the default font family.
        // fontFamily: 'Georgia',

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline2: TextStyle(fontSize: 38.0, color: Colors.black),
          headline3: TextStyle(fontSize: 20.0, color: Color(0xff777777)),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText1: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
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

  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    Calendar(),
    Schedule(),
    Pomodoro(),
    Container(
      child: const Text("Fifth page"),
    ),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dux'),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Theme(
            data: Theme.of(context)
                .copyWith(canvasColor: const Color(0xfff0f0f0)),
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
                selectedItemColor: const Color(0xffff7648),
                onTap: _onItemTapped)));
  }
}
