import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:reminders/util/utilities.dart';
import 'package:reminders/util/globalvars.dart';

Future<void> createNotificationNow(String title, String body) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'basic_channel',
      title: title,
      body: body,
      bigPicture: 'asset://android/app/src/main/res/drawable/app_icon.png',
      notificationLayout: NotificationLayout.BigPicture,
    ),
  );
}

Future<void> scheduleNotification(NotificationWeekAndTime notificationSchedule,
    String title, String body, String channel) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey:
          channel, //TODO: make method to get the newest available channel, make sure every reminder has its own channel.
      title: title,
      body: body,
      bigPicture: 'asset://android/app/src/main/res/drawable/app_icon.png',
      notificationLayout: NotificationLayout.Default,
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'MARK_DONE',
        label: 'Mark Done',
      ),
    ],
    schedule: NotificationCalendar(
      weekday: notificationSchedule.dayOfTheWeek,
      hour: notificationSchedule.timeOfDay.hour,
      minute: notificationSchedule.timeOfDay.minute,
      second: 0,
      millisecond: 0,
      repeats: true,
    ),
  );
}

Future<void> scheduleOneNotif(DateTime date, String title, String body) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey:
          getChannel(), //TODO: make method to get the newest available channel, make sure every reminder has its own channel.
      title: title,
      body: body,
      bigPicture: 'asset://android/app/src/main/res/drawable/app_icon.png',
      notificationLayout: NotificationLayout.Default,
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'MARK_DONE',
        label: 'Mark Done',
      ),
    ],
    schedule: NotificationCalendar.fromDate(date: date),
  );
}

Future<void> cancelScheduledNotifications() async {
  await AwesomeNotifications().cancelAll();
}

Future<void> cancelNotif(String channel) async {
  await AwesomeNotifications().cancelNotificationsByChannelKey(channel);
}

getChannel() {
  if (!remOneUsed) {
    return 'channel_one';
  } else if (!remTwoUsed) {
    return 'channel_two';
  } else if (!remThreeUsed) {
    return 'channel_three';
  } else if (!remFourUsed) {
    return 'channel_four';
  } else if (!remFiveUsed) {
    return 'channel_five';
  }

  return '';
}
