import 'package:flutter/material.dart';
import 'package:reminders/util/user_prefs.dart';
import 'package:reminders/util/utilities.dart';

//Add Button Variables
var justAdded = '';
var newestId = -1;

//Notification Variables
var title = 'Reminder!!';
var test = UserPrefs.getString('key');


//Reminder One Variables
String? remOne = UserPrefs.getString('one').toString();
bool remOneUsed = UserPrefs.getString('oneUsed').toString() == 'true';
String? dayOneTime;
String? dayOfTheWeekOne;
Color? color1 = Colors.lightBlue;
double? opacity1 = 0.0;

//Reminder Two Variables
String? remTwo = '';
bool remTwoUsed = false;
String? dayTwoTime;
String? dayOfTheWeekTwo;
Color? color2 = Colors.lightBlue;
double? opacity2 = 1.0;

//Reminder Three Variables
String? remThree = '';
bool remThreeUsed = false;
String? dayThreeTime;
Color? color3 = Colors.lightBlue;
String? dayOfTheWeekThree;

//Reminder Four Variables
String? remFour = '';
bool remFourUsed = false;
String? dayFourTime;
Color? color4 = Colors.lightBlue;
String? dayOfTheWeekFour;

//Reminder Five Variables
String? remFive = '';
bool remFiveUsed = false;
String? dayFiveTime;
Color? color5 = Colors.lightBlue;
String? dayOfTheWeekFive;
