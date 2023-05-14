import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../jsonSerializables/auths.dart';
import '../main.dart';

class Login extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }

}

class _LoginState extends State<Login>{
  bool _hidePass = true;
  bool _nfUser = false;
  bool _loading = false;

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<Auth>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        centerTitle: true,
        title: const Text(
          "Persons App"
        ),
      ),
      body: _loading ? const Center(
        child: CircularProgressIndicator(),
      ) : Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.only(top: 20, left: 16, bottom: 16, right: 16),
          children: [
            const Text(
              "Авторизация",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 30
              ),
            ),
            const SizedBox(height: 16,),
            // Text("he")
            TextFormField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(30),
              ],
              controller: _nameController,
              // maxLength: 30,
              decoration: const InputDecoration(
                  labelText: "Username *",
                  prefixIcon: Icon(Icons.person),
                  suffixIcon: Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  )
              ),
              validator: (val) => _validateName(val!),
            ),
            const SizedBox(height: 6,),
            TextFormField(
              controller: _passController,
              // maxLength: 30,
              obscureText: _hidePass,
              decoration: InputDecoration(
                  labelText: "Пароль *",
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(_hidePass ? Icons.visibility : Icons.visibility_off),
                    onPressed: (){
                      setState(() {
                        _hidePass = !_hidePass;
                      });
                    },
                  )
              ),
              validator: (val) => _validatePass(val!),
            ),
            const SizedBox(height: 6,),
            Text(
              _nfUser ? "*Такого пользователя нет" : "",
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12
              ),
            ),

            const SizedBox(height: 20,),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(1000, 40),
                    backgroundColor: Colors.black87
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _loading = true;
                    });
                    _formKey.currentState!.save();
                    var tmp = await _submitForm(auth);
                    if (tmp == true) {
                      setState(() {
                        _nfUser = false;
                      });
                      Navigator.pop(context);


                    } else if (tmp == "user not found") {
                      setState(() {
                        _loading = false;
                        _nfUser = true;
                      });
                    }
                  }
                  // setState(() {
                  //   _loading = false;
                  // });
                },
                child: const Text(
                    "Войти"
                )
            ),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _submitForm(Auth auth) async {
    // if (_formKey.currentState!.validate()){
    //   _formKey.currentState!.save();
    //   print("Форма валидна");
    //   print("Name: ${_nameController.text}");
    //   print("Password: ${_passController.text}");
      try{
        var authData = await login(_nameController.text, _passController.text);
        print("_submitForm auth - ${authData.accessToken}");

        bool tmp = await auth.addData(authData.accessToken, authData.refreshToken, authData.user.userId, authData.user.userRole);
        return tmp;
      } catch(e){
        print(e);
        print("ошибка внешняя");

        return "user not found";
      }
      return true;
    // }
    return false;
  }

  String? _validateName(String value){
    if (value.isEmpty){
      return "Обязательное поле";
    } else if (value.length < 3){
      return "Длина должна быть не менее 3 символов";
    } else if (value.length > 30){
      return "Длина должна быть не более 30 символов";
    }
    return null;
  }

  String? _validatePass(String value){
    if (value.isEmpty){
      return "Обязательное поле";
    } else if (value.length < 8){
      return "Длина должна быть не менее 8 символов";
    } else if (value.length > 30){
      return "Длина должна быть не более 30 символов";
    }
    return null;
  }


}