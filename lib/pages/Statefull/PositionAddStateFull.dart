import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../jsonSerializables/positions.dart';
import '../../main.dart';

class PositionAddStateFull extends StatefulWidget{
  BuildContext context;
  PositionAddStateFull(this.context, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _PositionAddState();
  }

}

class _PositionAddState extends State<PositionAddStateFull>{
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  String _id = "";
  String _name = "";
  String _salary = "";
  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<Auth>(context);
    var user = Provider.of<Auth>(context).user;
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
              _name = value!;
            },
            // inputFormatters: [
            //   LengthLimitingTextInputFormatter(30),
            // ],
            // controller: _nameController,
            // maxLength: 30,
            decoration: const InputDecoration(
                labelText: "Должность *",
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
              _salary = value!;
            },
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            // controller: _salaryController,
            // maxLength: 30,
            decoration: const InputDecoration(
                labelText: "Зарплата *",
                prefixIcon: Icon(Icons.attach_money),
                // suffixIcon: Icon(
                //   Icons.delete_outline,
                //   color: Colors.red,
                // )
            ),
            validator: (val) => _validateSalary(val!),
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
                var tmp = await _submitForm(auth);
                if(tmp == true){
                  bool tmp = true;
                  Navigator.pop(context, tmp);
                }
              }

            },
            child: const Text(
                "Добавить"
            ),
          ),
          // const SizedBox(height: 6,),
        ],
      ),
    );
  }

  Future<dynamic> _submitForm(Auth auth) async {
    try{
      int tmpSalary = int.parse(_salary);
      Position positionData = await createPosition(auth, _name, tmpSalary);
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

  String? _validateSalary(String value){
    if (value.isEmpty){
      return "Обязательное поле";
    }
    return null;
  }
}