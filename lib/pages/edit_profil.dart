import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => new _EditProfileState();
}

class _EditProfileState extends State<EditProfile>
    with TickerProviderStateMixin {
  Future<File> _imageFile;
  DataListBuilder dataListBuilder = new DataListBuilder();

  getImage(int index) {
    List<GridImage> list = dataListBuilder.gridData;
    if (list[index].imageFile != null) {
      list[index].imageFile = null;
      setState(() {
        _imageFile = null;
      });
    } else {
      _imageFile = ImagePicker.pickImage(source: ImageSource.gallery);
      _imageFile.then((onValue) {
        print(onValue);
        if (onValue != null) {
          list[index].imageFile = _imageFile;
          setState(() {
            _imageFile = null;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery
        .of(context)
        .size;

    List<GridImage> list = dataListBuilder.gridData;

    return new Scaffold(
      appBar: new AppBar(
        elevation: 1.0,
        backgroundColor: Theme
            .of(context)
            .backgroundColor,
        title: new Text(
          " Ret profil",
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
        padding: new EdgeInsets.all(10.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.all(10.0),
              child: new Text(
                "Billeder",
                style: new TextStyle(fontSize: 20.0, fontFamily: "Bedas"),
              ),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new ProfileImage(
                  margin: 10.0,
                  width: 200.0,
                  height: 280.0,
                  numtext: "1",
                  imageFile: list[0].imageFile,
                  iconOnClick: () {
                    getImage(0);
                  },
                ),
                new Column(
                  children: <Widget>[
                    new ProfileImage(
                      margin: 10.0,
                      width: 90.0,
                      height: 130.0,
                      numtext: "2",
                      imageFile: list[1].imageFile,
                      iconOnClick: () {
                        getImage(1);
                      },
                    ),
                    new ProfileImage(
                      margin: 10.0,
                      width: 90.0,
                      height: 130.0,
                      numtext: "3",
                      imageFile: list[2].imageFile,
                      iconOnClick: () {
                        getImage(2);
                      },
                    ),
                  ],
                )
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new ProfileImage(
                  margin: 10.0,
                  width: 90.0,
                  height: 130.0,
                  numtext: "6",
                  imageFile: list[5].imageFile,
                  iconOnClick: () {
                    getImage(5);
                  },
                ),
                new ProfileImage(
                  margin: 10.0,
                  width: 90.0,
                  height: 130.0,
                  numtext: "5",
                  imageFile: list[4].imageFile,
                  iconOnClick: () {
                    getImage(4);
                  },
                ),
                new ProfileImage(
                  margin: 10.0,
                  width: 90.0,
                  height: 130.0,
                  numtext: "4",
                  imageFile: list[3].imageFile,
                  iconOnClick: () {
                    getImage(3);
                  },
                ),
              ],
            ),
            new ProfileInputs(
              title: "Noget JSON",
              placeholder: "Om dig",
              lines: 5,
            ),
            new ProfileInputs(
              title: "Noget JSON",
              placeholder: "Film serier",
              lines: 5,
            ),
            new RaisedButton(
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
              ), onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class GridImage {
  Future<File> imageFile;

  GridImage({
    this.imageFile,
  });
}

class DataListBuilder {
  List<GridImage> gridData = new List<GridImage>();

  GridImage row1 = new GridImage(
    imageFile: null,
  );
  GridImage row2 = new GridImage(
    imageFile: null,
  );
  GridImage row3 = new GridImage(
    imageFile: null,
  );
  GridImage row4 = new GridImage(
    imageFile: null,
  );
  GridImage row5 = new GridImage(
    imageFile: null,
  );
  GridImage row6 = new GridImage(
    imageFile: null,
  );
  GridImage row7 = new GridImage(
    imageFile: null,
  );

  DataListBuilder() {
    gridData.add(row1);
    gridData.add(row2);
    gridData.add(row3);
    gridData.add(row4);
    gridData.add(row5);
    gridData.add(row6);
    gridData.add(row7);
  }
}

class ProfileImage extends StatelessWidget {
  final double margin;
  final double width;
  final double height;
  final String numtext;
  final Function iconOnClick;
  final Future<File> imageFile;

  ProfileImage({this.imageFile,
    this.margin,
    this.width,
    this.height,
    this.numtext,
    this.iconOnClick});

  @override
  Widget build(BuildContext context) {
    return new Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        new Container(
          margin: new EdgeInsets.all(margin),
          width: width,
          height: height,
          decoration: new BoxDecoration(color: Colors.grey),
          child: new FutureBuilder<File>(
            future: imageFile,
            builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.data != null) {
                return new Stack(
                  alignment: Alignment.topRight,
                  children: <Widget>[
                    new Image.file(
                      snapshot.data,
                      width: width,
                      height: height,
                      fit: BoxFit.fill,
                    ),
                  ],
                );
              } else if (snapshot.error != null) {
                return const Text('error picking image.');
              } else {
                return const Text('');
              }
            },
          ),
        ),
        new InkWell(
          onTap: iconOnClick,
          child: new Container(
            width: 30.0,
            height: 30.0,
            margin: new EdgeInsets.only(top: 20.0),
            alignment: Alignment.center,
            decoration: new BoxDecoration(shape: BoxShape.circle),
            child: new Icon(
              imageFile == null ? Icons.add : Icons.cancel,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class ProfileInputs extends StatelessWidget {
  String placeholder;
  int lines;
  String title;

  ProfileInputs({this.lines, this.placeholder, this.title});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery
        .of(context)
        .size;

    return new Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Text(
              title,
              style: new TextStyle(fontSize: 20.0, fontFamily: "Bedas"),
            ),
          ),
          new Card(
            elevation: 0.0,
            child: new TextFormField(
              maxLines: lines,
              decoration: new InputDecoration(
                hintText: placeholder,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(15.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
