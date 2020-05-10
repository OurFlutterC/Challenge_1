import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  AnimationController scontroller;
  AnimationController rcontroller;
  AnimationController tlcontroller;
  AnimationController icncontroller;

  Animation<double> scale;
  Animation<double> rotate;
  Animation<double> top;
  Animation<double> left;
  Animation<double> icn;
  static BoxDecoration decor({Color clr = Colors.white, bool sh = true}) {
    return BoxDecoration(
        color: clr,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
              color: sh ? Colors.black12 : Colors.white,
              blurRadius: 10.0,
              spreadRadius: 5.0)
        ]);
  }

  Container seContainer = Container(
    width: 130.0,
    height: 30.0,
    child: Center(
        child: Text("IN YOUR BASKET",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold))),
    decoration: decor(clr: Colors.redAccent.withOpacity(0.4), sh: false),
  );
  Widget container(double h, double w) {
    return Container(
      width: w,
      height: h,
      color: Colors.grey[500].withOpacity(0.3),
    );
  }

  bool checker = false;
  int itemsCount = 0;
  int itm = 0;

  @override
  void initState() {
    scontroller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    rcontroller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));

    tlcontroller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    icncontroller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 50));
    rotate = Tween(begin: 0.0, end: -0.2).animate(
        CurvedAnimation(parent: rcontroller, curve: Curves.fastOutSlowIn));
    scale = Tween(begin: 130.0, end: 40.0).animate(
        CurvedAnimation(parent: scontroller, curve: Curves.fastOutSlowIn));
    top = Tween(
      begin: 628.0,
      end: 460.0,
    ).animate(tlcontroller);
    left = Tween(begin: 150.0, end: 300.0).animate(
        CurvedAnimation(parent: tlcontroller, curve: Curves.easeOutCirc));
    icn = Tween(begin: 460.0, end: 445.0).animate(
        CurvedAnimation(parent: icncontroller, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 120.0,
              left: width / 9,
              child: Container(
                decoration: decor(),
                height: height * 0.12,
                width: width * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      width: width * 0.2,
                      height: width * 0.2,
                      decoration:
                          decor(clr: Colors.blue.withOpacity(0.2), sh: false),
                    ),
                    Column(
                      children: <Widget>[
                        SizedBox(height: 5.0),
                        container(15.0, 100.0),
                        SizedBox(height: 10.0),
                        container(15.0, 100.0),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 5.0,
                        ),
                        container(15.0, 100.0),
                        SizedBox(
                          height: 5.0,
                        ),
                        container(15.0, 100.0),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: 300.0,
              top: icn.value,
              child: SizedBox(
                height: width * 0.15,
                child: Stack(
                  children: <Widget>[
                    Container(
                        child: Icon(
                          Icons.shopping_cart,
                          size: 30.0,
                          color: checker ? Colors.red : Colors.grey,
                        ),
                        height: width * 0.12,
                        width: width * 0.12,
                        decoration: decor()),
                    checker
                        ? Align(
                            alignment: Alignment(-0.5, -1.5),
                            child: CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 10.0,
                              child: Text(itemsCount.toString()),
                            ))
                        : Container(),
                  ],
                ),
              ),
            ),
            !top.isCompleted
                ? Positioned(
                    top: top.value,
                    left: left.value,
                    child: AnimatedContainer(
                      width: scale.value,
                      duration: Duration(microseconds: 500),
                      child: RotationTransition(
                        turns: rotate,
                        child: OutlineButton(
                            borderSide: BorderSide(
                                color: Colors.red,
                                width: 1.0,
                                style: BorderStyle.solid),
                            child: scale.value > 100
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Icon(
                                        Icons.add,
                                        color: Colors.red,
                                        size: 20.0,
                                      ),
                                      Expanded(
                                          child: Text(
                                        "ADD TO BASKET",
                                        style: TextStyle(
                                            fontSize: 8.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red),
                                      ))
                                    ],
                                  )
                                : Icon(
                                    Icons.add,
                                    color: Colors.red,
                                    size: 20.0,
                                  ),
                            splashColor: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            onPressed: () {
                              itm++;
                              scale.addListener(() {
                                setState(() {});
                              });
                              scontroller.forward();
                              scale.addStatusListener((s) {
                                if (s == AnimationStatus.completed) {
                                  rotate.addListener(() {
                                    setState(() {});
                                  });
                                  rcontroller.forward();
                                  rotate.addStatusListener((status) {
                                    if (s == AnimationStatus.completed) {
                                      top.addListener(() {
                                        setState(() {});
                                      });
                                      left.addListener(() {
                                        setState(() {});
                                      });
                                      tlcontroller.forward();

                                      top.addStatusListener((status) {
                                        if (status ==
                                            AnimationStatus.completed) {
                                          icn.addListener(() {
                                            setState(() {});
                                          });
                                          icncontroller.forward();

                                          checker = true;
                                          icn.addStatusListener((status) {
                                            if (status ==
                                                AnimationStatus.completed) {
                                              scontroller.reset();
                                              rcontroller.reset();
                                              tlcontroller.reset();
                                              icncontroller.reverse();
                                              itemsCount = itm;
                                            }
                                          });
                                        }
                                      });
                                    }
                                  });
                                }
                              });
                            }),
                      ),
                    ),
                  )
                : Positioned(top: 638.0, left: 150.0, child: seContainer),
          ],
        ),
      ),
    );
  }
}
