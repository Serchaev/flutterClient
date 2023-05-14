import 'package:flutter/material.dart';
import 'package:untitled1/pages/Statefull/PositionItemStateFull.dart';

class PositionItem extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    print(args);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black87,
        title: const Text(
          "Описание должности"
        ),
      ),
      body: PositionItemStateFull(args["id"]),
    );
  }

}