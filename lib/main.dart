import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';
import 'package:flutter/widgets.dart';
import 'package:time/time.dart';

void main() => runApp(MyApp());
var onoff = 0;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return maitest();
  }
}

class maitest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
    duration: Duration(hours: 0),
    builder: (BuildContext ctx, remaining) {
      return Text("距離睡眠時間");
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
                tnumb = nowt - all_time + (24 * 60);
              } else {
                tnumb = all_time - nowt;
              }

              print(tnumb);
              onoff = 1;
              setState(() {
                show_time = DateTime.now();
                a = Countdown(
                  key: Key(Random().nextInt(1000).toString()),
                  duration: Duration(minutes: tnumb - 10),
                  builder: (BuildContext ctx, remaining) {
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
    duration: Duration(hours: 0),
    builder: (BuildContext ctx, remaining) {
      return Text("距離起床時間");
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
                  tnumb = nowt - all_time + (24 * 60);
                } else {
                  tnumb = all_time - nowt;
                }

                setState(() {
                  show_time = DateTime.now();
                  a = Countdown(
                    key: Key(Random().nextInt(1000).toString()),
                    duration: Duration(minutes: tnumb),
                    builder: (BuildContext ctx, remaining) {
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
