import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bitcoin news"),
        leading: const Icon(
          Icons.currency_bitcoin,
          color: Colors.orange,
          size: 35,
        ),
      ),
      body: ListView.builder(itemBuilder: itemBuilder),
    );
  }
}
