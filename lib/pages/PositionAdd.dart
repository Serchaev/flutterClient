import 'package:flutter/material.dart';

import 'Statefull/PositionAddStateFull.dart';

class PositionAdd extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        centerTitle: true,
        title: Text(
          "Добавление должности"
        ),
      ),
      body: PositionAddStateFull(context),
    );
  }

}