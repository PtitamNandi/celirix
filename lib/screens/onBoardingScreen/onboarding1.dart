import 'package:celirix/constants.dart';
import 'package:celirix/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:keep_moving/constant.dart';
// import 'package:keep_moving/login/login.dart';

class Onboard1 extends StatefulWidget {
  const Onboard1({Key? key}) : super(key: key);

  @override
  State<Onboard1> createState() => _Onboard1State();
}

class _Onboard1State extends State<Onboard1> {
  int currentPage = 0;
  List<Map> splashData = [
    {
      "text1": "Confirm your Drive",
      "text2":
          "Huge drivers network helps you find a comfortable and cheap ride",
      "image": "images/img4.png",
    },
    {
      "text1": "Request Ride",
      "text2": "Request a ride gets piced up by a nearby community driver",
      "image": "images/img3.png",
    },
    {
      "text1": "Track your ride",
      "text2":
          "Know your driver in adbance and be able to biew current location in real-time on the map",
      "image": "images/img2.png",
    },
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
                flex: 3,
                child: PageView.builder(
                  onPageChanged: ((value) {
                    setState(() {
                      currentPage = value;
                    });
                  }),
                  itemCount: splashData.length,
                  itemBuilder: (context, index) => SplashContent(
                    text1: splashData[index]["text1"],
                    text2: splashData[index]["text2"],
                    image: splashData[index]["image"],
                  ),
                )),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        splashData.length, (index) => buildDot(index)),
                  )
                ],
              ),
            ),
            SizedBox(
              width: size.width - 50,
              height: 45,
              child: ElevatedButton(
                child: Text("Get Started".toUpperCase(),
                    style: TextStyle(fontSize: 14)),
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.deepPurple.shade900),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side: BorderSide(color: Colors.deepPurple.shade900),
                    ),
                  ),
                ),
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setInt("initScreen", 1);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot(int index) {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
          color: currentPage == index ? KprimaryColor : Color(0xFFD8D8D8),
          borderRadius: BorderRadius.circular(3)),
    );
  }
}

class SplashContent extends StatelessWidget {
  const SplashContent(
      {Key? key, required this.text1, required this.text2, required this.image})
      : super(key: key);
  final String text1, text2, image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Spacer(),
          SizedBox(height: 200, width: 200, child: Image.asset(image)),
          Spacer(),
          Text(
            "$text1",
            style: TextStyle(
              color: KprimaryColor,
              fontSize: 20,
            ),
          ),
          Text(
            "$text2",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 20,
            ),
          )
        ],
      ),
    );
  }
}
