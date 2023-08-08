import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:money_management/screens/home/screen_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenSplashTwo extends StatefulWidget {
  const ScreenSplashTwo({super.key});

  @override
  State<ScreenSplashTwo> createState() => _ScreenSplashTwoState();
}

class _ScreenSplashTwoState extends State<ScreenSplashTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Lottie.asset('images/lottie2.json'),
                ),
                const SizedBox(
                  height: 100,
                ),
                const Text(
                  "Simple solution",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "For your budget",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 40),
                  child: Text(
                    "Counter and distribute the income correctly.....",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setBool('check', true);
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ScreenMain();
                          },
                        ),
                      );
                    },
                    child: const Text('Continue'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
