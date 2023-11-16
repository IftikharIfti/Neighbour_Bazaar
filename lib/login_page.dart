import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:neighbour_bazaar/User-Model.dart';
import 'package:neighbour_bazaar/signup_page.dart';

import 'auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    var emailController=TextEditingController();
    var passwordController=TextEditingController();
    var usernameController=TextEditingController();
    double w = MediaQuery.of(context)
        .size
        .width; //MediaQuery class provides information about the current application's context, including details about the device's screen size, orientation, and more.
    double h = MediaQuery.of(context).size.height;
    //these lines of code allow you to access the screen dimensions dynamically,
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
      child:Column(children: [
        Container(
          width: w,
          height: h * 0.3,
          decoration:  BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("img/loginimg.png"), fit: BoxFit.cover)),
          /*
                  The Container is set to a specific width and a height that's a
                  percentage of the screen's height. It also has a background image,
                   and the Scaffold is typically used to create structured screens with
                   various components like app bars, drawers, and body content.
                  */
        ),
        Container(
          margin: const EdgeInsets.only(left: 20,right: 20),
          width: w,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text("Welcome",
                  style: TextStyle(fontSize: 50,
                      fontWeight: FontWeight.bold),),
                Text("Sign Into your account",
                  style: TextStyle(fontSize: 20,
                      color:Colors.grey[500]),),
                SizedBox(height: 20,),
                Container(
                    child:TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          hintText: "Your Email ID",
                          prefixIcon:Icon(Icons.email,color: Colors.blueGrey,) ,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          )
                      ),
                    )
                ),
                SizedBox(height: 20,),
                Container(
                    child:TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon:Icon(Icons.key,color: Colors.blueGrey,) ,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          )
                      ),
                      obscureText: true,
                    )
                ),

                SizedBox(height: 20,),
                Row(children: [
                  Expanded(child: Container(),),
                  Text("Forgot Your Password?",
                    style: TextStyle(fontSize: 20,
                        color:Colors.grey[500]),),
                ],)


              ]),
        ),
        SizedBox(height: 30,),
        GestureDetector(
          onTap: ()
          {
            AuthController.instance.login(emailController.text.trim(), passwordController.text.trim());
          },
          child: Container(
            width: w*0.5,
            height: h * 0.08,
            decoration:  BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                    image: AssetImage("img/loginbtn.png"), fit: BoxFit.cover)
            ),
            child: Center(
              child: Text("Sign In",
                style: TextStyle(fontSize: 26,
                    fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),

              ),
            )
          ),
        ),
        SizedBox(height: w*0.008,),
        RichText(text: TextSpan(
          text:"Don\'t have an account? ",
          style:TextStyle(
            color:Colors.grey[500],
            fontSize: 20
          ),
          children: [
            TextSpan(
            text:"Create",
            style:TextStyle(
                color:Colors.black,
                fontSize: 20,
              fontWeight: FontWeight.bold
            ),
              recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage())
            )
          ]
        )
        )
      ]),
      ),
    );
  }
}
