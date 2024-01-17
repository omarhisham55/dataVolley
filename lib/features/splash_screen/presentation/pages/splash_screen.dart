import 'dart:async';

import 'package:data_volley_match/config/routes/routes.dart';
import 'package:data_volley_match/core/utils/images.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  _goNext() {
    Navigator.pushReplacementNamed(context, Routes.createAccount);
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 2), () => _goNext());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(MainImages.logo),
      ),
    );
  }
}
