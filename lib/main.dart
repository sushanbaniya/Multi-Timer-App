import 'dart:async';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const firstTime = 20;
  static const secondTime = 15;
  // var userTime1 = null;
  // var userTime2 = null;
  Timer? timer;
  Timer? timer2;

  int displayFirstTime = firstTime;
  int displaySecondTime = secondTime;

  var showingText1;
  var showingText2;

  final _form = GlobalKey<FormState>();

  void _saveForm() {
    _form.currentState!.save();
  }

  void _startTimer() {
    timer = Timer.periodic(
      Duration(seconds: 1),
      (_) {
        if (displayFirstTime > 0) {
          setState(
            () {
              displayFirstTime--;
            },
          );
        } else {
          // FlutterBeep.playSysSound(30);
          // FlutterBeep.playSysSound(AndroidSoundIDs.TONE_CDMA_ABBR_ALERT);
          AudioPlayer().play(AssetSource('audio/notification.wav'));
          _stopTimer1();
        }
      },
    );

    timer2 = Timer.periodic(Duration(seconds: 1), (_) {
      if (displaySecondTime > 0) {
        setState(() {
          displaySecondTime--;
        });
      } else {
        // FlutterBeep.playSysSound(30);
        // FlutterBeep.playSysSound(AndroidSoundIDs.TONE_CDMA_ABBR_ALERT);
        AudioPlayer().play(AssetSource('audio/notification.wav'));
        _stopTimer2();
      }
    });
    // if (displayFirstTime <= 0 || displaySecondTime <= 0) {
    //   FlutterBeep.beep();
    // }
  }

  void _stopTimer1() {
    timer!.cancel();
  }

  void _stopTimer2() {
    timer2!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Column(
            children: [
              Text('TIMER APP', style: TextStyle(letterSpacing: 8)),
              SizedBox(height: 18),
              Icon(Icons.punch_clock),
            ],
          ),
          toolbarHeight: 170,
          centerTitle: true,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(100)))),
      body: (displayFirstTime > 0 || displaySecondTime > 0)
          ? SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
          
                  (showingText1 == null || showingText2 == null) ? Text('Click on \'Enter Time\' Button to enter time. ') : Column(
                    children: [
                      Text('Timer of $showingText1 minute and $showingText2 minute has been set:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,),),
                      SizedBox(height: 10),
                      Text('*Converted into seconds below*', style: TextStyle(fontStyle: FontStyle.italic,),),
                    ],
                  ),
                  SizedBox(height: 170),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      (showingText1 == null ) ? Text('__', style: TextStyle(fontSize: 45)) :Text('$displayFirstTime s', style: TextStyle(fontSize: 45)),
                      SizedBox(width: 30),
                      (showingText2 == null ) ? Text('__',
                          style: TextStyle(fontSize: 45)) :Text('$displaySecondTime s',
                          style: TextStyle(fontSize: 45)),
                    ],
                  ),
                  SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: Text('Start Timer'),
                        onPressed: _startTimer,
                      ),
                      SizedBox(width: 18),
                      ElevatedButton(
                          child: Text('Stop Timer'),
                          onPressed: () {
                            _stopTimer1();
                            _stopTimer2();
                          })
                    ],
                  ),

                  SizedBox(height: 230),
                    Text('App Developed by SUSHAN BANIYA')


                  // ElevatedButton( child: Text("Beep Success"), onPressed: () {
                  //   AudioPlayer().play(AssetSource('audio/notification.wav'));
                  // }),






          
                  // ElevatedButton( child: Text("Beep somthing"), onPressed: ()=> FlutterBeep.playSysSound(30)),
          
                  // ElevatedButton(
                  //     child: Text("Beep Success"), onPressed: () => FlutterBeep.beep()),
                ],
              ),
          )
          : SingleChildScrollView(
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 100,),
                    Icon(Icons.check_circle, size: 100),
                    SizedBox(height: 40),
                    Center(
                      child: Text(
                        'TASK COMPLETED',
                        style: TextStyle(fontSize: 30, letterSpacing: 5),
                      ),
                    ),
                    SizedBox(height: 45),
                    ElevatedButton.icon(
                      label: Text('Restart'),
                      icon: Icon(Icons.restart_alt, size: 30),
                      onPressed: () {
                        setState(
                          () {
                            displayFirstTime = firstTime;
                            displaySecondTime = secondTime;
                          },
                        );
                      },
                    ),
                    SizedBox(height: 205),
                    Text('App Developed by SUSHAN BANIYA')
                  ],
                ),
            ),
          ),
      floatingActionButton: FloatingActionButton(
        child: Text('ENTER TIME', textAlign: TextAlign.center),
        onPressed: () {
          showModalBottomSheet<dynamic>(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Form(
                  key: _form,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        TextFormField(
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                    width: 2,
                                  ),
                                ),
                                labelText: 'Enter First Time (in minutes)'),
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            onSaved: (newValue) {
                              setState(() {
                                showingText1 = newValue.toString();
                                int intInput =  int.parse(newValue.toString());
                                int inputInSeconds = intInput * 60;
                                displayFirstTime = inputInSeconds;
                                    
                              });
                            }),
                        SizedBox(height: 18),
                        TextFormField(
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                    width: 2,
                                  ),
                                ),
                                labelText: 'Enter Second Time (in minutes)'),
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            onSaved: (newValue) {
                              setState(() {
                                showingText2 = newValue.toString();
                                int intInput =  int.parse(newValue.toString());
                                int inputInSeconds = intInput * 60;
                                displaySecondTime = inputInSeconds;
                              });
                            }),
                        SizedBox(height: 18),
                        ElevatedButton.icon(
                          icon: Icon(Icons.save),
                          label: Text('Submit Form'),
                          onPressed: () {
                            _saveForm();
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
