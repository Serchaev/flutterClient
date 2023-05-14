import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../jsonSerializables/positions.dart';
import '../../main.dart';

// ignore: must_be_immutable
class Position extends StatefulWidget{
  // String access;
  // var getRefresh;
  BuildContext context;
  Position(this.context, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _PositionState();
  }
}

class _PositionState extends State<Position>{
  late Future<PositionsList> positionsList;
  bool load = false;

  @override
  void initState(){
    super.initState();
    // print("access = ${Provider.of<Auth>(context).accessToken}");

    positionsList = getPositionsList(widget.context);

    // print("positionsList - ${positionsList.then((value) => null)}");
    // positionsList.then((value) => {
    //   if (value == "Instance of 'PositionsList'") {
    //     print("reload access and refresh")
    //   }
    // });
    // positionsList
    // print("$positionsList");
    // if()
  }

  @override
  Widget build(BuildContext context) {
    // String access = Provider.of<Auth>(context).accessToken;
    // positionsList = getPositionsList(widget.context);
    return FutureBuilder<PositionsList>(
      future: positionsList,
      builder: (context, snapshot) {
        if (snapshot.hasData){
          // snapshot.data?.positions[0].name = "hi";
          return ListView.builder(
            itemCount: snapshot.data?.positions.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async{
                  final result = await Navigator.pushNamed(context, "/positionItem", arguments: {
                    "id": "${snapshot.data?.positions[index].id}"
                  });
                  print("result - $result");
                  if(result != null){
                    Navigator.pop(context);
                    Navigator.pushNamed(context, "/positions");
                  }
                },
                child: Card(
                  child: ListTile(
                    title: Text("${snapshot.data?.positions[index].name}"),
                    subtitle: Text("${snapshot.data?.positions[index].salary}₽"),
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return const Text("Error");
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}