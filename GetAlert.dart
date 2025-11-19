#alertDialogBox

  //alert dialogue box flutter
  import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AlertDemo(),
      );
  }
}

class AlertDemo extends
  StatelessWidget {
  AlertDemo({super.key});

  void showMyAlert(BuildContext content) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialo(
          title: Text("Hello Sultana!"),
          content: Text("This is an alert dialog box example."),
          actions: [
            TextButton(
              onPressed: () => 
              Navigator.pop(context),
              child: Text("Close"),
              )
            ],
          );
      },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Alert Dialog Example")),
      body: Center(
        child: ElevatedButton(
          onPressed: () =>
          showMyAlert(context),
          child: Text("Show Alert"),
          ),
        ),
      );
  }
}
