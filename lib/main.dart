import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Sicilia Homepage'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  Animation<double> animationScaleDown;
  Animation<double> animationTextSizeDown;
  Animation<double> animationFadeIn;
  Animation<double> animationFadeInInput;
  Animation<double> animationMoveUp;
  Animation<double> animationRotate;
  AnimationController controller, controller2, controller3, controller4;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();

  var height = 500.0;
  var width = 500.0;
  var spacing = 350.0;
  var progressDialog;
  bool isProgressDialog = false;

  @override
  void initState() {
    super.initState();

    initData();

    controller.forward();
    controller4.repeat();

    controller.addListener(() {
      setState(() {
        if (animationFadeIn.status == AnimationStatus.completed) {
          controller2.forward();
          Timer(
              const Duration(milliseconds: 400), () => controller3.forward());
        }
      });
    });

    controller2.addListener(() {
      setState(() {
        if (animationMoveUp.status == AnimationStatus.forward) {
          height = animationScaleDown.value;
          width = height;
        } else if (animationMoveUp.status == AnimationStatus.completed) {}
      });
    });

    controller4.addListener(() {
      setState(() {
        if (animationRotate.status == AnimationStatus.completed) {
          controller4.forward();
        }
      });
    });
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: Container(
            child: Stack(children: <Widget>[Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                colors: [
                  const Color(0xFF9E9E9E),
                  const Color(0xFFE0E0E0),
                  const Color(0xFF9E9E9E)
                ],
                tileMode:
                    TileMode.repeated,
              ),
            ),
          ), Opacity(
            opacity: animationFadeIn.value,
            child: Center(
                child: Container(
                    alignment: Alignment(0.0, animationMoveUp.value),
                    child: Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: <Widget>[
                        Container(
                          child: Image.asset(
                            'images/qwerty.png',
                            height: 250,
                            width: 250,
                          ),
                          alignment: Alignment(0.0, animationMoveUp.value),
                        )
                      ],
                    ))),
          ), Opacity(
              opacity: animationFadeInInput.value,
              child: Stack(children: <Widget>[
                Center(
                  child: Container(
                    width: 320.0,
                    height: 60.0,
                    margin: EdgeInsets.only(bottom: 50),
                    alignment: Alignment.center,
                    child: TextField(
                      controller: usernameController,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp('[A-Za-z0-9\.\@]{1,20}'))
                      ],
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        hintText: 'Enter your Email',
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none,
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(
                          color: Colors.red,
                          width: 1.0,
                        )),
                  ),
                ),
                Center(
                  child: Container(
                    width: 320.0,
                    height: 60.0,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 100.0),
                    child: TextField(
                      controller: passController,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.visiblePassword,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp('[A-Za-z0-9]{1,20}'))
                      ],
                      obscureText: true,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none,
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(
                          color: Colors.red,
                          width: 1.0,
                        )),
                  ),
                ),
                Center(
                  child: GestureDetector(
                      onTap: () {
                        submit();
                      },
                      child: Container(
                        width: 320.0,
                        height: 60.0,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 270.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.all(const Radius.circular(30.0)),
                        ),
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.3,
                          ),
                        ),
                      )),
                ),
                !isProgressDialog
                    ? Container()
                    : Container(
                        alignment: Alignment.center,
                        color: Color.fromARGB(150, 0, 0, 0),
                        child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Transform(
                                  alignment: FractionalOffset.center,
                                  transform: Matrix4.rotationZ(
                                      -animationRotate.value / 360),
                                  child: Image.asset(
                                    'images/ring_design.png',
                                    height: 150.0,
                                    width: 150.0,
                                  )),
                              Container(
                                  margin: const EdgeInsets.only(top: 250.0),
                                  child: Text(
                                    'Signing in...',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 40.0,
                                        fontFamily: 'samarn'),
                                  ))
                            ]))
              ])),
        ]
                )));
  }

  void submit() {
    if (passController.text.isNotEmpty) {
      getSignIn(usernameController.text, passController.text);
    } else {
      showMyDialog('Please enter number');
    }
  }

  getSignIn(String user, String pass) async {
    print(pass);
    setState(() {
      isProgressDialog = true;
    });
  }

  void showMyDialog(String msg) {
    setState(() {
      isProgressDialog = false;
    });

    var alert = AlertDialog(
      content: Stack(
        children: <Widget>[
          Text(
            'Message',
            style:
                TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
          ),
          Container(
              margin: EdgeInsets.only(top: 40.0),
              child: Text(
                '$msg',
                style: TextStyle(
                    color: Colors.black45, fontWeight: FontWeight.bold),
              )),
        ],
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'OK',
              style: TextStyle(color: const Color(0xFF860000)),
            ))
      ],
    );

    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }

  void initData() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    animationFadeIn = Tween(begin: 0.0, end: 1.0).animate(controller);

    controller2 = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animationMoveUp = Tween(begin: 0.0, end: -0.8).animate(controller2);
    animationScaleDown =
        Tween(begin: 300.0, end: 180.0).animate(controller2);
    animationTextSizeDown =
        Tween(begin: 70.0, end: 40.0).animate(controller2);

    controller3 = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    animationFadeInInput = Tween(begin: 0.0, end: 1.0).animate(controller3);

    controller4 = AnimationController(
        duration: Duration(milliseconds: 700), vsync: this);
    animationRotate = Tween(begin: 0.0, end: 360.0).animate(controller4);

    /*progressDialog = AlertDialog(
      content: Container(
        color: Colors.red,
        child: Image.asset(
          'images/ring_design.png',
          height: 100.0,
          width: 100.0,
        ),
      ),
    );*/
  }
}
