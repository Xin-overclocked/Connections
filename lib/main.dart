import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to Interview Assistant',
            style:TextStyle(
              fontSize:28.0,
              fontWeight: FontWeight.bold,
              )),
        
 SizedBox(height: 20.0),
 Row(        
            mainAxisAlignment: MainAxisAlignment.center,
children:[
            ElevatedButton(
              onPressed: () {
                print('button 1 pressed!');
              },
              child: Text('Company'),
            ),
        
            SizedBox(width: 30.0),
        
            ElevatedButton(
              onPressed: () {
                print('button 2 pressed!');
              },
              child: Text('Interviewee'),
            ),
],
            ),
          ],
        ),
      ),
    );
  }
}