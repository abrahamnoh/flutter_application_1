import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'dart:async';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  //cerebro de la logica de animaciones
  StateMachineController? controller;

  String User="",Password="";

  //State Machine Input
  SMIBool? isChecking; //Activa  al oso chismoso
  SMIBool? isHandsUp; //Activa al oso tapndose los ojos
  SMITrigger? trigSuccess; //se emociona 
  SMITrigger? trigFail; //Se pone muy sad 
  SMINumber? numLook;

  // FocusNodes para controlar el foco de los campos
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  
  // Timer para el debounce del typing
  Timer? _typingTimer;

  // COntroladores de texto para obtener valores, esto es para el usario y contraseña correctas


  bool _isHidden = true;

  @override
  void initState() {
    super.initState();
    
    // Listeners para los FocusNodes
    _emailFocusNode.addListener(_onEmailFocusChange);
    _passwordFocusNode.addListener(_onPasswordFocusChange);
  }

  @override
  void dispose() {
    // Limpiar recursos
    _emailFocusNode.removeListener(_onEmailFocusChange);
    _passwordFocusNode.removeListener(_onPasswordFocusChange);
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _typingTimer?.cancel();
    super.dispose();
  }

  void _onEmailFocusChange() {
    if (_emailFocusNode.hasFocus) {
      // Cuando se selecciona el campo de email
      if (isHandsUp != null) {
        isHandsUp!.change(false); // Quitar las manos de los ojos
      }
      if (isChecking != null) {
        isChecking!.change(true); // El oso empieza a mirar
      }
    } else {
      // Cuando pierde el foco del email
      if (isChecking != null) {
        isChecking!.change(false); // El oso deja de mirar
      }
    }
  }

  void _onPasswordFocusChange() {
    if (_passwordFocusNode.hasFocus) {
      // Cuando se selecciona el campo de password
      if (isChecking != null) {
        isChecking!.change(false); // El oso deja de mirar
      }
      if (isHandsUp != null) {
        isHandsUp!.change(true); // El oso se tapa los ojos
      }
    } else {
      // Cuando pierde el foco del password
      if (isHandsUp != null) {
        isHandsUp!.change(false); // El oso quita las manos
      }
    }
  }

  void _onEmailTyping(String value) {
    // Cancelar el timer anterior si existe
    _typingTimer?.cancel();
    
    // Solo si el campo de email tiene foco
    if (_emailFocusNode.hasFocus) {
      if (numLook != null) {
        // Mueve los ojos del oso según la longitud del texto
        numLook!.change(value.length.toDouble());
      }
      
      if (isChecking != null) {
        isChecking!.change(true); // El oso mira mientras escribe
      }
      User=value;
      
      // Configurar timer para detectar cuando para de escribir
      _typingTimer = Timer(const Duration(milliseconds: 1500), () {
        // Después de 1 segundo sin escribir, el oso deja de mirar intensamente
        if (isChecking != null && _emailFocusNode.hasFocus) {
          // Mantiene una mirada más suave si aún tiene foco
          isChecking!.change(false);
          if (numLook != null) {
            numLook!.change(0); // Vuelve a la posición neutral
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //para obtener el tamaño de pantalla del dispositivo
    final Size size = MediaQuery.of(context).size;

    return Scaffold(  //Scaffold significa en español andamio
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),  
          child: Column(
            //axis o eje principal
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                //ancho de la pantalla calculado por mediaquery
                width: size.width,
                height: 200,
                child: RiveAnimation.asset(
                  'animated_login_character.riv',
                  stateMachines: ["Login Machine"],
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
              const SizedBox(height: 10),
              TextField(
                focusNode: _emailFocusNode, // Asignar el FocusNode
                onChanged: _onEmailTyping,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Email", //hintText que significa texto de sugerencia
                  prefixIcon: const Icon(Icons.mail), //lo primero que se ve en tu pantalla de donde escribes
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  )
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                focusNode: _passwordFocusNode, // Asignar el FocusNode
                onChanged: (value) {
                  Password=value;
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
                  ), //hintText que significa texto de sugerencia
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
              //botón de login
              const SizedBox(height: 10),
              
              MaterialButton(
                minWidth: size.width,
                height: 50,
                color: Colors.blue,
                //form del boton
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                onPressed: () {
                  if(User=="test" && Password=="1234"){
                    if(trigSuccess != null){
                      trigSuccess!.fire();
                    }
                  } else {
                    if(trigFail != null){
                      trigFail!.fire();
                    }
                  }
                  // Aquí puedes agregar la lógica de login
                  // y usar trigSuccess o trigFail según el resultado
                },
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
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
                          decoration: TextDecoration.underline
                        ), 
                      )
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ),
    );  
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }



}