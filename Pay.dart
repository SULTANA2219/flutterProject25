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
  _razorpay.on(Razorpay.EV ENT_PAYMENT_SUCCESS, _handlPaymentSuccess);
  _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
}

@override
void dispose() {
  _razorpay.clear();
  super.dispose();
}

void _handlePaymentSuccess(PaymentSuccessResponse response)
{
  setState(() {
    _status = 'SUCCESS: $ {response.paymentId}';
  });
  //TODO: verify payment signature on your backend for security in production
  _showAlert('Paynent Successful', 'Payment ID: ${response.paymentId}');
}

void _handlePaymentError(PaymentFailureResponse response)
{
  setState(() {
    _status = 'ERROR: ${response.code} - ${response.message}';
  });
  _showAlert('Payment Failed', 'Code: ${response.code}\nMessage: ${response.message}');
}

void _handleExternalWallet(ExternalWalletResponse response)
{
  setState(() {
    _status = 'EXTERNAL WALLET: ${response.walletName}';
  });
  _showAlert('External Wallet', 'Wallet: ${response.walletName}');
}

Future<void> _openCheckout() async {
  //For production, create an order on your backend using Razorpay Orders API and use `order_id` bellow.
  //Example options: https://razorpay.com/docs/payment-gateway/web-integration/standard/checkout/

  var options = {
    'key': _testKey,
    'amount': 50000, //amount in paise -> 50000 paise = INR 500.00
    'name': 'Slide Sultana Shop',
    'description': 'Test Payment',
    'prefill': {
      'contact': '9999999999',
      'email': 'customer@example.com'
      },
    //'order_id':
    'order_DBJOWzybf0sJbb', //optional — use when you create order server-side
    'notes': {
      'order_id': '12345',
      'customer_id': 'cust_001'
      },
    'theme': {'color': '#4B0082'}
  };

  try {
    _razorpay.open(options);
  } catch (e) {
    debugPrint('Error: $e');
  }
}

void _showAlert(String title, String body) {
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        TextButton(
          onPressed: () =>
          Navigator.of(context).pop(),
          child: const Text('OK'),
          )
        ],
      ),
    );
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Razorpay Payment Example')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text("Tap below to start a Razorpay checkout (Test mode)'),
          const SizedBox(height:16),
          ElevatedButton.icon(
          icon: const Icon(Icons.payment),
          label: const Text('Pay INR 500'),
          onPressed: _openCheckout,
          ),
          const SizedBox(height: 24),
          const Text('Status', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SelectableText(_status),
          const SizedBox(height: 24),
          const Text('Notes', style: TextStyle(fontWeight: FontWeight bold)),
          const SizedBox(height: 8),
          const Text('• This demo passes a test key from the client. For secure verification, use server-side orders and verify webhooks or signatures.'),
          const SizedBox(height: 8),
          const Text('• Replace the _testKey variable with your Razorpay test key before running.'),
          ],
          ),
          ),
          );
          }
          }

          
    
    
  
