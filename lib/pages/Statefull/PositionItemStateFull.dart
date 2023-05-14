import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../jsonSerializables/positions.dart';
import '../../main.dart';

class PositionItemStateFull extends StatefulWidget{
  final id;
  const PositionItemStateFull(this.id, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _PositionItemState();
  }
}

class _PositionItemState extends State<PositionItemStateFull>{
  late Future<Position> position = getPosition(context, widget.id);
  bool _loading = false;

  final _formKey = GlobalKey<FormState>();

  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  final _salaryController = TextEditingController();


  String _id = "";
  String _name = "";
  String _salary = "";

  @override
  void initState(){
    super.initState();

    // position = getPosition(context, widget.id);
    // getPosition(context, widget.id).then((value) => {
    //   print("then value - $value")
    // });
  }

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<Auth>(context);
    var user = Provider.of<Auth>(context).user;
    return FutureBuilder(
      future: position,
      builder: (context, snapshot){
        // print(snapshot.data);
      if (snapshot.hasData){
        _id = snapshot.data!.id;
        _nameController.text = snapshot.data!.name;
        _salaryController.text = "${snapshot.data!.salary}";
        return user.userRole.contains("MODER") ?
          Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.only(top: 20, left: 16, bottom: 16, right: 16),
              children: [
                const Text(
                  "Редактирование",
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
                  initialValue: "${snapshot.data?.name}",
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
                  initialValue: "${snapshot.data?.salary}",
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
                        print("id - $_id, name - $_name, salary - $_salary");
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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(1000, 40),
                      backgroundColor: Colors.red
                  ),
                  onPressed: () async {
                    var tmp = await _submitForm2(auth);
                    if(tmp == true){
                      bool tmp = true;
                      Navigator.pop(context, tmp);
                    }
                    // Navigator.pop(context);

                  },
                  child: const Text(
                      "Удалить"
                  ),
                ),
              ],
            ),
          ) :
          Container(
            padding: const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text("${snapshot.data?.id}"),
                Text(
                  "Должность: ${snapshot.data?.name}",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700
                  ),
                ),
                const SizedBox(height: 10,),
                Text(
                  "Зарплата: ${snapshot.data?.salary}₽",
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400
                  ),
                )
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
      int tmpSalary = int.parse(_salary);
      Position positionData = await updatePosition(auth, _id, _name, tmpSalary);
      return true;
      // authData
    }catch(e){
      return false;
    }
  }

  Future<dynamic> _submitForm2(Auth auth) async {
    if (_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      print("Форма валидна");
      print("Name: ${_nameController.text}");
      print("Salary: ${_salaryController.text}");
      Position positionData = await deletePosition(auth, _id);
      return true;
    }
    return false;
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