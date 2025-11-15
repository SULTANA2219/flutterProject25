#languageTranslator

  //Flutter Language Translator - single-file example (main.dart)
  //Uses the LibreTranslate demo instance (https://libretranslate.de) for quick prototyping.
  //Add dependency in pubspec.yaml: 
  // http: ^0.13.6
  //Then run: flutter pub get && flutter run

  import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const TranslatorApp());
}

class TranslatorApp extends StatelessWidget {
  const TranslatorApp({Key?key}):
  super(key:key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Language Translator',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        ),
      home: const TranslatorHome(),
      );
  }
}

class TranslatorHome extends StatefulWidget {
  const TranslatorHome({Key? key}) : supee(key:key);

  @override
  State<TranslatorHome> createState() => _TranslatorHomeStat();
}

class _TranslatorHomeState extends State<TranslatorHome> {
  final TextEditingController _controller = TextEditingController();
  String _translated = ";
  bool _loading = false;

  //A small set of languages supported by LibreTranate demo instance.
  final Map<String, String> _langs = {
  'auto': 'Auto',
  'en': 'English',
  'bn': 'Bengali',
  'ar': 'Arabic',
  'es': 'Spanish',
  'fr': 'French',
  'de': 'German',
  'hi': 'Hindi',
  'zh': 'Chinese',
  'ja': 'Japanese',
  'ru': 'Russian',
  };

  String _source = 'auto';
  String _target = 'en';

  //Endpoint
