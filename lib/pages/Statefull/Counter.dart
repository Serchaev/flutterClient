import 'package:flutter/material.dart';


class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CounterState();
  }
}

class _CounterState extends State<Counter>{
  late int count;

  @override
  void initState(){
    count = 99;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
              onPressed: (){
                setState(() {
                  count -= 1;
                });
              },
              icon: const Icon(
                Icons.remove,
                color: Colors.red,
                size: 36,
              )
          ),
          Text(
            "$count",
            style: const TextStyle(
                fontSize: 28
            ),
          ),
          IconButton(
              onPressed: (){
                setState(() {
                  count += 1;
                });
              },
              icon: const Icon(
                Icons.add,
                color: Colors.green,
                size: 36,
              )
          ),
        ],
      ),
    );
  }

  void _updateProgress(){

  }
}