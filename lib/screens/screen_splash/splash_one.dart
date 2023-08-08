import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:money_management/screens/home/screen_main.dart';
import 'package:money_management/screens/screen_splash/splash_two.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class Splash_One extends StatefulWidget {
  const Splash_One({super.key});

  @override
  State<Splash_One> createState() => _Splash_OneState();
}

// ignore: camel_case_types
class _Splash_OneState extends State<Splash_One> {
  @override
  void initState() {
    goHome();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Center(
          child: Container(
            color: Colors.white,
            child: Lottie.asset('images/loading.json'),
          ),
        ),
      ),
    );
  }

  Future<void> goHome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool a = prefs.getBool('check') ?? false;

    await Future.delayed(const Duration(seconds: 3));
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => a ? ScreenMain() : const ScreenSplashTwo(),
      ),
    );
  }
}
