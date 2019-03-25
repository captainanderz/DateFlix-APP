import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart';
//3.2.1
class AccSettings extends StatefulWidget {
  @override
  _AccSeetingsState createState() => new _AccSeetingsState();
}
//3.2.2
class _AccSeetingsState extends State<AccSettings>
    with TickerProviderStateMixin {
  bool man = false;
  bool woman = true;
  bool other = false;
  List<RangeSliderData> rangeSliders;
//3.2.2.1
  @override
  void initState() {
    super.initState();
    rangeSliders = _rangeSliderDefinitions();
  }
//3.2.2.2
  List<Widget> _buildRangeSliders() {
    List<Widget> children = <Widget>[];
    for (int index = 0; index < rangeSliders.length; index++) {
      children
          .add(rangeSliders[index].build(context, (double lower, double upper) {
        setState(() {
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
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return new Scaffold(
        appBar: new AppBar(
          elevation: 1.0,
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
                                });
                              },
                              activeColor: Colors.red,
                              activeTrackColor: Colors.red,
                            )),
                        new ListTile(
                            title: new Text("Kvinder", style: new TextStyle(
                                color: new Color.fromRGBO(220, 28, 29, 1)),),
                            trailing: new Switch(
                              value: woman,
                              onChanged: (bool newValue) {
                                setState(() {
                                  woman = newValue;
                                });
                              },
                              activeColor: Colors.red,
                              activeTrackColor: Colors.red,
                            )),
                        new ListTile(
                          title: new Text("Andet",style: new TextStyle(
                              color: new Color.fromRGBO(220, 28, 29, 1)),),
                          trailing: new Switch(
                            value: other,
                            onChanged: (bool newValue) {
                              setState(() {
                                other = newValue;
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
              RaisedButton(
                child: new Container(
                  width: screenSize.width,
                  padding: new EdgeInsets.only(top: 5.0, bottom: 5.0),
                  height: 40.0,
                  child: new Center(
                    child: Text(
                      'Gem',
                      style: TextStyle(
                          fontSize: 28, color: Color.fromRGBO(220, 28, 39, 1)),
                    ),
                  ),
                ),
                onPressed: () {},
              ),
              RaisedButton(
                child: new Container(
                  width: screenSize.width,
                  padding: new EdgeInsets.only(top: 5.0, bottom: 5.0),
                  height: 40.0,
                  child: new Center(
                    child: Text(
                      'Log ud',
                      style: TextStyle(
                          fontSize: 28, color: Color.fromRGBO(220, 28, 39, 1)),
                    ),
                  ),
                ),
                onPressed: () {},
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
                onPressed: () {},
              ),
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
    this.overlayColor: defaultOverlayColor,
    this.activeTrackColor: defaultActiveTrackColor,
    this.inactiveTrackColor: defaultInactiveTrackColor,
    this.thumbColor: defaultThumbColor,
    this.valueIndicatorColor: defaultValueIndicatorColor,
    this.activeTickMarkColor: defaultActiveTickMarkColor,
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
                title: new Text("Alder",style: new TextStyle(
                    color: new Color.fromRGBO(220, 28, 29, 1)),),
                trailing: new Text((lowerValueText) + "-" + (upperValueText), style: new TextStyle(color: new Color.fromRGBO(220, 28, 29, 1)),),
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
