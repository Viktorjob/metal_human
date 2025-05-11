import 'package:flutter/material.dart';
import 'package:metal_human/calendar_of_working_days/calendar.dart';
import 'package:metal_human/calendar_of_working_days/list_calendar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

/// The app which hosts the home page which contains the calendar on it.
class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Calendar Demo', home: MyHomePage());
  }
}

/// The home page which hosts the calendar
class MyHomePage extends StatefulWidget {
  /// Creates the home page to display the calendar widget.
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final Map<DateTime, Color?> _dateColors = {};


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 500,
            child: SfCalendar(
              key: ValueKey(_dateColors.hashCode),
              view: CalendarView.month,
              dataSource: MeetingDataSource(_getDataSource()),
              onTap: _onCalendarTapped,
              headerHeight: 50,
              viewHeaderHeight: 50,
              monthViewSettings: const MonthViewSettings(
                appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
              ),
            ),

          ),
          Expanded(child: _buildStatusIndicator()),
        ],
      ),
    );
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = [];

    _dateColors.forEach((date, color) {
      if (color != null) {

        meetings.add(Meeting('Workout', date, date, color, true));

      }
    });

    return meetings;
  }


  void _onCalendarTapped(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.calendarCell && details.date != null) {
      setState(() {
        final date = DateTime(details.date!.year, details.date!.month, details.date!.day);
        _dateColors[date] = _nextColor(_dateColors[date]);
      });
    }
  }

  Color? _nextColor(Color? currentColor) {
    if (currentColor == null) return Colors.red;
    if (currentColor == Colors.red) return Colors.yellow;
    if (currentColor == Colors.yellow) return Colors.green;
    if (currentColor == Colors.green) return null;
    return Colors.red;
  }

  Widget _buildStatusIndicator() {
    return Center(
      child: BodyPartLegend(),
    );
  }
}


/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }
    return meetingData;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}
