import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Practice App',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: Homepage1(),
    );
  }
}

class Homepage1 extends StatefulWidget {
  Homepage1({Key key}) : super(key: key);

  @override
  _Homepage1State createState() => _Homepage1State();
}

class _Homepage1State extends State<Homepage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          leading: const Icon(Icons.tag_faces),
          title: const Text('Red Template'),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.directions_bike), onPressed: () {}),
            IconButton(
                icon: const Icon(Icons.directions_bus), onPressed: () {}),
            IconButton(
                icon: const Icon(Icons.directions_ferry), onPressed: () {}),
            PopupMenuButton(itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(child: Text('Boat')),
                const PopupMenuItem(child: Text('Train'))
              ];
            }),
          ],
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Center(
                  child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text('Airplane Reservation',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      )),
                ),
                decoration: BoxDecoration(
                    color: Colors.deepOrangeAccent,
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[500],
                        offset: Offset(4.0, 4.0),
                        blurRadius: 15.0,
                        spreadRadius: 1.0,
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(-4.0, -4.0),
                        blurRadius: 15.0,
                        spreadRadius: 1.0,
                      )
                    ]),
                ),
              ),
              Image.network(
                'https://static.vecteezy.com/system/resources/previews/001/208/420/non_2x/airplane-png.png',
                height: 300,
                width: 300,
              )
            ],
          ),
        ));
  }
}
