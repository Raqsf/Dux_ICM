import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../functions/future_functions.dart';
import '../../providers/steps_provider.dart';
import './description.dart';
import './email.dart';
import './image.dart';
import './name.dart';
import './phone.dart';
import './user.dart';
import './widget.dart';

// This class handles the Page to dispaly the user's info on the "Edit Profile" Screen
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    refreshOrGetData(context);

    if (_isLoading == true) {
      Future.wait([
        refreshOrGetData(context),
      ]).whenComplete(() {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = UserData.myUser;

    return Scaffold(
      body: ListView(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 10,
          ),
          SizedBox(height: 80.0),
          // Center(
          //     child: Padding(
          //         padding: EdgeInsets.only(bottom: 20),
          //         child: Text(
          //           'Edit Profile',
          //           style: TextStyle(
          //             fontSize: 30,
          //             fontWeight: FontWeight.w700,
          //             color: Color.fromRGBO(64, 105, 225, 1),
          //           ),
          //         ))),
          InkWell(
              onTap: () {
                navigateSecondPage(EditImagePage());
              },
              child: DisplayImage(
                imagePath: user.image,
                onPressed: () {},
              )),
          Text(
            '  Statistics',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          Consumer<StepsProvider>(
              builder: (context, stepsProvider, child) => stepsProvider
                      .items.isNotEmpty
                  ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Icon(Icons.directions_walk),
                      for (int i = 0; i < stepsProvider.items.length; i++)
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(children: [
                              Text(
                                  '${day(context.watch<StepsProvider>().items[i].day)}'),
                              Text(
                                  '${context.watch<StepsProvider>().items[i].steps}')
                            ]))
                    ])
                  : child!,
              child: const Text("")),
          buildUserInfoDisplay(user.name, '  Name', EditNameFormPage()),
          buildUserInfoDisplay(user.phone, '  Phone', EditPhoneFormPage()),
          buildUserInfoDisplay(user.email, '  Email', EditEmailFormPage()),
          Expanded(
            child: buildAbout(user),
            flex: 4,
          )
        ],
      ),
    );
  }

  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildUserInfoDisplay(String getValue, String title, Widget editPage) =>
      Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ))),
                  child: Row(children: [
                    Expanded(
                        child: TextButton(
                            onPressed: () {
                              navigateSecondPage(editPage);
                            },
                            child: Text(
                              getValue,
                              style: TextStyle(
                                  fontSize: 16,
                                  height: 1.4,
                                  color: Colors.black),
                            ))),
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.grey,
                      size: 40.0,
                    )
                  ]))
            ],
          ));

  // Widget builds the About Me Section
  Widget buildAbout(User user) => Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '  Tell Us About Yourself',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 1),
          Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Colors.grey,
                width: 1,
              ))),
              child: Row(children: [
                Expanded(
                    child: TextButton(
                        onPressed: () {
                          navigateSecondPage(EditDescriptionFormPage());
                        },
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  user.aboutMeDescription,
                                  style: TextStyle(
                                      fontSize: 16,
                                      height: 1.4,
                                      color: Colors.black),
                                ))))),
                Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                  size: 40.0,
                )
              ]))
        ],
      ));

  // Refrshes the Page after updating user info.
  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  // Handles navigation and prompts refresh.
  void navigateSecondPage(Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then(onGoBack);
  }

  String day(int day) {
    String d = "";
    switch (day) {
      case (0):
        d = "Mon";
        break;
      case (1):
        d = "Tue";
        break;
      case (2):
        d = "Wed";
        break;
      case (3):
        d = "Thu";
        break;
      case (4):
        d = "Fri";
        break;
      case (5):
        d = "Sat";
        break;
      case (6):
        d = "Sun";
        break;
    }
    return d;
  }
}
