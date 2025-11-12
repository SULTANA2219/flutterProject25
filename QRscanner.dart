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
  State<QRScannerScreen> createState() => 
    _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String result = 'Scan a QR code';

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
  }

  Future<void>
    _requestCameraPermission() async {
    var status = await
      Permission.camera.request();
    if (status.isDenied) {
      //Handle denial, e.g., show a dialog
      ScaffoldMessenger.of(context).show
        SnackBar(
        const SnackBar(content: Text('Camera permission is required')),
        );
    }
  }

  @override
  void dispose() {
    cobtroller?.dispose();
    super.dispose();
  }

  void
    _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedData
      Stream.listen((scanData)
                    {
                      setState(() {
                        result = scanData.code ?? 'No data';
                      });
                      //Optionally pause scanning after a result
                      controller.pauseCamera();
                    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR Code Scanner')),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.red,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
                ),
              ),
            ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                result,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
                ),
              ),
            ),
          ElevatedButton(
            onPressed: () {
              controller?.resumeCamera();
              setState(() {
                result = 'Scan a QR code';
              });
            },
            child: const Text('Scan Again'),
            ),
          ],
        ),
      );
  }
}
//Connect device
//Run 'flutter run' in terminal
//Scan a QR code
  
    
