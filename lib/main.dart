import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        child: Stack(
          children: <Widget>[
            Container(
              child: Image.asset(
                "assets/winter.jpg",
              ),
            ),
            Scaffold(
              body: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Image.asset(
                            "assets/winter.jpg",
                            color: Colors.black45,
                            colorBlendMode: BlendMode.darken,
                            height: 400,
                            fit: BoxFit.cover,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Good Morning",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 30),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundImage:
                                        AssetImage("assets/me.jpg"),
                                    radius: 80,
                                  ),
                                  Positioned(
                                    height: 40,
                                    width: 40,
                                    right: 5,
                                    top: 0,
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        3.toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xff4FD2C1),
                                      ),
                                      height: 20,
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      Container(
                        child: AppBar(
                          backgroundColor: Colors.transparent,
                          leading: Icon(
                            Icons.menu,
                            size: 30.0,
                          ),
                          actions: <Widget>[
                            Icon(
                              Icons.search,
                              size: 30.0,
                            )
                          ],
                          elevation: 0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
