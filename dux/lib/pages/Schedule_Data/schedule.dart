import 'dart:async';
import 'package:flutter/material.dart';
import 'updateValues/Monday/M8.dart';
import 'updateValues/Monday/M9.dart';
import 'updateValues/Monday/M10.dart';
import 'updateValues/Monday/M11.dart';
import 'updateValues/Monday/M12.dart';
import 'updateValues/Monday/M13.dart';
import 'updateValues/Monday/M14.dart';
import 'updateValues/Monday/M15.dart';
import 'updateValues/Monday/M16.dart';
import 'updateValues/Monday/M17.dart';
import 'updateValues/Monday/M18.dart';
import 'updateValues/Tuesday/T8.dart';
import 'updateValues/Tuesday/T9.dart';
import 'updateValues/Tuesday/T10.dart';
import 'updateValues/Tuesday/T11.dart';
import 'updateValues/Tuesday/T12.dart';
import 'updateValues/Tuesday/T13.dart';
import 'updateValues/Tuesday/T14.dart';
import 'updateValues/Tuesday/T15.dart';
import 'updateValues/Tuesday/T16.dart';
import 'updateValues/Tuesday/T17.dart';
import 'updateValues/Tuesday/T18.dart';
import 'updateValues/Wednesday/W8.dart';
import 'updateValues/Wednesday/W9.dart';
import 'updateValues/Wednesday/W10.dart';
import 'updateValues/Wednesday/W11.dart';
import 'updateValues/Wednesday/W12.dart';
import 'updateValues/Wednesday/W13.dart';
import 'updateValues/Wednesday/W14.dart';
import 'updateValues/Wednesday/W15.dart';
import 'updateValues/Wednesday/W16.dart';
import 'updateValues/Wednesday/W17.dart';
import 'updateValues/Wednesday/W18.dart';
import 'updateValues/Thursday/Q8.dart';
import 'updateValues/Thursday/Q9.dart';
import 'updateValues/Thursday/Q10.dart';
import 'updateValues/Thursday/Q11.dart';
import 'updateValues/Thursday/Q12.dart';
import 'updateValues/Thursday/Q13.dart';
import 'updateValues/Thursday/Q14.dart';
import 'updateValues/Thursday/Q15.dart';
import 'updateValues/Thursday/Q16.dart';
import 'updateValues/Thursday/Q17.dart';
import 'updateValues/Thursday/Q18.dart';
import 'updateValues/Friday/F8.dart';
import 'updateValues/Friday/F9.dart';
import 'updateValues/Friday/F10.dart';
import 'updateValues/Friday/F11.dart';
import 'updateValues/Friday/F12.dart';
import 'updateValues/Friday/F13.dart';
import 'updateValues/Friday/F14.dart';
import 'updateValues/Friday/F15.dart';
import 'updateValues/Friday/F16.dart';
import 'updateValues/Friday/F17.dart';
import 'updateValues/Friday/F18.dart';
import './subject.dart';
import './widget.dart';

import '../../functions/future_functions.dart';
import '../../providers/schedule_provider.dart';
import 'package:provider/provider.dart';

// This class handles the Page to dispaly the user's info on the "Edit Profile" Screen
class Schedule extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<Schedule> {
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
    final subject = SubjectData.mySubject;

