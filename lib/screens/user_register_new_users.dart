import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simo_v_7_0_1/modals/admin_login_response_model.dart';
import 'package:simo_v_7_0_1/providers/provider_one.dart';
import 'package:simo_v_7_0_1/screens/login_screen.dart';
import 'package:simo_v_7_0_1/screens/user-cataloge.dart';


import 'admin_dash_board.dart';



class RegisterNewUsers extends StatefulWidget {
  static const String id = '/registerNewusers';

  @override
  State<RegisterNewUsers> createState() => _RegisterNewUsersState();
}

class _RegisterNewUsersState extends State<RegisterNewUsers> {

  //notification alert widget
  void showstuff(context, String mynotification) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Notification'),
            content: Text(mynotification),
            actions: [
              ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    // Navigator.of(context).pushNamedAndRemoveUntil(DisplayProductsToBeEdited.id, (Route<dynamic> route) => false);
                    // context.read<ProviderTwo>().initialValues();
                    // await context.read<ProviderTwo>().bringproductos();
                  },
                  child: Text('Ok'))
            ],
          );
        });
  }
  TextEditingController _nameController = TextEditingController();

  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  TextEditingController _confirmPasswordController = TextEditingController();

  final _formKeyForRegisterNewAdminsAndusers = GlobalKey<FormState>();

  bool isLoading=false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderOne>(context);
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            SizedBox(height: 60,),
              Form(
              key:_formKeyForRegisterNewAdminsAndusers,
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    SizedBox(height:10,),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        height: 100.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/hbtkLogo.png"),
                            fit: BoxFit.cover,),),),),

                    Text('Crear una cuenta nueva', style: TextStyle(fontSize: 16,
                        fontWeight: FontWeight.bold, color: Colors.blueGrey),),
                    SizedBox(height: 8,),
                  TextFormField(
                    keyboardType: TextInputType.name, textInputAction: TextInputAction.done,
                    controller: _nameController,
                    validator: (value) {if (value == null || value.trim().isEmpty) {return 'Este campo es obligatorio';}
                    else {return null;}},
                    decoration: InputDecoration(hintText: 'Nombre completo', label: Text('Nombre completo',
                      style: TextStyle(fontSize: 20, color: Colors.blue),),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),),),
                  SizedBox(height: 14,),
                  TextFormField(
                    keyboardType: TextInputType.name, textInputAction: TextInputAction.done,
                    controller: _emailController,
                    validator: (value) {if (value == null || value.trim().isEmpty) {return 'Este campo es obligatorio';}
                    else if (value.isEmpty || !value.contains('@')) {return "Entrada invalida.Ex:example@example.com";}
                    else {return null;}},
                    decoration: InputDecoration(hintText: 'Email', label: Text('Email',
                      style: TextStyle(fontSize: 20, color: Colors.blue),),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),),),
                  SizedBox(height: 14,),
                  TextFormField(
                    obscureText: true,
                    keyboardType: TextInputType.text, textInputAction: TextInputAction.done,
                    controller: _passwordController,
                    validator: (value) {if (value == null || value.trim().isEmpty) {return 'Este campo es obligatorio';}
                    else {return null;}},
                    decoration: InputDecoration(hintText: 'Contrasena', label: Text('Contrasena',
                      style: TextStyle(fontSize: 20, color: Colors.blue),),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),),),
                  SizedBox(height: 14,),
                  TextFormField(
                    obscureText: true,
                    keyboardType: TextInputType.text, textInputAction: TextInputAction.done,
                    controller: _confirmPasswordController,
                    validator: (value) {if (value == null || value.trim().isEmpty) {return 'Este campo es obligatorio';}
                     else if (_confirmPasswordController.text!=_passwordController.text){ return 'contraseña y confirmación no coinciden'; }
                    else {return null;}},
                    decoration: InputDecoration(hintText: 'Confirmar la contraseña', label: Text('Confirmar la contraseña',
                      style: TextStyle(fontSize: 20, color: Colors.blue),),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),),),
                  SizedBox(height: 14,),


                    OutlinedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(40.0),
                          shape: StadiumBorder()),
                      child: isLoading==true? CircularProgressIndicator():Text('Enviar ',
                          style: TextStyle(fontSize: 16)),

                          onPressed:() async{
                            if (_formKeyForRegisterNewAdminsAndusers.currentState!.validate()) {
                              setState(() {isLoading=true;});

                              LoginResponseDataModel userLoginResponse = LoginResponseDataModel();
                              userLoginResponse = await ProviderOne().registerForUsers(_nameController.text,
                                  _emailController.text, _passwordController.text);
                              await provider.addTableToSPA('user');
                              await provider.addTokenToSPA(userLoginResponse.token);
                              await provider.addUserIdToSPA(userLoginResponse.id);
                              await provider.addUserNameToSPA(userLoginResponse.name);
                              await provider.addUserEmailToSPA(userLoginResponse.email);
                              Navigator.pushNamed(context, UserCatalogue.id);
                              showstuff(context, ' Hola ${userLoginResponse.name} , creaste una cuenta nueva ' );
                              setState(() {isLoading=false;});
                            }},
                    ),
                        SizedBox(height: 10,),
                    OutlinedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(40.0),
                          shape: StadiumBorder()),
                      child: Text('Ingresar a tu cuenta ', style: TextStyle(fontSize: 16 ,),),
                    onPressed:() async{Navigator.pushNamed(context, LoginScreen.id);},
                    ),
                ],
                    )),

            ],
          ),
        ),
      ),
    );
  }
}

