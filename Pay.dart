#razorPayPaymentGateway

  //Flutter Razorpay Integration - main.dart
  //Single-file example demonstrating Razorpay checkout using the Razorpay checkout using the `razorpay_flutter` plugin.
  //Important: This example uses client-side checkout with a test key for demonstration only.
  //For production, create orders on a secure backend using Razorpay's Orders API and use the order_id.

  //Add to pubspec.yaml:
  //razorpay_flutter: ^1.3.7
  //http: ^0.13.6 #only if you want to call your backend

  //Android setup(important):
  //1. In android/app/src/main/AndroidManifest.xml ensure you have <uses-permission android:name="android.permission.INTERNET"/>
  //2. For some devices yiu may need to set minSdkVersion to at least 21 in android/app/build.gradle
  //3. No API key in manifest — the key_id is passed at runtime in options (use test key in development)
  
  //iOS setup:
  //1. In ios/Runner/Info.plist add App Transport Security settings if necessary, and ensure you have NSAppTransportSecurity if using HTTP endpoints for your backend.
  //2. Run `pod instant after adding the plugin.

  //NOTE: Replace the testKey with your own Razorpay key from Razorpay Dashboard (Test Mode). Do Not commit live keys.

  import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Razorpay Example',
      theme: ThemeData(primarySwatch:Colors.indigo),
      home: const PaymentPage(),
      );
  }
}

class PaymentPage extends StateWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createSate() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late Razorpay _razorpay;
  String _status = 'Idle';

  //Replace this with your test key.
  Format: rzp_test_xxxxx
    final String_testKey = 'rzp_test_YOUR_KEY_HERE';

  @override
  void initState();
  _razorpay = Razorpay();
  _razorpay.on(Razorpay.EV ENT_PAYMENT_SUCCESS,
               _handlPaymentSuccess);
  
