import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart';
//3.2.1
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/main.dart';
import '../utilities/alert.dart';
import '../models/local_user.dart';

class AccSettings extends StatefulWidget {
  final MainModel model;
  final LocalUser localUser;
  final bool firstRun;

  AccSettings(this.model, this.localUser, this.firstRun);
  @override
  _AccSeetingsState createState() => new _AccSeetingsState();
}
//3.2.2
class _AccSeetingsState extends State<AccSettings>
    with TickerProviderStateMixin {
  bool man = false;
  bool woman = false;
  bool other = false;
  double lowerVal = 18;
  double upperVal = 100;
  List<RangeSliderData> rangeSliders;
//3.2.2.1

  Map<String, dynamic> prefs = {
    'MinimumAge': 18,
    'MaximumAge': 100,
    'Gender': 1
  };

  @override
  void initState() {
    super.initState();
    rangeSliders = _rangeSliderDefinitions();
/*     if (widget.localUser.prefs != null) {
      lowerVal = widget.localUser.prefs[0].roundToDouble();
      upperVal = widget.localUser.prefs[1].roundToDouble();
      if (widget.localUser.prefs[2] == 0) {
        man = true;
        woman = false;
        other = false;
      } else if (widget.localUser.prefs[2] == 2) {
        man = false;
        woman = false;
        other = true;
      } else {
        man = false;
        woman = true;
        other = false;
      } */
    //}
  }
//3.2.2.2
  List<Widget> _buildRangeSliders() {
    List<Widget> children = <Widget>[];
    for (int index = 0; index < rangeSliders.length; index++) {
      children
          .add(rangeSliders[index].build(context, (double lower, double upper) {
        setState(() {
          lowerVal = lower;
          upperVal = upper;
          rangeSliders[index].lowerValue = lower;
          rangeSliders[index].upperValue = upper;
        });
      }));

      children.add(new SizedBox(height: 8.0));
    }

    return children;
  }
//3.2.2.3
  List<RangeSliderData> _rangeSliderDefinitions() {
    return <RangeSliderData>[
      RangeSliderData(
          min: 18.0,
          max: 100.0,
          lowerValue: 18.0,
          upperValue: 100.0,
          thumbColor: Colors.grey,
          activeTrackColor: Color.fromRGBO(220, 28, 29, 1),
          inactiveTrackColor: Colors.grey,
          valueIndicatorColor: Color.fromRGBO(220, 28, 29, 1)),
    ];
  }
//3.2.2.4

  Widget confirm() {
    return AlertDialog(
        title: Text('Slet konto'),
        content: Text('Er du sikker på at du vil slette din konto?'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.cancel),
            color: Colors.red,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          IconButton(
            icon: Icon(Icons.check_circle),
            color: Colors.green,
            onPressed: () async {
              Navigator.of(context).pop();
              Map<String, dynamic> text = await widget.model.deleteUser();
              if (text['success']) {
                widget.model.logout();
              }
            },
          )
        ]);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return new Scaffold(
        appBar: new AppBar(
          elevation: 1.0,
          brightness: Brightness.dark,
          backgroundColor: Theme.of(context).backgroundColor,
          title: new Text(
            "Indstillinger",
            textAlign: TextAlign.center,
            style: new TextStyle(
                color: new Color.fromRGBO(220, 28, 39, 1), fontSize: 32.0),
          ),
          automaticallyImplyLeading: false,
          leading: new IconButton(
              icon: new Icon(
                Icons.arrow_back,
                color: new Color.fromRGBO(220, 28, 39, 1),
              ),
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, '/loggedIn')),
        ),
        body: new SingleChildScrollView(
          padding: new EdgeInsets.all(12.5),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Card(
                  elevation: 6.0,
                  child: new Container(
                    width: screenSize.width,
                    padding: new EdgeInsets.only(top: 12.0, bottom: 12.0),
                    child: new Column(
                      children: <Widget>[
                        new Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Text(
                            "Ønsker at se",
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                                color: new Color.fromRGBO(220, 28, 39, 1),
                                fontSize: 32.0),
                          ),
                        ),
                        new ListTile(
                            title: new Text(
                              "Mænd",
                              style: new TextStyle(
                                  color: new Color.fromRGBO(220, 28, 29, 1)),
                            ),
                            trailing: new Switch(
                              value: man,
                              onChanged: (bool newValue) {
                                setState(() {
                                  man = newValue;
                                  if (newValue) {
                                    woman = false;
                                    other = false;
                                  }
                                });
                              },
                              activeColor: Colors.red,
                              activeTrackColor: Colors.red,
                            )),
                        new ListTile(
                            title: new Text(
                              "Kvinder",
                              style: new TextStyle(
                                  color: new Color.fromRGBO(220, 28, 29, 1)),
                            ),
                            trailing: new Switch(
                              value: woman,
                              onChanged: (bool newValue) {
                                setState(() {
                                  woman = newValue;
                                  if (newValue) {
                                    man = false;
                                    other = false;
                                  }
                                });
                              },
                              activeColor: Colors.red,
                              activeTrackColor: Colors.red,
                            )),
                        new ListTile(
                          title: new Text(
                            "Andet",
                            style: new TextStyle(
                                color: new Color.fromRGBO(220, 28, 29, 1)),
                          ),
                          trailing: new Switch(
                            value: other,
                            onChanged: (bool newValue) {
                              setState(() {
                                other = newValue;
                                if (newValue) {
                                  woman = false;
                                  man = false;
                                }
                              });
                            },
                            activeColor: Colors.red,
                            activeTrackColor: Colors.red,
                          ),
                        )
                      ],
                    ),
                  )),
              new Column(children: <Widget>[]..addAll(_buildRangeSliders())),
              ScopedModelDescendant(
                builder: (BuildContext context, Widget child, MainModel model) {
                  return RaisedButton(
                    child: new Container(
                      width: screenSize.width,
                      padding: new EdgeInsets.only(top: 5.0, bottom: 5.0),
                      height: 40.0,
                      child: new Center(
                        child: Text(
                          'Gem',
                          style: TextStyle(
                              fontSize: 28,
                              color: Color.fromRGBO(220, 28, 39, 1)),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      int gender = 1;
                      if (man) {
                        gender = 0;
                      } else if (other) {
                        gender = 2;
                      }
                      if (!man && !woman && !other) {
                        if (widget.localUser.gender == 0) {
                          gender = 1;
                        } else if (widget.localUser.gender == 1) {
                          gender = 0;
                        } else {
                          gender = 2;
                        }
                      }
                      prefs['MinimumAge'] = lowerVal.round();
                      prefs['MaximumAge'] = upperVal.round();
                      prefs['Gender'] = gender;
                      model.user.prefs = [
                        lowerVal.round(),
                        upperVal.round(),
                        gender
                      ];
                      print(prefs);
                      final Map<String, dynamic> responseInfo =
                          await model.setupUserPreferences(prefs);
                      widget.firstRun ? Navigator.pushReplacementNamed(context, '/loggedIn')
                      : showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertText(responseInfo['title'].toString(),
                                responseInfo['message'].toString());
                          });
                    },
                  );
                },
              ),
              widget.firstRun ? Container() :
              ScopedModelDescendant(
                builder: (BuildContext context, Widget child, MainModel model) {
                  return RaisedButton(
                    child: new Container(
                      width: screenSize.width,
                      padding: new EdgeInsets.only(top: 5.0, bottom: 5.0),
                      height: 40.0,
                      child: new Center(
                        child: Text(
                          'Log ud',
                          style: TextStyle(
                              fontSize: 28,
                              color: Color.fromRGBO(220, 28, 39, 1)),
                        ),
                      ),
                    ),
                    onPressed: () {
                      model.logout();
                    },
                  );
                },
              ),
              RaisedButton(
                child: new Container(
                  width: screenSize.width,
                  padding: new EdgeInsets.only(top: 5.0, bottom: 5.0),
                  height: 40.0,
                  child: new Center(
                    child: Text(
                      'Slet konto',
                      style: TextStyle(
                          fontSize: 28, color: Color.fromRGBO(220, 28, 39, 1)),
                    ),
                  ),
                ),
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => confirm());
                },
              )
            ],
          ),
        ));
  }
}
//3.2.3
class RangeSliderData {
  double min;
  double max;
  double lowerValue;
  double upperValue;
  int divisions;
  bool showValueIndicator;
  int valueIndicatorMaxDecimals;
  bool forceValueIndicator;
  Color overlayColor;
  Color activeTrackColor;
  Color inactiveTrackColor;
  Color thumbColor;
  Color valueIndicatorColor;
  Color activeTickMarkColor;

