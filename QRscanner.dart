#QRcodeScanner

  /*
  Add: 
  dependencies:
  flutter: 
  sdk: flutter qr_code_scanner: ^1.0.1 #For QR code scanning
  permission_handler: ^11.0.1 #For camera permissions
  Into 'punspec.file' under 'dependencies' 
  */
  //Run 'flutter pub get' to install them.
  /* Add:
  <uses-permission android:name="android.permission.CAMERA"/
  >
  to update android permission & save it in 'android/app/src/main/AndroidManifest.xml'
  */

  //Main code
  
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Code Scanner',
      theme: ThemeData(primarySwatch:Colors.blue),
      home: const QRScannerScreen(),
      );
  }
}

class QRScannerScreen extends
  StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen>
    
