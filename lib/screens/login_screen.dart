import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  //cerebro de la logica de animaciones
  StateMachineController? controller;

  //State Machine Input
  SMIBool? isChecking; //Activa  al oso chismoso
  SMIBool? isHandsUp; //Activa al oso tapndose los ojos
  SMITrigger? trigSuccess; //se emociona 
  SMITrigger? trigFail; //Se pone muy sad 
  SMINumber? numLook;



 bool _isHidden = true;
  @override
  Widget build(BuildContext context) {
    //para obtener el tamaño de pantalla del dispositivo
    final Size size = MediaQuery.of(context).size;

    
    return Scaffold(  //Scaffold significa en espaol andamio
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),  
          child: Column(
            //axis o eje principal
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                //ancho de la pantalla calulado por mediaquery
                width: size.width,
                height: 200,
                child: RiveAnimation.asset(
                  'animated_login_character.riv',
                  stateMachines:  ["Login Machine"],
                  onInit: (artboard) {
                    controller = StateMachineController.fromArtboard(
                      artboard, 
                      "Login Machine",
                      
                      );
                      //Verifica si hay un controlador
                    if(controller == null) return;
                    //Agrega el controlador al tablero
                    artboard.addController(controller!); 
                    //enlaza la animacion con la app

                    isChecking = controller!.findSMI("isChecking");
                    isHandsUp = controller!.findSMI("isHandsUp");
                    trigSuccess = controller!.findSMI("trigSuccess");
                    trigFail = controller!.findSMI("trigFail");
                    numLook = controller!.findSMI("numLook");
                    
                  },
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  onChanged: (value) {
                    if (numLook != null){
                      //Mueve los ojos del oso
                      numLook!.change(value.length.toDouble());
                    }
                      
                    if (isHandsUp != null){
                      //No subir las manos al subir email
                      isHandsUp!.change(false);
                    }
                    //verifica que este SMI no sea nulo
                    if(isChecking == null)return;
                      isChecking!.change(true);

                      
                  
                    
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Email",//hintText que significa texto de sugerencia
                    prefixIcon: const Icon(Icons.mail), //lo primero que se ve en tu pantalla de donde escribes
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    )
                    
                  ),
                  
                ),
                SizedBox(height: 10),
                TextField(
                  onChanged: (value) {
                    if (isChecking != null){
                      //No mover ojos al escribir password
                      isChecking!.change(false);
                    }
                    //verifica que este SMI no sea nulo
                    if(isHandsUp == null)return;
                      isHandsUp!.change(true);
                    
                  },
                  //para que no se vea la contraseña
                  obscureText: _isHidden,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: GestureDetector(
                      onTap: _togglePasswordView,
                child: Icon(
                   _isHidden ? Icons.visibility : Icons.visibility_off,
                ),
                    ),//hintText que significa texto de sugerencia
                    prefixIcon: const Icon(Icons.lock), //lo primero que se ve en tu pantalla de donde escribes
                    
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    )
                    
                  ),
                  
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: size.width,
                  child: const Text(
                    "¿neta olvidaste tu contraseña?",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      decoration: TextDecoration.underline
                    ),
                  ),
                ),
                //bton de login
                SizedBox(height: 10),
                
                MaterialButton(
                  minWidth: size.width,
                  height: 50,
                  color: Colors.blue,
                  //form del boton
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                    
                  onPressed: (){},
                  child: const Text(
                    "Login",
                    style: TextStyle(color:Colors.white),
                    
                  ),
                ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: size.width,
                    child: Row(
                      //centrar el texto
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: (){},
                           child: const Text(
                            "Sign up",
                            style: TextStyle(
                              color: Colors.black,
                              //Propiedad para poner en negritas por que fontWeight significa en español peso de la fuente
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline),
                            ),
                        )

                           

                      ],
                    ),
                  )
                
            ],
          ),
        )),
    );  
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}


