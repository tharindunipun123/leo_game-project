import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  List<int> multipleValues = [5, 10, 15, 20, 25, 30, 35, 40];
  int timeDuration = 30;
  Timer? _timer;
  late AnimationController _animationController;
  late Animation<double> _handPointerAnimation;
  List<Color> containerColors = List.generate(8, (_) => Colors.white);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 30),
      vsync: this,
    );
    _handPointerAnimation = Tween<double>(begin: 0, end: 7).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    )..addListener(() {
      int newIndex = _handPointerAnimation.value.floor();
      if (newIndex >= 0 && newIndex < containerColors.length) {
        setState(() {
          containerColors.fillRange(0, containerColors.length, Colors.white);
          containerColors[newIndex] = Colors.red;
        });
      }
    })..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reset();
        startTimer();
      }
    });
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (timeDuration == 0) {
        timer.cancel();
        _animationController.forward();
        startSecondTimer();
      } else {
        setState(() {
          timeDuration--;
        });
      }
    });
  }

  void startSecondTimer() {
    timeDuration = 5;
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (timeDuration == 0) {
        timer.cancel();
        startTimer();
      } else {
        setState(() {
          timeDuration--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget image1 = Image.asset('assets/image1.png', width: 50.0, height: 50.0);
    final Widget image2 = Image.asset('assets/image2.png', width: 40.0, height: 40.0);
    final Widget image3 = Image.asset('assets/image3.png', width: 40.0, height: 40.0);
    final Widget image4 = Image.asset('assets/image4.png', width: 40.0, height: 40.0);
    final Widget image5 = Image.asset('assets/image5.png', width: 40.0, height: 40.0);
    final Widget image6 = Image.asset('assets/image6.png', width: 40.0, height: 40.0);
    final Widget image7 = Image.asset('assets/image7.png', width: 40.0, height: 40.0);
    final Widget image8 = Image.asset('assets/image8.png', width: 40.0, height: 40.0);
    final Widget iconLeft = Image.asset('assets/diamond.png', width: 20.0, height: 20.0);
    final Widget iconRight = Image.asset('assets/diamond.png', width: 20.0, height: 20.0);
    final Widget handImage = Image.asset('assets/handImage.png', width: 30.0, height: 30.0);
    int walletBalance = 0;
    int winAmount= 0;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Animation Demo',
      home: Scaffold(
        body: Stack(
          children: [
            Image.asset('assets/bg.png', fit: BoxFit.cover, width: double.infinity, height: double.infinity),
            Center(
              child: Image.asset('assets/wheel.png', width: 750.0, height: 1150.0),
            ),
            // ...List.generate(8, (index) => Positioned(...)) // Remove this repeated code
            // Replace the repeated code with the following Positioned widgets
            Positioned(
              top: 145,
              left: 155,
              child: buildContainer(0),
            ),
            Positioned(
              top: 168,
              left: 243,
              child: buildContainer(1),
            ),
            Positioned(
              top: 255,
              left: 270,
              child: buildContainer(2),
            ),
            Positioned(
              top: 347,
              left: 247,
              child: buildContainer(3),
            ),
            Positioned(
              top: 380,
              left: 155,
              child: buildContainer(4),
            ),
            Positioned(
              top: 348,
              left: 65,
              child: buildContainer(5),
            ),
            Positioned(
              top: 255,
              left: 40,
              child: buildContainer(6),
            ),
            Positioned(
              top: 169,
              left: 70,
              child: buildContainer(7),
            ),
            AnimatedBuilder(
              animation: _handPointerAnimation,
              builder: (context, child) {
                return Positioned(
                  top: 145 + _handPointerAnimation.value * 49, // Adjusted position logic to move between containers
                  left: 155,
                  child: child!,
                );
              },
              child: Image.asset('assets/handImage.png', width: 30.0, height: 30.0),
            ),
            Positioned(
              top: 262,
              left: 155,
              child: Container(
                width: 82,
                height: 82,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Please bet", style: TextStyle(color: Colors.white)),
                      Text("$timeDuration s", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 40,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.red,
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.red,
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                  Text(
                    'GREEDY LEO',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..shader = LinearGradient(
                          colors: <Color>[Colors.purple, Colors.blue],
                        ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                    ),
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.red,
                        child: Icon(Icons.add, color: Colors.white),
                      ),
                      SizedBox(width: 20),
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.red,
                        child: Icon(Icons.add, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 100.0,
                decoration: BoxDecoration(
                  color: Color(0xffa10b14),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Balance', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                                SizedBox(width: 10),
                                iconLeft,
                              ],
                            ),
                          ),
                        ),
                        VerticalDivider(
                          color: Colors.white,
                          width: 2,
                          indent: 10,
                          endIndent: 10,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Win', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                                SizedBox(width: 10),
                                iconRight,
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      left: 160,
                      top: 35,
                      child: Text('$walletBalance', style: TextStyle(color: Colors.yellow, fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    Positioned(
                      right: 30,
                      top: 35,
                      child: Text('$winAmount', style: TextStyle(color: Colors.yellow, fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
            // Additional buttons
            Positioned(
              top: 525,
              left: 65,
              child: GestureDetector(
                onTap: () {
                  // Handle button tap here
                  // Example: setState to change button color and text color
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white, // Initial color
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text("10x"), // Add image to the button
                  ),
                ),
              ),
            ),
            Positioned(
              top: 525,
              left: 135,
              child: GestureDetector(
                onTap: () {
                  // Handle button tap here
                  // Example: setState to change button color and text color
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white, // Initial color
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text("100x"), // Add image to the button
                  ),
                ),
              ),
            ),
            Positioned(
              top: 525,
              left: 205,
              child: GestureDetector(
                onTap: () {
                  // Handle button tap here
                  // Example: setState to change button color and text color
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white, // Initial color
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text("500x"), // Add image to the button
                  ),
                ),
              ),
            ),
            Positioned(
              top: 525,
              left: 275,
              child: GestureDetector(
                onTap: () {
                  // Handle button tap here
                  // Example: setState to change button color and text color
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white, // Initial color
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "1000x",
                      style: TextStyle(color: Colors.black), // Initial text color
                    ),
                  ),
                ),
              ),
            ),
            // Additional rectangular container for images
            Positioned(
              bottom: 120,
              left: 20,
              right: 20,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[300]?.withOpacity(0.7), // Adjust the opacity value as needed (0.0 to 1.0)
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Result :", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    image1,
                    image2,
                    image3,
                    image4,
                    image5,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildContainer(int index) {
    return Container(
      width: 83,
      height: 83,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: containerColors[index], width: 3),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/image${index + 1}.png', width: 40),
            Text("${multipleValues[index]} Time", style: TextStyle(color: Colors.black, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
