import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:dux/pages/Calendar_Data/event_editing_page.dart';

class Calendar extends StatelessWidget {
  final CalendarController _controller = CalendarController();
  Color? _headerColor, _viewHeaderColor, _calendarColor;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SfCalendar(
          view: CalendarView.month,
          firstDayOfWeek: 1,
          allowedViews: [
            CalendarView.day,
            CalendarView.week,
            CalendarView.workWeek,
            CalendarView.month,
            CalendarView.timelineDay,
            CalendarView.timelineWeek,
            CalendarView.timelineWorkWeek
          ],
          dataSource: MeetingDataSource(getAppointments()),
          initialDisplayDate: DateTime.now(),
          initialSelectedDate: DateTime.now(),
          todayHighlightColor: Colors.orange,
          showNavigationArrow: true,
          selectionDecoration: BoxDecoration(
            color: Colors.transparent,
            border:
                Border.all(color: Color.fromARGB(249, 229, 191, 76), width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            shape: BoxShape.rectangle,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: Color.fromARGB(249, 229, 191, 76),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => EventEditingPage()),
          ),
        ),
      ),
    );
  }
}

List<Appointment> getAppointments() {
  List<Appointment> meetings = <Appointment>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));

  meetings.add(Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: 'Exam',
      color: Colors.orange));

  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
