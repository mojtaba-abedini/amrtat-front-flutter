import 'package:flutter/material.dart';

class PaperPrice extends StatefulWidget {
  const PaperPrice({Key? key}) : super(key: key);

  @override
  State<PaperPrice> createState() => _PaperPriceState();
}

class _PaperPriceState extends State<PaperPrice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('قیمت کاغذ'),
        toolbarHeight: 75,
        centerTitle: true,
      ),
      body: const Center(
        child:Text('قیمت کاغذ'),
      ),
    );
  }
}
