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

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int _tapcount = 0;
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
    _tapcount++;
  }

  AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 777),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                RotationTransition(
                  turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                  child: Text(
                    'Hey there',
                    style: TextStyle(
                        color: _colortext,
                        fontSize: 33,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            setState(
              () {
                _cangeColor();
                _tapcount % 2 == 0 ? _controller.repeat() : _controller.stop();
              },
            );
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(3.0),
            child: FloatingActionButton.extended(
              onPressed: () {},
              heroTag: 'counter',
              tooltip: 'Show number of tap',
              icon: Icon(Icons.touch_app),
              label: Text(
                '$_tapcount',
                style: TextStyle(
                    color: _colorbackground,
                    fontSize: 40,
                    fontWeight: FontWeight.w800),
              ),
              backgroundColor: _colortext,
            ),
          ),
          Container(
            padding: EdgeInsets.all(3.0),
            child: FloatingActionButton.extended(
              onPressed: () => setState(() {
                _tapcount = 0;
                _controller.reset();
              }),
              heroTag: 'reset',
              tooltip: 'Reset tap progres',
              icon: Icon(Icons.settings_backup_restore),
              label: Text('RESET'),
              backgroundColor: Colors.lime[900],
            ),
          ),
        ],
      ),
    );
  }
}
