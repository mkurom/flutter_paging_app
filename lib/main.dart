import 'package:flutter/material.dart';
import 'package:flutter_paging_app/paging_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paging Sample App',
      home: PagingPage(),
    );
  }
}
