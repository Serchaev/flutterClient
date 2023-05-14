
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../jsonSerializables/employees.dart';
import '../../jsonSerializables/positions.dart';
import '../../main.dart';

class EmployeeAddStateFull extends StatefulWidget{
  BuildContext context;
  EmployeeAddStateFull(this.context, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _EmployeeAddState();
  }

}

class _EmployeeAddState extends State<EmployeeAddStateFull>{
  late Future<PositionsList> positionsList = getPositionsList(context);
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  String _id = "";
  String _fullName = "";
  String _phone = "";
  String _address = "";
  String _positionID = "";
  String _selectedPosition = "";
  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<Auth>(context);
    var user = Provider.of<Auth>(context).user;

    return FutureBuilder<PositionsList>(
      future: positionsList,
      builder: (context, snapshot){
        if(snapshot.hasData){
          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.only(top: 20, left: 16, bottom: 16, right: 16),
              children: [
                const Text(
                  "Добавление",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30
                  ),
                ),
                const SizedBox(height: 16,),
                TextFormField(
                  onSaved: (value) {
                    _fullName = value!;
                  },
                  // inputFormatters: [
                  //   LengthLimitingTextInputFormatter(30),
                  // ],
                  // controller: _nameController,
                  // maxLength: 30,
                  // initialValue: "${snapshotEmployee.data?.fullName}",
                  decoration: const InputDecoration(
                      labelText: "ФИО *",
                      prefixIcon: Icon(Icons.person),
                      // suffixIcon: Icon(
                      //   Icons.delete_outline,
                      //   color: Colors.red,
                      // )
                  ),
                  validator: (val) => _validateName(val!),
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  onSaved: (value) {
                    _phone = value!;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  // controller: _salaryController,
                  // maxLength: 30,
                  // initialValue: "${snapshotEmployee.data?.phone}",
                  decoration: const InputDecoration(
                      labelText: "Номер телефона *",
                      prefixIcon: Icon(Icons.phone),
                      // suffixIcon: Icon(
                      //   Icons.delete_outline,
                      //   color: Colors.red,
                      // )
                  ),
                  validator: (val) => _validatePhone(val!),
                ),
                TextFormField(
                  onSaved: (value) {
                    _address = value!;
                  },
                  // inputFormatters: [
                  //   LengthLimitingTextInputFormatter(30),
                  // ],
                  // controller: _salaryController,
                  // maxLength: 30,
                  // initialValue: "${snapshotEmployee.data?.address}",
                  decoration: const InputDecoration(
                      labelText: "Адрес *",
                      prefixIcon: Icon(Icons.location_on),
                      // suffixIcon: Icon(
                      //   Icons.delete_outline,
                      //   color: Colors.red,
                      // )
                  ),
                  validator: (val) => _validateAddress(val!),
                ),
                // const SizedBox(height: 20,),
                DropdownButtonFormField(
                  onSaved: (value){
                    // _selectedPosition = value!;
                  },
                  decoration: const InputDecoration(
                      labelText: "Должность *",
                      prefixIcon: Icon(
                        Icons.work,
                        color: Colors.grey,
                      )
                  ),
                  items: snapshot.data!.positions.map((e) {
                    return DropdownMenuItem(
                      value: e.id,
                      child: Text(e.name),
                    );
                  }).toList(),
                  onChanged: (data){
                    print(data);
                    setState(() {
                      _selectedPosition = data!;
                      // _positionID = data!;
                    });
                  },
                  validator: (val) {
                    return val == null ? "Обязательное поле" : null;
                  },
                  // value: "Директор",
                  // value: snapshotPosition.data!.positions.firstWhere((element) => element.id==snapshotEmployee.data!.positionID).id,
                ),
                const SizedBox(height: 20,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(1000, 40),
                      backgroundColor: Colors.black87
                  ),
                  onPressed: () async {
                    setState(() {
                      _loading = true;
                    });
                    if (_formKey.currentState!.validate()){
                      _formKey.currentState!.save();
                      print("id - $_id, fullName - $_fullName, phone - $_phone, address - $_address, positionID - $_positionID, selectedPosition - $_selectedPosition");
                      var tmp = await _submitForm(auth);
                      if(tmp == true){
                        bool tmp = true;
                        Navigator.pop(context, tmp);
                      }
                    }
                  },
                  child: const Text(
                      "Сохранить"
                  ),
                ),
                // const SizedBox(height: 6,),
              ],
            ),
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

  Future<dynamic> _submitForm(Auth auth) async {
    try{
      int tmpPhone = int.parse(_phone);
      Employee positionData = await createEmployee(auth, _fullName, tmpPhone, _address, _selectedPosition);
      return true;
      // authData
    }catch(e){
      return false;
    }
  }

  Future<dynamic> _submitForm2(Auth auth) async {
    // if (_formKey.currentState!.validate()){
    //   _formKey.currentState!.save();
    //   print("Форма валидна");
    //   print("Name: ${_nameController.text}");
    //   print("Salary: ${_salaryController.text}");
    //   Position positionData = await deletePosition(auth, _id);
    //   return true;
    // }
    // return false;
  }

  String? _validateName(String value){
    if (value.isEmpty){
      return "Обязательное поле";
    }
    return null;
  }

  String? _validatePhone(String value){
    if (value.isEmpty){
      return "Обязательное поле";
    }
    return null;
  }

  String? _validateAddress(String value){
    if (value.isEmpty){
      return "Обязательное поле";
    }
    return null;
  }

  String? _validateSelectedPosition(String value){
    if (value.isEmpty){
      return "Обязательное поле";
    }
    return null;
  }
}