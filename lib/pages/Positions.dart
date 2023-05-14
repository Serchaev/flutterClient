
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/jsonSerializables/auths.dart';

import '../main.dart';
import 'Statefull/Position.dart';

class Positions extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<Auth>(context).user;
    // print("user.userRole - ${user}");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        centerTitle: true,
        title: const Text(
          "Должности"
        ),
      ),
      body: Position(context),
      floatingActionButton: user.userRole.contains("MODER") ? FloatingActionButton(
        onPressed: () async{
          final result = await Navigator.pushNamed(context, "/positionAdd");
          print("result - $result");
          if(result != null){
            Navigator.pop(context);
            Navigator.pushNamed(context, "/positions");
          }
        },
        backgroundColor: Colors.black87,
        child: const Icon(Icons.add),
      ) : null,
    );
  }

}
