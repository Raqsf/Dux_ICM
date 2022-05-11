import 'package:flutter/material.dart';
import '../../subject.dart';
import '../../widget.dart';
import '../../../../models/schedule_model.dart';
import '../../../../providers/schedule_provider.dart';
import 'package:provider/provider.dart';

// This class handles the Page to edit the Name Section of the User Profile.
class EditTuesday_14 extends StatefulWidget {
  const EditTuesday_14({
    Key? key,
    this.schedule,
    this.defaultSchedule,
  }) : super(key: key);

  final ScheduleM? schedule;
  final String? defaultSchedule;

  @override
  EditTuesday_14_State createState() {
    return EditTuesday_14_State();
  }
}

class EditTuesday_14_State extends State<EditTuesday_14> {
  final _formKey = GlobalKey<FormState>();
  final subjectController = TextEditingController();
  var subject = SubjectData.mySubject;
  late String day;
  late String hours;
  late String subject_name;

  @override
  void dispose() {
    subjectController.dispose();
    super.dispose();
  }

  void updateUserValue(String name) {
    subject.subject_T_14 = name;
    subject_name = name;
  }

  @override
  Widget build(BuildContext context) {
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
                              _addLabelSchedule();
                              Navigator.pop(context);
                            }
                          },
                          child: const Text(
                            'Update',
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
      id: 17,
      subject: subject_name,
      day: 'Tuesday',
      hours: '14:00 - 15:00',
    );

    Provider.of<SchedulelProvider>(context, listen: false).add(schedule);
  }
}
