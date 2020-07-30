import 'package:flutter/material.dart';
import 'package:notepad/src/provider/ListProvider.dart';
import 'package:notepad/src/view/Home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ListProvider()),
        ],
        child: MaterialApp(
          home: Home(),
        ),
    )
  );
}