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

  //Endpoint - using the public LibreTranslate demo server for examples.
  // Replace with Google Translate API for production.
  final String _endpoint = 'https://libretranslate.de/translate';

  Future<void> _translate() async {
  final text = _controller.text.trim();
  if (text.isEmpty) return;

  setState(() {
  _loading = true;
  _tranlated = ";
});

try {
  final response = await http.post(
    Uri.parse(_endpoint),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'q': text,
      'source': _source,
      'target': _target,
      'format': 'text',
    }),
    ).timeout(const Duration(seconds: 15));

  if (response.statusCode == 200) {
    final body = jsonDecode(response.body);
    //LibreTranslate returns 
    {"translatedText":"..."}
    setState(() {
      _translated = body['translatedText'] ?? ";
      });
      } else {
      setState(() {
      _translated = 'Error: ${response.statusCode} - ${response.reasonPhrase}';
      });
      }
      } catch (e) {
      setState(() {
      _translated = 'Error: $e';
      });
      } finally {
      setState(() {
      _loading = false;
     });
   }
 }

 void _swapLanguages() {
 setState(() {
 final tmp = _source;
 _source = _target;
 _target = tmp;
});
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text('Language Translator'),
centerTitle: true,
),
body: Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.stretch,
children: [
TextField(
controller: _controller,
minLines: 1,
maxLines: 6,
decoration: const InputDecoration(
border: OutlineInputBorder(),
labelText: 'Enter text',
hintText: 'Type something to translate',
),
),
const SizedBox(height: 12),
Row(
children: [
Expanded(
child: DropdownButtonFormField<String>(
value: _source,
items: _langs.entries.map((e) => 
DropdownMenuItem<String>(
value: e.key,
child: Text(e.value),
))
.toList(),
onChanged: (v) => setState(() => _source = v ?? 'auto'),
decoration: const InputDecoration(
labelText: 'From',
border: OutlineInputBorder(),
),
),
),
const SizedBox(width: 8),
IconButton(
onPressed: _swapLanguages,
tooltip: 'Swap',
icon: const Icon(Icons.swap_horiz),
),
const SizedBox(width: 8),
Expanded(
child: DropdownButtonFromField<String>(
value: _target,
items: _langs.entries
.where((e) => e.key != 'auto') //target shouldn't be auto
.map((e) => DropdownMenuItem<String>(
value: e.key,
child: Text(e.value),
))
.toList(),
onChanged: (v) => setState(() => _target = v ?? 'en'),
decoration: const InputDevoration(
labelText: 'To',
border: OutlineInputBorder(),
),
),
),
],
),
const SizedBox(height: 12),
ElevatedButton.icon(
onPressed: _loading ? null: _translate,
icon: const Icon(Icons.translate),
label: _loading ? const Text('Translating...'):const Text('Translate'),
),
const SizedBox(height:16),
const Text(
'Result',
style: TextStyle(fontWeight: FontWeight.bold),
),
const SizedBox(height: 8),
Expanded(
child: Container(
padding: const EdgeInsets.all(12),
decoration: BoxDecoration(
border: Border.all(color: Colors.grey.shade300),
borderRadius: BorderRadius.circular(8),
),
child: SingleChildScrollView(
 child: Selectable Text(
 _translated.isEmpty ? 'Translation will appear here' : _translated,
 style: const TextStyle(fontSize: 16),
 ),
 ),
 ),
 ),
 ],
 ),
 ),
 );
 }
 }


      
