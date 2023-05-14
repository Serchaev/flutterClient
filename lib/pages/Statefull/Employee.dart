import 'package:flutter/material.dart';

import '../../jsonSerializables/employees.dart';
import '../../jsonSerializables/positions.dart';

// ignore: must_be_immutable
class Employee extends StatefulWidget{
  BuildContext context;
  Employee(this.context, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _EmployeeState();
  }

}

class _EmployeeState extends State<Employee>{
  late Future<PositionsList> positionsList;
  late Future<EmployeesList> employeesList;

  @override
  void initState(){
    super.initState();
    positionsList = getPositionsList(widget.context);
    employeesList = getEmployeesList(widget.context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PositionsList>(
      future: positionsList,
      builder: (context, snapshotPosition){
        if(snapshotPosition.hasData){
          return FutureBuilder<EmployeesList>(
            future: employeesList,
            builder: (context, snapshotEmployee){
              if(snapshotEmployee.hasData){
                return ListView.builder(
                  itemCount: snapshotEmployee.data?.employees.length,
                  itemBuilder: (context, index){
                    return InkWell(
                      onTap: () async{
                        final result = await Navigator.pushNamed(context, "/employeeItem", arguments: {
                          "id": "${snapshotEmployee.data?.employees[index].id}"
                        });
                        print("result - $result");
                        if(result != null){
                          Navigator.pop(context);
                          Navigator.pushNamed(context, "/employees");
                        }

                      },
                      child: Card(
                        child: ListTile(
                          title: Text("${snapshotEmployee.data?.employees[index].fullName}"),
                          subtitle: Text(
                              "${
                                  snapshotPosition.data?.positions.firstWhere(
                                          (element) => element.id == snapshotEmployee.data?.employees[index].positionID).name
                              }"),
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshotEmployee.hasError) {
                return const Text("Error");
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        } else if (snapshotPosition.hasError) {
          return const Text("Error");
        }
        return const Center(
          child: CircularProgressIndicator(),
        );

      },
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   // print("positionsList - $positionsList");
  //   return FutureBuilder<EmployeesList>(
  //     future: employeesList,
  //     builder: (context, snapshot) {
  //       if (snapshot.hasData){
  //         return ListView.builder(
  //           itemCount: snapshot.data?.employees.length,
  //           itemBuilder: (context, index) {
  //             return InkWell(
  //               onTap: (){
  //
  //               },
  //               child: Card(
  //                 child: ListTile(
  //                     title: Text("${snapshot.data?.employees[index].fullName}"),
  //                     subtitle: Text("${snapshot.data?.employees[index].fullName}")
  //                 ),
  //               ),
  //             );
  //           },
  //         );
  //       } else if (snapshot.hasError) {
  //         return const Text("Error");
  //       }
  //       return const Center(
  //         child: CircularProgressIndicator(),
  //       );
  //     },
  //   );
  // }
}