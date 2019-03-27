import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//3.6.1
class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => new _EditProfileState();
}
//3.6.2
class _EditProfileState extends State<EditProfile>
    with TickerProviderStateMixin {
  Future<File> _imageFile;
  DataListBuilder dataListBuilder = new DataListBuilder();

  void _openImagePicker(BuildContext context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Vælg billede fra: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                FlatButton(
                  textColor: Theme.of(context).accentColor,
                  child: Text('Kamera'),
                  onPressed: () {
                    getImage(index, ImageSource.camera);
                  },
                ),
                FlatButton(
                  textColor: Theme.of(context).accentColor,
                  child: Text('Galleri'),
                  onPressed: () {
                    getImage(index, ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
        });
  }

  // 3.6.2.1
  getImage(int index, ImageSource source) {
    List<GridImage> list = dataListBuilder.gridData;
    if (list[index].imageFile != null) {
      list[index].imageFile = null;
      setState(() {
        _imageFile = null;
      });
    } else {
      _imageFile = ImagePicker.pickImage(source: source);
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

  // 3.6.2.2
  Widget _buildProfileImageBox(int index, List<GridImage> list)
  {
    return ProfileImage(
                      margin: 10.0,
                      width: 90.0,
                      height: 130.0,
                      numtext: (index + 1).toString(),
                      imageFile: list[index].imageFile,
                      iconOnClick: () {
                        _openImagePicker(context, index);
                      },
                    );
  }

  //3.6.2.3
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    List<GridImage> list = dataListBuilder.gridData;

    return new Scaffold(
      appBar: new AppBar(
        elevation: 1.0,
        backgroundColor: Theme.of(context).backgroundColor,
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
                    _openImagePicker(context,0);
                  },
                ),
                new Column(
                  children: <Widget>[
                    _buildProfileImageBox(1, list),
                    _buildProfileImageBox(2, list),
                  ],
                )
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildProfileImageBox(3, list),
                _buildProfileImageBox(4, list),
                _buildProfileImageBox(5, list),
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
                        fontSize: 28, color: Color.fromRGBO(220, 28, 39, 1)),
                  ),
                ),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

//3.6.3
class GridImage {
  Future<File> imageFile;

  GridImage({
    this.imageFile,
  });
}
//3.6.4
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
//3.6.4.1
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
//3.6.5
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
//3.6.5.1
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
//3.6.6
class ProfileInputs extends StatelessWidget {
  String placeholder;
  int lines;
  String title;

  ProfileInputs({this.lines, this.placeholder, this.title});
//3.6.6.1
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

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
