import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jey_inventory_mobile/src/controllers/login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  final loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jey Inventory'),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
          height: 550,
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 500
              ),
              child: Form(
                key: loginController.formKey,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Sign In', style: TextStyle(fontSize: 25 )),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Row(
                            children: [
                              Text("Don't have an account? "),
                              InkWell(
                                child: Text('Sign Up'),
                                onTap: (){},
                              )
                            ],
                          ),
                        ),
                      ]
                    ),
                    Divider(height: 50),
                    Row(
                      children: [Text('Username', style: TextStyle(fontSize: 20),)],
                    ),
                    TextFormField(
                      // The validator receives the text that the user has entered.
                      validator: loginController.validator,
                      controller: loginController.usernameController,
                    ),
                    Divider(height: 50),
                    Row(
                      children: [Text('Password', style: TextStyle(fontSize: 20),)],
                    ),
                    TextFormField(
                      validator: loginController.validator,
                      obscureText: true,
                      controller: loginController.passwordController,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          // Validate returns true if the form is valid, or false otherwise.
                          if(loginController.formKey.currentState!.validate()){
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Signing in'))
                            );
                            var result = await loginController.login();
                            bool loggedIn = result["success"];
                            if(!loggedIn){
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(result['error']))
                              );
                            }else{
                              Get.offNamed('/home');

                            }
                          }
                        },
                        child: const Text('Sign In'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
