import 'package:flutter/material.dart';
import 'package:reminders/util/globalvars.dart';
import 'package:reminders/util/notification_service.dart';
import 'package:reminders/util/user_prefs.dart';
import 'package:reminders/main.dart';

TextEditingController _remdController = TextEditingController();

var dateToRemind;

int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}

dayOfWeek(NotificationWeekAndTime? n) {
  var day = n?.dayOfTheWeek;
  List<String> weekdays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  if (day == 1) return weekdays[0];
  if (day == 2) return weekdays[1];
  if (day == 3) return weekdays[2];
  if (day == 4) return weekdays[3];
  if (day == 5) return weekdays[4];
  if (day == 6) return weekdays[5];
  return weekdays[6];
}

Future<String?> setReminder(BuildContext context) async {
  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Text('Set Reminder', textAlign: TextAlign.center),
            content: Wrap(
              alignment: WrapAlignment.center,
              children: [
                TextFormField(controller: _remdController),
                ElevatedButton.icon(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue)),
                    onPressed: () async {
                      justAdded = _remdController.text;
                      NotificationWeekAndTime? pickedSchedule =
                          await pickSchedule(context);

                      if (pickedSchedule != null) {
                        if (!remOneUsed) {
                          await UserPrefs.setString(
                              'timeOne',
                              pickedSchedule.timeOfDay
                                  .toString()
                                  .substring(10, 15));
                          dayOneTime = pickedSchedule.timeOfDay
                              .toString()
                              .substring(10, 15);

                          await UserPrefs.setString(
                              'dayOne', dayOfWeek(pickedSchedule));
                          dayOfTheWeekOne = dayOfWeek(pickedSchedule);

                          await UserPrefs.setString('c1', 'lB');
                          
                        } else if (!remTwoUsed) {
                          await UserPrefs.setString('c2', 'lB');
                          await UserPrefs.setString(
                              'timeTwo',
                              pickedSchedule.timeOfDay
                                  .toString()
                                  .substring(10, 15));
                          dayTwoTime = pickedSchedule.timeOfDay
                              .toString()
                              .substring(10, 15);

                          await UserPrefs.setString(
                              'dayTwo', dayOfWeek(pickedSchedule));
                          dayOfTheWeekTwo = dayOfWeek(pickedSchedule);
                        } else if (!remThreeUsed) {
                          await UserPrefs.setString('c3', 'lB');
                          await UserPrefs.setString(
                              'timeThree',
                              pickedSchedule.timeOfDay
                                  .toString()
                                  .substring(10, 15));
                          dayThreeTime = pickedSchedule.timeOfDay
                              .toString()
                              .substring(10, 15);

                          await UserPrefs.setString(
                              'dayThree', dayOfWeek(pickedSchedule));
                          dayOfTheWeekThree = dayOfWeek(pickedSchedule);
                        } else if (!remFourUsed) {
                          await UserPrefs.setString(
                              'timeFour',
                              pickedSchedule.timeOfDay
                                  .toString()
                                  .substring(10, 15));
                          dayFourTime = pickedSchedule.timeOfDay
                              .toString()
                              .substring(10, 15);

                          await UserPrefs.setString(
                              'dayFour', dayOfWeek(pickedSchedule));
                          dayOfTheWeekFour = dayOfWeek(pickedSchedule);
                        } else if (!remFiveUsed) {
                          await UserPrefs.setString(
                              'timeFive',
                              pickedSchedule.timeOfDay
                                  .toString()
                                  .substring(10, 15));
                          dayFiveTime = pickedSchedule.timeOfDay
                              .toString()
                              .substring(10, 15);

                          await UserPrefs.setString(
                              'dayFive', dayOfWeek(pickedSchedule));
                          dayOfTheWeekFive = dayOfWeek(pickedSchedule);
                        }

                        scheduleNotification(
                            pickedSchedule, title, justAdded, getChannel());
                      }
                    },
                    icon: Icon(Icons.check),
                    label: Text('Remind Weekly')),
                ElevatedButton.icon(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue)),
                    onPressed: () async {
                      justAdded = _remdController.text;
                      DateTime? pickedSchedule = await pickDay(context);

                      if (pickedSchedule != null) {
                        scheduleOneNotif(pickedSchedule, title, justAdded);
                      }
                    },
                    icon: Icon(Icons.check),
                    label: Text('Remind Once')),
              ],
            ));
      });

  return null;
}

class NotificationWeekAndTime {
  final int dayOfTheWeek;
  final TimeOfDay timeOfDay;

  NotificationWeekAndTime({
    required this.dayOfTheWeek,
    required this.timeOfDay,
  });
}

Future<DateTime?> pickDay(BuildContext context) async {
  dateToRemind = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90000)));
}

Future<NotificationWeekAndTime?> pickSchedule(BuildContext context) async {
  List<String> weekdays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];
  TimeOfDay? timeOfDay;
  DateTime now = DateTime.now();
  int? selectedDay;

  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'I want to be reminded every:',
            textAlign: TextAlign.center,
          ),
          content: Wrap(
            alignment: WrapAlignment.center,
            spacing: 3,
            children: [
              for (int index = 0; index < weekdays.length; index++)
                ElevatedButton(
                  onPressed: () {
                    selectedDay = index + 1;
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.teal,
                    ),
                  ),
                  child: Text(weekdays[index]),
                ),
            ],
          ),
        );
      });

  if (selectedDay != null) {
    timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(
          now.add(
            Duration(minutes: 1),
          ),
        ),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData(
              colorScheme: ColorScheme.light(
                primary: Colors.teal,
              ),
            ),
            child: child!,
          );
        });

    if (timeOfDay != null) {
      return NotificationWeekAndTime(
          dayOfTheWeek: selectedDay!, timeOfDay: timeOfDay);
    }
  }
  return null;
}
