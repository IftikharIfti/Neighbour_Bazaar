import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:neighbour_bazaar/auth_controller.dart';
import 'package:neighbour_bazaar/login_page.dart';
import 'package:neighbour_bazaar/signupcontroller.dart';
import 'package:neighbour_bazaar/user_repository.dart';

import 'User-Model.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller=Get.put(SignUpController());
    // final _formkey=GlobalKey<FormState>();
    var emailController=TextEditingController();
    var passwordController=TextEditingController();
    var usernameController=TextEditingController();
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return  Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
     // key: _formkey,
      body: SingleChildScrollView(
      child:Column(children: [
        Container(
          width: w,
          height: h * 0.3,
          decoration:  BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("img/signup1.png"), fit: BoxFit.cover)
          ),
        // child: Column(
        //   children: [
        //     SizedBox(height: h*0.16,),
        //     CircleAvatar(
        //       radius: 60,
        //       backgroundImage: AssetImage(
        //         "img/signupicon.png"
        //       ),
        //     )
        //   ],
        // ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20,right: 20),
          width: w,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                // Text("Welcome",
                //   style: TextStyle(fontSize: 50,
                //       fontWeight: FontWeight.bold),),
                // Text("Sign Into your account",
                //   style: TextStyle(fontSize: 20,
                //       color:Colors.grey[500]),),
                SizedBox(height: 50,),
                // To give padding between different parts.
                Container(
                    child:TextField(
                     // controller: controller.username,
                      controller: usernameController,
                      decoration: InputDecoration(
                          hintText: "Username",
                          prefixIcon:Icon(Icons.man,color: Colors.blueGrey,) ,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          )
                      ),
                    )
                ),
                SizedBox(height: 20,),
                Container(
                    child:TextField(
                     // controller: controller.email,
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
                     // controller: controller.password,
                      controller: passwordController,
                      decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon:Icon(Icons.key,color: Colors.blueGrey,) ,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          )
                      ),
                    )
                ),
                SizedBox(height: 20,),
                // Row(children: [
                //   Expanded(child: Container(),),
                //   Text("Forgot Your Password?",
                //     style: TextStyle(fontSize: 20,
                //         color:Colors.grey[500]),),
                // ],)


              ]),
        ),
        SizedBox(height: 50,),
        GestureDetector(
          onTap: ()
            {
            //  if(_formkey.currentState!.validate())
              //  {
                  AuthController.instance.register(usernameController.text.trim(),emailController.text.trim(), passwordController.text.trim());
                  // final user=UserModel(username: usernameController.text.trim(), email: emailController.text.trim(), password: passwordController.text.trim());
                  // UserRepository.instance.createUser(user);
                //}
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
                child: Text("Sign Up",
                  style: TextStyle(fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),

                ),
              )
          ),
        ),
        SizedBox(height: w*0.08,),
        RichText(text: TextSpan(
            text:"Already have an account? ",
            style:TextStyle(
                color:Colors.grey[500],
                fontSize: 20
            ),
            children: [
              TextSpan(
                  text:"LogIn",
                  style:TextStyle(
                      color:Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                  recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>LoginPage())
              )
            ]
        )
        )
      ]),
      ),
    );
  }
}
