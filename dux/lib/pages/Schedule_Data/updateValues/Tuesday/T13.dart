import 'package:flutter/material.dart';
import '../../../../functions/future_functions.dart';
import '../../subject.dart';
import '../../widget.dart';
import '../../../../models/schedule_model.dart';
import '../../../../providers/schedule_provider.dart';
import 'package:provider/provider.dart';

// This class handles the Page to edit the Name Section of the User Profile.
class EditTuesday_13 extends StatefulWidget {
  const EditTuesday_13({
    Key? key,
    this.schedule,
    this.defaultSchedule,
  }) : super(key: key);

  final ScheduleM? schedule;
  final String? defaultSchedule;

  @override
  EditTuesday_13_State createState() {
    return EditTuesday_13_State();
  }
}

class EditTuesday_13_State extends State<EditTuesday_13> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController subjectController = TextEditingController();
  var subject = SubjectData.mySubject;
  late String day;
  late String hours;
  late String subject_name;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    refreshOrGetScheduleData(context);
  }

  /* @override
  void dispose() {
    subjectController.dispose();
    super.dispose();
  } */

  void updateUserValue(String name) {
    subject.subject_T_13 = name;
    subject_name = name;
  }

  @override
  Widget build(BuildContext context) {
    subjectController.text =
        Provider.of<SchedulelProvider>(context, listen: false).subject_T_13;
    return Scaffold(
        appBar: buildAppBar(context),
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 40, 16, 0),
                      child: SizedBox(
                          height: 100,
                          width: 150,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter subject name';
                              }
                              return null;
                            },
                            decoration:
                                InputDecoration(labelText: 'Subject Name'),
                            controller: subjectController,
                          ))),
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(top: 150),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: 330,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState!.validate()) {
                              updateUserValue(subjectController.text);
                              if (subjectController.text == "") {
                                _addLabelSchedule();
                              } else {
                                _updateLabelSchedule();
                              }
                              Navigator.pop(context);
                            }
                          },
                          child: const Text(
                            'Update',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ))),
              if (subjectController.text.isNotEmpty)
                Padding(
                    padding: EdgeInsets.only(top: 25),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: 330,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              // Validate returns true if the form is valid, or false otherwise.
                              //if (_formKey.currentState!.validate()) {
                              updateUserValue("");
                              _addLabelSchedule();
                              Navigator.pop(context);
                              //}
                            },
                            child: const Text(
                              'Delete',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        )))
            ],
          ),
        ));
  }

  _addLabelSchedule() {
    final schedule = ScheduleM(
      id: 16,
      subject: subject_name,
      day: 'Tuesday',
      hours: '13:00 - 14:00',
    );

    Provider.of<SchedulelProvider>(context, listen: false).add(schedule);
    refreshOrGetScheduleData(context);
  }

  _updateLabelSchedule() {
    final schedule = ScheduleM(
      id: 16,
      subject: subject_name,
      day: 'Tuesday',
      hours: '13:00 - 14:00',
    );

    Provider.of<SchedulelProvider>(context, listen: false).update(schedule);
  }
}
