import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/jsonSerializables/auths.dart';

import '../main.dart';

class Registration extends StatefulWidget{
  const Registration({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RegistrationState();
  }

}

class _RegistrationState extends State<Registration>{
  bool _hidePass = true;
  bool _regError = false;
  bool _loading = false;

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _mailController = TextEditingController();
  final _passController = TextEditingController();
  final _passConfirmController = TextEditingController();

  @override
  void dispose(){
    _nameController.dispose();
    _mailController.dispose();
    _passController.dispose();
    _passConfirmController.dispose();
    super.dispose();
  }

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
              "Регистрация",
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
              inputFormatters: [
                LengthLimitingTextInputFormatter(70),
              ],
              controller: _mailController,
              // maxLength: 70,
              decoration: const InputDecoration(
                labelText: "Почта *",
                prefixIcon: Icon(Icons.mail),
                suffixIcon: Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                )
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (val) => _validateEmail(val!),
            ),
            const SizedBox(height: 6,),
            TextFormField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(30),
              ],
              controller: _passController,
              // maxLength: 30,
              obscureText: _hidePass,
              decoration: InputDecoration(
                labelText: "Пароль *",
                prefixIcon: Icon(Icons.lock),
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
            TextFormField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(30),
              ],
              controller: _passConfirmController,
              // maxLength: 30,
              obscureText: _hidePass,
              decoration: const InputDecoration(
                labelText: "Повторите пароль *",
                prefixIcon: Icon(Icons.lock),
              ),
              validator: (val) => _validatePass(val!),
            ),
            const SizedBox(height: 20,),
            Text(
              _regError ? "*Ошибка регистрации" : "",
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(1000, 40),
                  backgroundColor: Colors.black87
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()){
                  _formKey.currentState!.save();
                  setState(() {
                    _loading = true;
                  });
                  var tmp = await _submitForm(auth);
                  if(tmp == true){
                    setState(() {
                      _regError = false;
                    });
                    Navigator.pop(context);
                  } else if (tmp == "registration error"){
                    setState(() {
                      _loading = false;
                      _regError = true;
                    });
                  }
                }
              },
              child: const Text(
                "Зарегистрироваться"
              )
            ),
            const SizedBox(height: 20,),
          ],
        ),
      )
    );
  }

  Future<dynamic> _submitForm(Auth auth) async{
    if (_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      print("Форма валидна");
      print("Name: ${_nameController.text}");
      print("Email: ${_mailController.text}");
      print("Password: ${_passController.text}");
      print("Confirm Password: ${_passConfirmController.text}");
      try{
        var authData = await registration(_nameController.text, _mailController.text, _passController.text);
        bool tmp = await auth.addData(authData.accessToken, authData.refreshToken, authData.user.userId, authData.user.userRole);

        return tmp;
      }catch(e){

        return "registration error";
      }
    }
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

  String? _validateEmail(String value){
    if (value.isEmpty){
      return "Обязательное поле";
    } else if (value.length < 3){
      return "Длина должна быть не менее 3 символов";
    } else if (value.length > 70){
      return "Длина должна быть не более 70 символов";
    } else if (!value.contains("@")){
      return "Почта введена неверно";
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
    } else if (_passController.text != _passConfirmController.text){
      return "Пароли не совпадают";
    }
    return null;
  }

}