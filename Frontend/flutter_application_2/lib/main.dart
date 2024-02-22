// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart'; 
import 'package:syncfusion_flutter_calendar/calendar.dart'; 
 
void main() { 
  runApp(const MyApp()); 
} 
 
class AppointmentData { 
  String subject; 
  DateTime startTime; 
  DateTime endTime; 
  Color color; 
 
  AppointmentData({ 
    required this.subject, 
    required this.startTime, 
    required this.endTime, 
    required this.color, 
  }); 
} 
 
class MyCalendarDataSource extends CalendarDataSource { 
  MyCalendarDataSource({List<Appointment>? appointments}) { 
    this.appointments = appointments ?? <Appointment>[]; 
  } 
} 
 
class MyApp extends StatelessWidget { 
  const MyApp({Key? key}); 
 
  @override 
  Widget build(BuildContext context) { 
    return MaterialApp( 
      home: Scaffold( 
        body: MyCalendar(), 
      ), 
    ); 
  } 
} 
 
class MyCalendar extends StatefulWidget { 
  const MyCalendar({Key? key}); 
 
  @override 
  _MyCalendarState createState() => _MyCalendarState(); 
} 
 
class _MyCalendarState extends State<MyCalendar> { 
  late MyCalendarDataSource _dataSource; 
 
  @override 
  void initState() { 
    _dataSource = MyCalendarDataSource(appointments: <Appointment>[]); 
    super.initState(); 
  } 
 
  void calendarTapped(CalendarTapDetails calendarTapDetails) { 
    DateTime selectedDate = calendarTapDetails.date!; 
    // You can customize the appointment properties based on your needs 
    Appointment newAppointment = Appointment( 
      startTime: selectedDate, 
      endTime: selectedDate.add(const Duration(hours: 1)), 
      subject: 'New Appointment', 
      color: Colors.greenAccent, 
    ); 


    // Add data to storage
    _dataSource.appointments!.add(newAppointment); 
    _dataSource.notifyListeners(CalendarDataSourceAction.add, <Appointment>[newAppointment]); 
    
    setState(() { 
      // Trigger a rebuild to reflect the changes 
    }); 
  } 



// First step create this function 

/**********************************************************************************
  Parse new appointment data from back-end 
  
  // valuetype parseAppointments()
  // {
  
  //     Parse data 
  //     method give susccesful result only when back-end gives appropriate data,
  //     if data is corrupted should throw error and skip this data
  //     should return list of <Appointment> 
      
  // }
  
**********************************************************************************/




// Second step
// retrieve this data by calling function written in the first step and add return data to the existing one 




  void handleAppointmentDoubleTap(Appointment appointment) { 
    showDialog( 
      context: context, 
      builder: (BuildContext context) { 
        TextEditingController subjectController = TextEditingController(text: appointment.subject); 
        TextEditingController startTimeController = 
            TextEditingController(text: _formatTime(appointment.startTime)); 
        TextEditingController endTimeController = 
            TextEditingController(text: _formatTime(appointment.endTime)); 
 
        return AlertDialog( 
          title: const Text('Edit Appointment'), 
          content: Column( 
            children: [ 
              TextField( 
                controller: subjectController, 
                onChanged: (String newText) { 
                  // Update the appointment subject as the user types 
                  appointment.subject = newText; 
                }, 
                decoration: InputDecoration(labelText: 'Subject'), 
              ), 
              TextField( 
                controller: startTimeController, 
                onTap: () async { 
                  // Show time picker for selecting start time 
                  TimeOfDay? pickedTime = await showTimePicker( 
                    context: context, 
                    initialTime: TimeOfDay.fromDateTime(appointment.startTime), 
                  ); 
 
                  if (pickedTime != null) { 
                    appointment.startTime = DateTime( 
                      appointment.startTime.year, 
                      appointment.startTime.month, 
                      appointment.startTime.day, 
                      pickedTime.hour, 
                      pickedTime.minute, 
                    ); 
 
                    startTimeController.text = _formatTime(appointment.startTime); 
                  } 
                }, 
                readOnly: true, 
                decoration: InputDecoration(labelText: 'Start Time'), 
              ), 
              TextField( 
                controller: endTimeController, 
                onTap: () async { 
                  // Show time picker for selecting end time 
                  TimeOfDay? pickedTime = await showTimePicker( 
                    context:
context, 
                    initialTime: TimeOfDay.fromDateTime(appointment.endTime), 
                  ); 
 
                  if (pickedTime != null) { 
                    appointment.endTime = DateTime( 
                      appointment.endTime.year, 
                      appointment.endTime.month, 
                      appointment.endTime.day, 
                      pickedTime.hour, 
                      pickedTime.minute, 
                    ); 
 
                    endTimeController.text = _formatTime(appointment.endTime); 
                  } 
                }, 
                readOnly: true, 
                decoration: InputDecoration(labelText: 'End Time'), 
              ), 
            ], 
          ), 
          actions: <Widget>[ 
            TextButton( 
              onPressed: () { 
                // Remove the existing appointment 
                _dataSource.notifyListeners(CalendarDataSourceAction.remove, <Appointment>[appointment]); 
 
                Navigator.of(context).pop(); 
              }, 
              child: const Text('Delete'), 
            ), 
            TextButton( 
              onPressed: () { 
                // Create a new appointment with updated details 
                Appointment updatedAppointment = Appointment( 
                  startTime: appointment.startTime, 
                  endTime: appointment.endTime, 
                  subject: appointment.subject, 
                  color: appointment.color, 
                ); 
 
                // Add the updated appointment 
                _dataSource.notifyListeners(CalendarDataSourceAction.add, <Appointment>[updatedAppointment]); 
 
                Navigator.of(context).pop(); 
              }, 
              child: const Text('Save'), 
            ), 
          ], 
        ); 
      }, 
    ); 
  } 

  String _formatTime(DateTime dateTime) { 
    return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}'; 
  } 
 
  @override 
  Widget build(BuildContext context) { 
    return SfCalendar( 
      view: CalendarView.month, 
      dataSource: _dataSource, 
      onTap: calendarTapped, 
      onLongPress: (CalendarLongPressDetails details) { 
        if (details.targetElement == CalendarElement.appointment) { 
          handleAppointmentDoubleTap(details.appointments!.first); 
        } 
      }, 
      monthViewSettings: const MonthViewSettings( 
        showAgenda: true, 
      ), 
    ); 
  } 
}
