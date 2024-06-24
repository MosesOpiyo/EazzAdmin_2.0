import 'package:eazz_admin/Pages/Authentication/widgets/login_button.dart';
import 'package:eazz_admin/Pages/Homepage/homepage.dart';
import 'package:eazz_admin/Service/Authentication/authentication_services.dart';
import 'package:eazz_admin/Service/AuthenticationTokens/auth_token.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:page_transition/page_transition.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool isSignIn = true;
  bool inCorrectCredetials = false;
  bool hidePassword = true;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  toggleSwitch() {
    setState(() {
      isSignIn = !isSignIn;
    });
  }

  void toggle() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              Center(
                child: SizedBox(
                  child: Image.asset(
                    'assets/Eazz.png',
                    height: 120,
                  ),
                ),
              ),
              const SizedBox(
                child: Text(
                  "Welcome Back",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              const SizedBox(
                child: Text(
                  "Login To your Account",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 60,
                child: Center(
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 60,
                child: TextFormField(
                  controller: passwordController,
                  obscureText: hidePassword,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      onPressed: toggle,
                      icon: Icon(hidePassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Forgot Password",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.deepOrange),
                    ),
                  ),
                ),
              ),
              SizedBox(
                  height: 60,
                  width: size.width * .9,
                  child: LoginButton(onPressed: login)),
            ],
          ),
        ),
      ),
    );
  }

  login() async {
    String email = emailController.text;
    String password = passwordController.text;
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      APIService()
          .login(email, password)
          .then((response) async => {
                if (response.accessToken != null)
                  {
                    AuthClass().storeToken(response.accessToken),
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: const HomePage(),
                      ),
                    )
                  }
                else if (response.accessToken == null)
                  {
                    setState(() {
                      inCorrectCredetials = true;
                    }),
                    showCustomSnackbar(context, response.message.toString())
                  }
              })
          .onError((error, stackTrace) => {if (error != "") {}});
      // if (email.isNotEmpty && password.isNotEmpty) {

      // }
    }
  }

  void showCustomSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.red,
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      action: SnackBarAction(
        textColor: Colors.white,
        label: "OK",
        onPressed: () {},
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
