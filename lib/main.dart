import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:analog_clock/analog_clock.dart';

void main() => runApp(MyApp());

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
            Column(
              children: <Widget>[
                test_time(),
                //timeal(),
              ],
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
      return Text(remaining.toString());
    },
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          OutlineButton(
            onPressed: () async {
              var time = await showTimePicker(
                  context: context, initialTime: TimeOfDay.now());

              var nowt = DateTime.now().hour;
              var t = DateTimeField.tryFormat(
                  DateTimeField.convert(time), DateFormat("HH"));
              var tnumb = nowt - int.parse(t);
              print(nowt);
              print(t);
              if (nowt >= int.parse(t)) {
                tnumb = nowt - int.parse(t) + 24;
              } else {
                tnumb = int.parse(t) - nowt;
              }
              print(tnumb);
              setState(() {
                show_time = DateTime.now();
                a = Countdown(
                  key: Key(Random().nextInt(1000).toString()),
                  duration: Duration(hours: tnumb),
                  builder: (BuildContext ctx, remaining) {
                    return Text(remaining.toString()); // 01:00:00
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

class timeal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnalogClock(
      decoration: BoxDecoration(
          border: Border.all(width: 2.0, color: Colors.black),
          color: Colors.transparent,
          shape: BoxShape.circle),
      width: 150.0,
      isLive: true,
      hourHandColor: Colors.black,
      minuteHandColor: Colors.black,
      showSecondHand: false,
      numberColor: Colors.black87,
      showNumbers: true,
      textScaleFactor: 1.4,
      showTicks: false,
      showDigitalClock: false,
      datetime: DateTime(2019, 1, 1, 9, 12, 15),
    );
  }
}