    return Scaffold(
      body: Container(
          child: ListView(
        children: <Widget>[
          SizedBox(height: 40.0),
          RefreshIndicator(
              onRefresh: () => refreshOrGetData(context),
              child: Consumer<SchedulelProvider>(
                builder: (context, scheduleProvider, child) =>
                    scheduleProvider.items.isNotEmpty
                        ? buildUserInfoDisplay(
                            scheduleProvider.subject_M_9,
                            '  Monday 9:00h-10:00h',
                            EditMonday_9(),
                          )
                        : child!,
                child: buildUserInfoDisplay(subject.subject_M_9,
                    '  Monday 9:00h-10:00h', EditMonday_9()),

                //buildUserInfoDisplay(scheduleProvider.getItemByDayHours('Monday', '8:00 - 9:00'), '  Monday 8:00h-9:00h',EditMonday_8()),
                // buildUserInfoDisplay(
                //     subject.subject_M_9, '  Monday 9:00h-10:00h', EditMonday_9()),
                // buildUserInfoDisplay(
                //     subject.subject_M_10, '  Monday 10:00h-11:00h', EditMonday_10()),
                // buildUserInfoDisplay(
                //     subject.subject_M_11, '  Monday 11:00h-12:00h', EditMonday_11()),
                // buildUserInfoDisplay(
                //     subject.subject_M_12, '  Monday 12:00h-13:00h', EditMonday_12()),
                // buildUserInfoDisplay(
                //     subject.subject_M_13, '  Monday 13:00h-14:00h', EditMonday_13()),
                // buildUserInfoDisplay(
                //     subject.subject_M_14, '  Monday 14:00h-15:00h', EditMonday_14()),
                // buildUserInfoDisplay(
                //     subject.subject_M_15, '  Monday 15:00h-16:00h', EditMonday_15()),
                // buildUserInfoDisplay(
                //     subject.subject_M_16, '  Monday 16:00h-17:00h', EditMonday_16()),
                // buildUserInfoDisplay(
                //     subject.subject_M_17, '  Monday 17:00h-18:00h', EditMonday_17()),
                // buildUserInfoDisplay(
                //     subject.subject_M_18, '  Monday 18:00h-19:00h', EditMonday_18()),
                // buildUserInfoDisplay(
                //     subject.subject_T_8, '  Tuesday 8:00h-9:00h', EditTuesday_8()),
                // buildUserInfoDisplay(
                //     subject.subject_T_9, '  Tuesday 9:00h-10:00h', EditTuesday_9()),
                // buildUserInfoDisplay(subject.subject_T_10, '  Tuesday 10:00h-11:00h',
                //     EditTuesday_10()),
                // buildUserInfoDisplay(subject.subject_T_11, '  Tuesday 11:00h-12:00h',
                //     EditTuesday_11()),
                // buildUserInfoDisplay(subject.subject_T_12, '  Tuesday 12:00h-13:00h',
                //     EditTuesday_12()),
                // buildUserInfoDisplay(subject.subject_T_13, '  Tuesday 13:00h-14:00h',
                //     EditTuesday_13()),
                // buildUserInfoDisplay(subject.subject_T_14, '  Tuesday 14:00h-15:00h',
                //     EditTuesday_14()),
                // buildUserInfoDisplay(subject.subject_T_15, '  Tuesday 15:00h-16:00h',
                //     EditTuesday_15()),
                // buildUserInfoDisplay(subject.subject_T_16, '  Tuesday 16:00h-17:00h',
                //     EditTuesday_16()),
                // buildUserInfoDisplay(subject.subject_T_17, '  Tuesday 17:00h-18:00h',
                //     EditTuesday_17()),
                // buildUserInfoDisplay(subject.subject_T_18, '  Tuesday 18:00h-19:00h',
                //     EditTuesday_18()),
                // buildUserInfoDisplay(subject.subject_W_8, '  Wednesday 8:00h-9:00h',
                //     EditWednesday_8()),
                // buildUserInfoDisplay(subject.subject_W_9, '  Wednesday 9:00h-10:00h',
                //     EditWednesday_9()),
                // buildUserInfoDisplay(subject.subject_W_10,
                //     '  Wednesday 10:00h-11:00h', EditWednesday_10()),
                // buildUserInfoDisplay(subject.subject_W_11,
                //     '  Wednesday 11:00h-12:00h', EditWednesday_11()),
                // buildUserInfoDisplay(subject.subject_W_12,
                //     '  Wednesday 12:00h-13:00h', EditWednesday_12()),
                // buildUserInfoDisplay(subject.subject_W_13,
                //     '  Wednesday 13:00h-14:00h', EditWednesday_13()),
                // buildUserInfoDisplay(subject.subject_W_14,
                //     '  Wednesday 14:00h-15:00h', EditWednesday_14()),
                // buildUserInfoDisplay(subject.subject_W_15,
                //     '  Wednesday 15:00h-16:00h', EditWednesday_15()),
                // buildUserInfoDisplay(subject.subject_W_16,
                //     '  Wednesday 16:00h-17:00h', EditWednesday_16()),
                // buildUserInfoDisplay(subject.subject_W_17,
                //     '  Wednesday 17:00h-18:00h', EditWednesday_17()),
                // buildUserInfoDisplay(subject.subject_W_18,
                //     '  Wednesday 18:00h-19:00h', EditWednesday_18()),
                // buildUserInfoDisplay(
                //     subject.subject_Q_8, '  Thursday 8:00h-9:00h', EditThursday_8()),
                // buildUserInfoDisplay(
                //     subject.subject_Q_9, '  Thursday 9:00h-10:00h', EditThursday_9()),
                // buildUserInfoDisplay(subject.subject_Q_10, '  Thursday 10:00h-11:00h',
                //     EditThursday_10()),
                // buildUserInfoDisplay(subject.subject_Q_11, '  Thursday 11:00h-12:00h',
                //     EditThursday_11()),
                // buildUserInfoDisplay(subject.subject_Q_12, '  Thursday 12:00h-13:00h',
                //     EditThursday_12()),
                // buildUserInfoDisplay(subject.subject_Q_13, '  Thursday 13:00h-14:00h',
                //     EditThursday_13()),
                // buildUserInfoDisplay(subject.subject_Q_14, '  Thursday 14:00h-15:00h',
                //     EditThursday_14()),
                // buildUserInfoDisplay(subject.subject_Q_15, '  Thursday 15:00h-16:00h',
                //     EditThursday_15()),
                // buildUserInfoDisplay(subject.subject_Q_16, '  Thursday 16:00h-17:00h',
                //     EditThursday_16()),
                // buildUserInfoDisplay(subject.subject_Q_17, '  Thursday 17:00h-18:00h',
                //     EditThursday_17()),
                // buildUserInfoDisplay(subject.subject_Q_18, '  Thursday 18:00h-19:00h',
                //     EditThursday_18()),
                // buildUserInfoDisplay(
                //     subject.subject_F_8, '  Friday 8:00h-9:00h', EditFriday_8()),
                // buildUserInfoDisplay(
                //     subject.subject_F_9, '  Friday 9:00h-10:00h', EditFriday_9()),
                // buildUserInfoDisplay(
                //     subject.subject_F_10, '  Friday 10:00h-11:00h', EditFriday_10()),
                // buildUserInfoDisplay(
                //     subject.subject_F_11, '  Friday 11:00h-12:00h', EditFriday_11()),
                // buildUserInfoDisplay(
                //     subject.subject_F_12, '  Friday 12:00h-13:00h', EditFriday_12()),
                // buildUserInfoDisplay(
                //     subject.subject_F_13, '  Friday 13:00h-14:00h', EditFriday_13()),
                // buildUserInfoDisplay(
                //     subject.subject_F_14, '  Friday 14:00h-15:00h', EditFriday_14()),
                // buildUserInfoDisplay(
                //     subject.subject_F_15, '  Friday 15:00h-16:00h', EditFriday_15()),
                // buildUserInfoDisplay(
                //     subject.subject_F_16, '  Friday 16:00h-17:00h', EditFriday_16()),
                // buildUserInfoDisplay(
                //     subject.subject_F_17, '  Friday 17:00h-18:00h', EditFriday_17()),
                // buildUserInfoDisplay(
                //     subject.subject_F_18, '  Friday 18:00h-19:00h', EditFriday_18()),
              ))
        ],
      )),
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
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
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
                          ),
                          left: BorderSide(
                            color: Color.fromARGB(62, 158, 158, 158),
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
                                  fontSize: 16, height: 1.4, color: Colors.red),
                            ))),
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
}