  static const Color defaultActiveTrackColor = null;
  static const Color defaultInactiveTrackColor = null;
  static const Color defaultActiveTickMarkColor = null;
  static const Color defaultThumbColor = null;
  static const Color defaultValueIndicatorColor = null;
  static const Color defaultOverlayColor = null;
//3.2.3.1
  RangeSliderData({
    this.min,
    this.max,
    this.lowerValue,
    this.upperValue,
    this.divisions,
    this.showValueIndicator: true,
    this.valueIndicatorMaxDecimals: 0,
    this.forceValueIndicator: false,
    this.overlayColor: null,
    this.activeTrackColor: null,
    this.inactiveTrackColor: null,
    this.thumbColor: null,
    this.valueIndicatorColor: null,
    this.activeTickMarkColor: null,
  });

  String get lowerValueText =>
      lowerValue.round().toStringAsFixed(valueIndicatorMaxDecimals);

  String get upperValueText =>
      upperValue.round().toStringAsFixed(valueIndicatorMaxDecimals);
//3.2.3.2
  Widget build(BuildContext context, RangeSliderCallback callback) {
    Size screenSize = MediaQuery.of(context).size;
    return new Card(
        elevation: 6.0,
        child: new Container(
            width: screenSize.width,
            padding: new EdgeInsets.only(top: 12.0, bottom: 12.0),
            child: new Column(children: <Widget>[
              new ListTile(
                title: new Text(
                  "Alder",
                  style:
                      new TextStyle(color: new Color.fromRGBO(220, 28, 29, 1)),
                ),
                trailing: new Text(
                  (lowerValueText) + "-" + (upperValueText),
                  style:
                      new TextStyle(color: new Color.fromRGBO(220, 28, 29, 1)),
                ),
              ),
              new Container(
                width: double.infinity,
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          overlayColor: overlayColor,
                          activeTickMarkColor: activeTickMarkColor,
                          activeTrackColor: activeTrackColor,
                          inactiveTrackColor: inactiveTrackColor,
                          thumbColor: thumbColor,
                          valueIndicatorColor: valueIndicatorColor,
                          showValueIndicator: showValueIndicator
                              ? ShowValueIndicator.always
                              : ShowValueIndicator.onlyForDiscrete,
                        ),
                        child: new RangeSlider(
                          min: min,
                          max: max,
                          lowerValue: lowerValue,
                          upperValue: upperValue,
                          divisions: divisions,
                          showValueIndicator: showValueIndicator,
                          valueIndicatorMaxDecimals: valueIndicatorMaxDecimals,
                          onChanged: (double lower, double upper) {
                            callback(lower, upper);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ])));
  }
}
