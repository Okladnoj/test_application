import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color _colorbackground;
  Color _colortext;

  void _cangeColor() {
    final _intrand = Random();
    final _maxint = 255;
    final _a = _maxint;
    final _r = _intrand.nextInt(_maxint);
    final _g = _intrand.nextInt(_maxint);
    final _b = _intrand.nextInt(_maxint);
    _colorbackground = Color.fromARGB(_a, _r, _g, _b);
    _colortext = Color.fromARGB(_a, _maxint - _r, _maxint - _g, _maxint - _b);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
        body: Center(
      child: InkWell(
        child: Container(
          color: _colorbackground,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Hey there',
                style: TextStyle(
                    color: _colortext,
                    fontSize: 33,
                    fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ),
        onTap: () {
          setState(() {
            _cangeColor();
          });
        },
      ),
    ));
  }
}
