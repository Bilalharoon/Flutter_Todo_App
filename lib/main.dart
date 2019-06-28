import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(HomePage());

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  AnimationController controller;

  Animation<double> positionXAnim;
  Animation<double> positionYAnim;
  Animation<double> opacityAnim;
  Animation<double> scaleAnim;

  final List<String> days = ["SUN", "MON", "TUE", "WEN", "THU", "FRI", "SAT"];

  @override
  void initState() {
    super.initState();

    Curve curve = Curves.fastOutSlowIn;
    controller =
        AnimationController(duration: Duration(milliseconds: 400), vsync: this);

    positionXAnim = Tween<double>(begin: 0, end: -150).animate(
      CurvedAnimation(
        curve: curve,
        parent: controller,
      ),
    );

    positionYAnim = Tween<double>(begin: 0, end: -350).animate(CurvedAnimation(
      curve: curve,
      parent: controller,
    ));

    opacityAnim = Tween<double>(begin: 1.0, end: 0).animate(CurvedAnimation(
        curve: Interval(0, 0.5, curve: curve), parent: controller));

    scaleAnim = Tween<double>(begin: 1, end: 20).animate(
      CurvedAnimation(
          curve: Interval(0.5, 1, curve: curve), parent: controller),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        // header
        children: <Widget>[
          // header and appbar stack
          Stack(
            children: <Widget>[
              // image stack
              HeroImage(),
              CustomAppBar(),
            ],
          ),
          // calender
          Calender(days: days),
          // Divider(),
          Expanded(
            child: ListView.separated(
              itemCount: 10,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext ctx, int index) {
                return Task(
                  imgURL:
                      "https://images.unsplash.com/photo-1506919258185-6078bba55d2a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=815&q=80",
                  taskDescription: "Meet with Mark",
                  location: "Starbucks",
                  time: "1pm",
                );
              },
              separatorBuilder: (BuildContext context, int index) => Divider(),
            ),
          )
        ],
      ),
      floatingActionButton: AnimatedBuilder(
        animation: controller,
        builder: (BuildContext ctx, Widget child) => Transform.translate(
              offset: Offset(
                this.positionXAnim.value,
                this.positionYAnim.value,
              ),
              child: Transform.scale(
                scale: this.scaleAnim.value,
                child: FloatingActionButton(
                  onPressed: () async {
                    await controller.forward();

                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 100),
                        pageBuilder: (BuildContext context,
                                Animation<double> entry,
                                Animation<double> exit) =>
                            NewPage(this.controller),
                        transitionsBuilder: (BuildContext ctx,
                            Animation<double> entry,
                            Animation<double> exit,
                            Widget child) {
                          return FadeTransition(
                            opacity: Tween<double>(begin: 0, end: 1).animate(
                              CurvedAnimation(
                                curve: Curves.fastOutSlowIn,
                                parent: entry,
                              ),
                            ),
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  backgroundColor: Color(0xffFC3868),
                  child: Opacity(
                    child: Icon(Icons.add),
                    opacity: this.opacityAnim.value,
                  ),
                ),
              ),
            ),
      ),
    );
  }
}

class Calender extends StatelessWidget {
  const Calender({
    Key key,
    @required this.days,
  }) : super(key: key);

  final List<String> days;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: this.days.map((String day) {
          int index = days.indexOf(day) + 1;
          return Column(
            children: <Widget>[
              Text(
                day,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  index.toString(),
                  style: TextStyle(fontFamily: "Open Sans"),
                ),
              )
            ],
          );
        }).toList(),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class HeroImage extends StatelessWidget {
  const HeroImage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Image.asset(
          "assets/winter.jpg",
          color: Colors.black45,
          colorBlendMode: BlendMode.darken,
          height: 400,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              // greeting text
              Text(
                "Good Morning!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontFamily: "Montserrant",
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 30,
              ),

              // Profile Picture
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/me.jpg"),
                    radius: 80,
                  ),

                  // Notification circle
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
              ),

              // month row
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    // back button
                    Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),

                    // month text
                    Text(
                      "February".toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontFamily: "Open Sans",
                      ),
                    ),

                    // forward button
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class Task extends StatelessWidget {
  final String imgURL;
  final String taskDescription;
  final String time;
  final String location;

  Task(
      {@required this.imgURL,
      @required this.taskDescription,
      @required this.time,
      @required this.location});
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CircleAvatar(
          backgroundImage: NetworkImage(
            this.imgURL,
          ),
          radius: 30,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                this.taskDescription,
                style: TextStyle(fontSize: 20, fontFamily: "Montserrant"),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      this.time,
                      style: TextStyle(fontFamily: "Open Sans"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        this.location,
                        style: TextStyle(fontFamily: "Open Sans"),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class NewPage extends StatefulWidget {
  final AnimationController controller;
  NewPage(this.controller);

  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<ShapeBorder> borderAnim;
  Animation<double> widthAnim;

  @override
  void initState() {
    super.initState();
    this._controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    this.borderAnim = ShapeBorderTween(
            begin: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            end: CircleBorder())
        .animate(CurvedAnimation(
      curve: Curves.easeIn,
      parent: _controller,
    ));

    this.widthAnim = Tween<double>(begin: 500, end: 50).animate(
      CurvedAnimation(
        curve: Curves.easeIn,
        parent: _controller,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.controller.reverse();
        return true;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image.asset(
                "assets/bg.jpg",
                colorBlendMode: BlendMode.darken,
                color: Color(0xff81779D),
                fit: BoxFit.cover,
                height: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.perm_identity,
                          color: Colors.grey,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      obscureText: true,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: Colors.grey,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    AnimatedBuilder(
                        animation: _controller,
                        builder: (BuildContext context, Widget child) {
                          return Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Container(
                                width: this.widthAnim.value,
                                height: 50,
                                child: RaisedButton(
                                  onPressed: () {
                                    this._controller.forward();
                                  },
                                  elevation: 0,
                                  color: Color(0xffFF3365),
                                  padding:
                                      EdgeInsets.only(left: 100, right: 100),
                                  // child: Text(
                                  //   "Sign in",
                                  //   style: TextStyle(
                                  //     color: Colors.white,
                                  //   ),
                                  // ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                              ),
                              _controller.value == 1
                                  ? CircularProgressIndicator(
                                      valueColor: ColorTween(
                                              begin: Colors.white,
                                              end: Colors.white)
                                          .animate(_controller),
                                      strokeWidth: 2,
                                    )
                                  : Text(
                                      "Sign in",
                                      style: TextStyle(color: Colors.white),
                                    )
                            ],
                          );
                        }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
