import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';
import 'package:flutter/widgets.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(MyApp());
var onoff = 0;
var wallup = 0;
var sellp = 0;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "WTF",
      home: home_page_de(),
    );
  }
}

class home_page_de extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlineButton(
                  child: Text("睡眠"),
                  color: Colors.deepOrange[200],
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => maitest()),
                    );
                  },
                ),
                OutlineButton(
                  color: Colors.deepOrange[200],
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => gankenn()),
                    );
                  },
                  child: Text("健康"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class gankenn extends StatefulWidget {
  @override
  _gankennState createState() => _gankennState();
}

class _gankennState extends State<gankenn> {
  var gans_time = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("運動"),
          leading: IconButton(
            icon: Icon(Icons.keyboard_return),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.deepOrange[200],
        ),
        body: Container(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("今天運動了${gans_time}分鐘"),
                TextField(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class maitest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("睡眠"),
          leading: IconButton(
            icon: Icon(Icons.keyboard_return),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.deepOrange[200],
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlutterAnalogClock(
                    height: 250,
                    width: 250,
                  ),
                  test_time(),
                  test_time2(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class test_time extends StatefulWidget {
  @override
  _test_timeState createState() => _test_timeState();
}

class _test_timeState extends State<test_time> {
  DateTime show_time;
  var a = Countdown(
    interval: Duration(seconds: 1),
    duration: Duration(
      seconds: sellp,
    ),
    builder: (BuildContext ctx, remaining) {
      if (sellp == 0) {
        return Text("距離睡眠時間");
      } else {
        const period = const Duration(seconds: 1);
        Timer.periodic(period, (timer) {
          //到时回调
          sellp--;
          if (sellp >= 0) {
            //取消定时器，避免无限回调
            timer.cancel();
            timer = null;
          }
        });
        return Text(
            "距離睡眠還有${remaining.inHours}小時:${remaining.inMinutes % 60}分鐘:${remaining.inSeconds % 60}秒"); // 01:00:00)
      }
    },
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          OutlineButton(
            child: Text("睡眠時間"),
            onPressed: () async {
              var time = await showTimePicker(
                  context: context, initialTime: TimeOfDay.now());

              var nowt = DateTime.now().hour * 60;
              nowt += DateTime.now().minute;

              var t = DateTimeField.tryFormat(
                  DateTimeField.convert(time), DateFormat("HH"));
              var all_time = int.parse(t) * 60;
              t = DateTimeField.tryFormat(
                  DateTimeField.convert(time), DateFormat("mm"));
              all_time += int.parse(t);
              var tnumb = nowt - int.parse(t);
              print(nowt);
              print(all_time);
              if (nowt >= all_time) {
                tnumb = nowt - all_time;
                if (tnumb <= (12 * 60)) tnumb += (12 * 60);
              } else {
                tnumb = all_time - nowt;
              }
              sellp = (tnumb - 10) * 60;
              print(tnumb);
              onoff = 1;
              setState(() {
                show_time = DateTime.now();
                a = Countdown(
                  key: Key(Random().nextInt(1000).toString()),
                  duration: Duration(minutes: tnumb - 10),
                  builder: (BuildContext ctx, remaining) {
                    const period = const Duration(seconds: 1);
                    Timer.periodic(period, (timer) {
                      //到时回调
                      sellp--;
                      if (sellp >= 0) {
                        //取消定时器，避免无限回调
                        timer.cancel();
                        timer = null;
                      }
                    });
                    return Text(
                        "距離睡眠還有${remaining.inHours}小時:${remaining.inMinutes % 60}分鐘:${remaining.inSeconds % 60}秒"); // 01:00:00
                  },
                  onFinish: () {},
                );
              });
            },
          ),
          a,
        ],
      ),
    );
  }
}

class test_time2 extends StatefulWidget {
  @override
  _test_time2State createState() => _test_time2State();
}

class _test_time2State extends State<test_time2> {
  DateTime show_time;
  var a = Countdown(
    interval: Duration(seconds: 1),
    duration: Duration(
      seconds: wallup,
    ),
    builder: (BuildContext ctx, remaining) {
      if (wallup == 0) {
        return Text("距離睡眠時間");
      } else {
        const period = const Duration(seconds: 1);
        Timer.periodic(period, (timer) {
          //到时回调
          wallup--;
          if (wallup >= 0) {
            //取消定时器，避免无限回调
            timer.cancel();
            timer = null;
          }
        });
        return Text(
            "距離起床還有${remaining.inHours}小時:${remaining.inMinutes % 60}分鐘:${remaining.inSeconds % 60}秒"); // 01:00:00)
      }
    },
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          OutlineButton(
            child: Text("起床時間"),
            onPressed: () async {
              if (onoff == 1) {
                var time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay(hour: 8, minute: 0));
                var nowt = DateTime.now().hour * 60;
                nowt += DateTime.now().minute;

                var t = DateTimeField.tryFormat(
                    DateTimeField.convert(time), DateFormat("HH"));
                var all_time = int.parse(t) * 60;
                t = DateTimeField.tryFormat(
                    DateTimeField.convert(time), DateFormat("mm"));
                all_time += int.parse(t);
                var tnumb = nowt - int.parse(t);
                print(nowt);
                print(all_time);
                if (nowt >= all_time) {
                  tnumb = nowt - all_time;
                  if (tnumb <= (12 * 60)) tnumb += (12 * 60);
                } else {
                  tnumb = all_time - nowt;
                }
                //tnumb = tnumb % (24 * 60);
                wallup = tnumb * 60;
                setState(() {
                  show_time = DateTime.now();
                  a = Countdown(
                    key: Key(Random().nextInt(1000).toString()),
                    duration: Duration(minutes: tnumb),
                    builder: (BuildContext ctx, remaining) {
                      const period = const Duration(seconds: 1);
                      Timer.periodic(period, (timer) {
                        //到时回调
                        wallup--;
                        if (wallup >= 0) {
                          //取消定时器，避免无限回调
                          timer.cancel();
                          timer = null;
                        }
                      });

                      return Text(
                          "距離起床還有${remaining.inHours}小時:${remaining.inMinutes % 60}分鐘:${remaining.inSeconds % 60}秒"); // 01:00:00
                    },
                    onFinish: () {},
                  );
                });
              } else {
                showAlert1(context);
              }
            },
          ),
          a,
        ],
      ),
    );
  }
}

Future<void> showAlert1(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('錯誤'),
        content: const Text('請先輸入睡眠'),
        actions: <Widget>[
          FlatButton(
            child: Text('好 !'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
