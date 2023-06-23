// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:reminders/util/adhelper.dart';
import 'package:reminders/util/notification_service.dart';
import 'package:reminders/util/user_prefs.dart';
import 'package:reminders/util/utilities.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:reminders/util/globalvars.dart';
import 'dart:async';

var _height1 = 0.0;

//Color color = Colors.lightBlue;
Color bgdColor = Colors.white;

bool darkTheme = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(
    'resource://drawable/app_icon',
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        defaultColor: Colors.teal,
        importance: NotificationImportance.Max,
        channelShowBadge: true,
        channelDescription: 'CHANNEL',
      ),
      NotificationChannel(
        channelKey: 'scheduled_channel',
        channelName: 'Scheduled Notifications',
        defaultColor: Colors.teal,
        locked: true,
        importance: NotificationImportance.Max,
        channelDescription: 'CHANNEL',
      ),
      NotificationChannel(
        channelKey: 'channel_one',
        channelName: 'Scheduled Notifications',
        defaultColor: Colors.teal,
        locked: true,
        importance: NotificationImportance.Max,
        channelDescription: 'CHANNEL',
      ),
      NotificationChannel(
        channelKey: 'channel_two',
        channelName: 'Scheduled Notifications',
        defaultColor: Colors.teal,
        locked: true,
        importance: NotificationImportance.Max,
        channelDescription: 'CHANNEL',
      ),
      NotificationChannel(
        channelKey: 'channel_three',
        channelName: 'Scheduled Notifications',
        defaultColor: Colors.teal,
        locked: true,
        importance: NotificationImportance.Max,
        channelDescription: 'CHANNEL',
      ),
      NotificationChannel(
        channelKey: 'channel_four',
        channelName: 'Scheduled Notifications',
        defaultColor: Colors.teal,
        locked: true,
        importance: NotificationImportance.Max,
        channelDescription: 'CHANNEL',
      ),
      NotificationChannel(
        channelKey: 'channel_five',
        channelName: 'Scheduled Notifications',
        defaultColor: Colors.teal,
        locked: true,
        importance: NotificationImportance.Max,
        channelDescription: 'CHANNEL',
      ),
    ],
  );

  await UserPrefs.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reminders',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: const MyHomePage(title: 'Reminders'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<InitializationStatus> _initGoogleMobileAds() {
    return MobileAds.instance.initialize();
  }

  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    //_loadInterstitialAd();
    refreshStateInit();
    //initBannerAd();
  }

  InterstitialAd? _interstitialAd;

  bool _isInterstitialAdReady = false;

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              settingsPage();
            },
          );

          _isInterstitialAdReady = true;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
          _isInterstitialAdReady = false;
        },
      ),
    );
  }

  void initBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );

    _bannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: bgdColor),
            child: Column(
              children: [
                //bannerAd(),
                _selectedIndex != 0
                    ? settingsPage()
                    : redesignRem(remOneUsed, remOne, 'one', 'oneUsed',
                        dayOfTheWeekOne, dayOneTime, 'channel_one', color1),
                _selectedIndex != 0
                    ? Container()
                    : redesignRem(remTwoUsed, remTwo, 'two', 'twoUsed',
                        dayOfTheWeekTwo, dayTwoTime, 'channel_two', color2),
                _selectedIndex != 0
                    ? Container()
                    : redesignRem(
                        remThreeUsed,
                        remThree,
                        'three',
                        'threeUsed',
                        dayOfTheWeekThree,
                        dayThreeTime,
                        'channel_three',
                        color3),
                _selectedIndex != 0
                    ? Container()
                    : redesignRem(remFourUsed, remFour, 'four', 'fourUsed',
                        dayOfTheWeekFour, dayFourTime, 'channel_four', color4),
                _selectedIndex != 0
                    ? Container()
                    : redesignRem(remFiveUsed, remFive, 'five', 'fiveUsed',
                        dayOfTheWeekFive, dayFiveTime, 'channel_five', color5),
                SizedBox(
                  height: 700,
                  child: Container(
                    decoration: BoxDecoration(color: bgdColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        hoverColor: Colors.blue,
        onPressed: () async {
          await setReminder(context);
          refreshState();
          newReminderAdded();
        },
        tooltip: 'Add Reminder',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: darkTheme ? Colors.white : Colors.black,
        selectedItemColor: Colors.lightBlue,
        backgroundColor: bgdColor,
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: 'Reminders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  changeTheme() async {
    darkTheme = !darkTheme;
    if (darkTheme)
      await UserPrefs.setString('darkTheme', 'true');
    else if (!darkTheme) await UserPrefs.setString('darkTheme', 'false');

    refreshState();
  }

  Widget settingsPage() {
    //if (_isInterstitialAdReady) _interstitialAd?.show();
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: ElevatedButton.icon(
                  onPressed: () => changeTheme(),
                  icon: Icon(
                      darkTheme ? Icons.dark_mode_rounded : Icons.light_mode),
                  label: Text(darkTheme ? 'Dark Mode' : 'Light Mode')),
            ),
          ],
        )
      ],
    );
  }

  Widget bannerAd() {
    if (_isBannerAdReady) {
      return Padding(
          padding: EdgeInsets.only(bottom: 0),
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: _bannerAd.size.width.toDouble(),
              height: _bannerAd.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd),
            ),
          ));
    }
    return Container();
  }

  generateColor(NotificationWeekAndTime? n) {
    return Colors.lightBlue;
  }

  Widget redesignRem(
      bool used,
      String? rem,
      String remUserPref,
      String usedUserPref,
      String? dayOfTheWeek,
      String? timeOfDay,
      String notifChannel,
      Color? color) {
    return Padding(
      padding: EdgeInsets.only(top: 20, right: 20, left: 20),
      child: Column(
        children: <Widget>[
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Container(
                  decoration:
                      BoxDecoration(color: color, shape: BoxShape.circle),
                  child: Text('  '),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: Container(
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 250),
                    child: used
                        ? Text(dayOfTheWeek.toString(),
                            style: TextStyle(
                                color: darkTheme ? Colors.white : Colors.black))
                        : Text(
                            '',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Container(
                  decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 250),
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: used
                          ? AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              height: 100,
                              width: MediaQuery.of(context).size.width - 128,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 5, left: 5, right: 5),
                                          child: Text(
                                            used ? rem.toString() : ' ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      used
                                          ? IconButton(
                                              onPressed: () async {
                                                if (!used) {
                                                  NotificationWeekAndTime?
                                                      pickedSchedule =
                                                      await pickSchedule(
                                                          context);
                                                  if (pickedSchedule != null) {
                                                    scheduleNotification(
                                                        pickedSchedule,
                                                        title,
                                                        rem.toString(),
                                                        notifChannel);
                                                  }
                                                } else {
                                                  null;
                                                }
                                              },
                                              icon: Icon(Icons.add))
                                          : Container(),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(used ? timeOfDay.toString() : ''),
                                      Spacer(),
                                      used
                                          ? IconButton(
                                              onPressed: () async {
                                                colorFix(notifChannel);
                                                if (used) {
                                                  await UserPrefs.remove(
                                                      remUserPref);
                                                  await UserPrefs.setString(
                                                      usedUserPref, 'false');
                                                  await cancelNotif(
                                                      notifChannel);
                                                  _height1 = 0;
                                                  refreshState();
                                                }
                                              },
                                              icon: Icon(Icons.check))
                                          : Container(),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ); //));
  }

  newReminderAdded() async {
    if (!remOneUsed) {
      remOne = justAdded;
      colorFix('channel_one');
      await UserPrefs.setString('one', remOne.toString());
      await UserPrefs.setString('oneUsed', 'true');
      remOneUsed = true;
      justAdded = '';
    } else if (!remTwoUsed) {
      remTwo = justAdded;
      colorFix('channel_two');
      await UserPrefs.setString('two', remTwo.toString());
      await UserPrefs.setString('twoUsed', 'true');
      remTwoUsed = true;
      justAdded = '';
    } else if (!remThreeUsed) {
      remThree = justAdded;
      colorFix('channel_three');
      await UserPrefs.setString('three', remThree.toString());
      await UserPrefs.setString('threeUsed', 'true');
      remThreeUsed = true;
      justAdded = '';
    } else if (!remFourUsed) {
      remFour = justAdded;
      colorFix('channel_four');
      await UserPrefs.setString('four', remFour.toString());
      await UserPrefs.setString('fourUsed', 'true');
      remFourUsed = true;
      justAdded = '';
    } else if (!remFiveUsed) {
      remFive = justAdded;
      colorFix('channel_five');
      await UserPrefs.setString('five', remFive.toString());
      await UserPrefs.setString('fiveUsed', 'true');
      remFiveUsed = true;
      justAdded = '';
    }

    setState(() {
      remOneUsed = remOneUsed;
      remOne = remOne;

      remTwo = remTwo;
      remTwoUsed = remTwoUsed;

      remThree = remThree;
      remThreeUsed = remThreeUsed;

      remFour = remFour;
      remFourUsed = remFourUsed;

      remFive = remFive;
      remFiveUsed = remFiveUsed;
    });
  }

  refreshColor(bool used, String? rem) {
    color1 = !remOneUsed ? Colors.lightBlue : Colors.white;

    if (color1 == Colors.lightBlue) {
      setState(() {
        color1 = Colors.lightBlue;
      });
    } else if (color1 != Colors.lightBlue) {
      Future.delayed(const Duration(milliseconds: 250), () {
        setState(() {
          color1 = Colors.white;
        });
      });
    }

    color2 = !remTwoUsed ? Colors.lightBlue : Colors.white;

    if (color2 == Colors.lightBlue) {
      setState(() {
        color2 = Colors.lightBlue;
      });
    } else if (color2 != Colors.lightBlue) {
      Future.delayed(const Duration(milliseconds: 250), () {
        setState(() {
          color2 = Colors.white;
        });
      });
    }
  }

  refreshState() async {
    darkTheme = await UserPrefs.getString('darkTheme') == 'true';
    bgdColor = darkTheme ? Colors.black : Colors.white;

    remOneUsed = await UserPrefs.getString('oneUsed') == 'true';
    remOne = await UserPrefs.getString('one');
    dayOneTime = await UserPrefs.getString('timeOne');
    dayOfTheWeekOne = await UserPrefs.getString('dayOne');

    remTwoUsed = await UserPrefs.getString('twoUsed') == 'true';
    remTwo = await UserPrefs.getString('two');
    dayTwoTime = await UserPrefs.getString('timeTwo');
    dayOfTheWeekTwo = await UserPrefs.getString('dayTwo');

    remThreeUsed = await UserPrefs.getString('threeUsed') == 'true';
    remThree = await UserPrefs.getString('three');
    dayThreeTime = await UserPrefs.getString('timeThree');
    dayOfTheWeekThree = await UserPrefs.getString('dayThree');

    remFourUsed = await UserPrefs.getString('fourUsed') == 'true';
    remFour = await UserPrefs.getString('four');
    dayFourTime = await UserPrefs.getString('timeFour');
    dayOfTheWeekFour = await UserPrefs.getString('dayFour');

    remFiveUsed = await UserPrefs.getString('fiveUsed') == 'true';
    remFive = await UserPrefs.getString('five');
    dayFiveTime = await UserPrefs.getString('timeFive');
    dayOfTheWeekFive = await UserPrefs.getString('dayFive');

    setState(() {
      darkTheme = darkTheme;
      bgdColor = bgdColor;

      remOne = remOne;
      remOneUsed = remOneUsed;
      color1 = color1;
      opacity1 = opacity1;

      remTwo = remTwo;
      remTwoUsed = remTwoUsed;
      color2 = color2;

      remThree = remThree;
      remThreeUsed = remThreeUsed;

      remFour = remFour;
      remFourUsed = remFourUsed;

      remFive = remFive;
      remFiveUsed = remFiveUsed;
    });
  }

  refreshStateInit() async {
    darkTheme = await UserPrefs.getString('darkTheme') == 'true';
    bgdColor = darkTheme ? Colors.black : Colors.white;

    remOneUsed = await UserPrefs.getString('oneUsed') == 'true';
    remOne = await UserPrefs.getString('one');
    dayOneTime = await UserPrefs.getString('timeOne');
    dayOfTheWeekOne = await UserPrefs.getString('dayOne');

    remTwoUsed = await UserPrefs.getString('twoUsed') == 'true';
    remTwo = await UserPrefs.getString('two');
    dayTwoTime = await UserPrefs.getString('timeTwo');
    dayOfTheWeekTwo = await UserPrefs.getString('dayTwo');

    remThreeUsed = await UserPrefs.getString('threeUsed') == 'true';
    remThree = await UserPrefs.getString('three');
    dayThreeTime = await UserPrefs.getString('timeThree');
    dayOfTheWeekThree = await UserPrefs.getString('dayThree');

    remFourUsed = await UserPrefs.getString('fourUsed') == 'true';
    remFour = await UserPrefs.getString('four');
    dayFourTime = await UserPrefs.getString('timeFour');
    dayOfTheWeekFour = await UserPrefs.getString('dayFour');

    remFiveUsed = await UserPrefs.getString('fiveUsed') == 'true';
    remFive = await UserPrefs.getString('five');
    dayFiveTime = await UserPrefs.getString('timeFive');
    dayOfTheWeekFive = await UserPrefs.getString('dayFive');

    if (remOneUsed) {
      color1 = Colors.lightBlue;
    } else if (!remOneUsed) {
      color1 = bgdColor;
    }
    if (remTwoUsed) {
      color2 = Colors.lightBlue;
    } else if (!remTwoUsed) {
      color2 = bgdColor;
    }
    if (remThreeUsed) {
      color3 = Colors.lightBlue;
    } else if (!remThreeUsed) {
      color3 = bgdColor;
    }
    if (remFourUsed) {
      color4 = Colors.lightBlue;
    } else if (!remFourUsed) {
      color4 = bgdColor;
    }
    if (remFiveUsed) {
      color5 = Colors.lightBlue;
    } else if (!remFiveUsed) {
      color5 = bgdColor;
    }

    setState(() {
      darkTheme = darkTheme;
      bgdColor = bgdColor;

      remOne = remOne;
      remOneUsed = remOneUsed;
      color1 = color1;
      opacity1 = opacity1;

      remTwo = remTwo;
      remTwoUsed = remTwoUsed;
      color2 = color2;

      remThree = remThree;
      remThreeUsed = remThreeUsed;
      color3 = color3;

      remFour = remFour;
      remFourUsed = remFourUsed;
      color4 = color4;

      remFive = remFive;
      remFiveUsed = remFiveUsed;
      color5 = color5;
    });
  }

  colorFromString(String? c) {
    if (c != 'lB')
      return Colors.white;
    else if (c == 'lB') return Colors.lightBlue;
    return Colors.white;
  }

  colorFix(String channel) async {
    if (channel.toString() == 'channel_one') {
      !remOneUsed
          ? setState(() {
              color1 = Colors.lightBlue;
            })
          : Timer(Duration(milliseconds: 249), () {
              setState(() {
                color1 = bgdColor;
              });
            });
    } else if (channel.toString() == 'channel_two') {
      !remTwoUsed
          ? setState(() {
              color2 = Colors.lightBlue;
            })
          : Timer(Duration(milliseconds: 249), () {
              setState(() {
                color2 = bgdColor;
              });
            });
    } else if (channel.toString() == 'channel_three') {
      !remThreeUsed
          ? setState(() {
              color3 = Colors.lightBlue;
            })
          : Timer(Duration(milliseconds: 249), () {
              setState(() {
                color3 = bgdColor;
              });
            });
    } else if (channel.toString() == 'channel_four') {
      !remFourUsed
          ? setState(() {
              color4 = Colors.lightBlue;
            })
          : Timer(Duration(milliseconds: 249), () {
              setState(() {
                color4 = bgdColor;
              });
            });
    } else if (channel.toString() == 'channel_five') {
      !remFiveUsed
          ? setState(() {
              color5 = Colors.lightBlue;
            })
          : Timer(Duration(milliseconds: 249), () {
              setState(() {
                color5 = bgdColor;
              });
            });
    }
  }
}
