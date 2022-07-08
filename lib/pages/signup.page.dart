import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:devrnz/bloc/regBloc/reg_bloc.dart';
import 'package:devrnz/pages/login.page.dart';
import 'package:page_transition/page_transition.dart';
import '../bloc/authBloc/auth_bloc.dart';
import '../utils/bezierContainer.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);


  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  late RegisterBloc registerBloc;
  late AuthBloc authBloc;
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  late String name = "";
  late String email = "";
  late String password = "";
  late bool notVisible = true;
  String error = '';
  final _formKey = GlobalKey<FormState>();

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: const Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            const Text('Back', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _nameField() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            "Full Name",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
              onChanged: (value){
                setState(() {
                    name = value;
                });
              },
              controller: nameTextEditingController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a fullname';
                }
                return null;
              },
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _emailField() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            "Email",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
              onChanged: (value){
                setState(() {
                    email = value;
                });
              },
              controller: emailTextEditingController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an email';
                }
                return null;
              },
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _passwordField() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            "Password",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
              onChanged: (value){
                setState(() {
                  password = value;
                });
              },
              obscureText: notVisible,
              controller: passwordTextEditingController,
              validator: (value) {
                if (value == null || value.length < 8) {
                  return "Enter a password with at least 8 characters";
                }
                return null;
              },
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: (){
                      setState(() {
                        notVisible = !notVisible;
                      });
                    },
                    icon: Icon(
                      notVisible==true?Icons.visibility_off:Icons.visibility, color: const Color(0xffe46b10)
                    ),
                  ),
                  border: InputBorder.none,
                  fillColor: const Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _formKey.currentState?.reset();
        });
        if (_formKey.currentState?.validate() == true) {
          name = nameTextEditingController.text;
          email = emailTextEditingController.text;
          password = passwordTextEditingController.text;
          registerBloc.add(SignUpButtonPressed(fullname:name, email: email,password: password));
        }
      },
      child: const Text(
        "Register",
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
      style: ElevatedButton.styleFrom(
          primary: const Color(0xffe46b10),
          fixedSize: const Size(410, 45),
      )
    );
  }

  Widget _loginAccountLabel() {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: (){
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const LoginPage()
                ));
              },
              child: const Text(
                'Login',
                style: TextStyle(
                    color: Color(0xfff79c4f),
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
          text: 'd',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Color(0xffe46b10)
          ),
          children: [
            TextSpan(
              text: 'ev',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'rnz',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
    );
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    registerBloc = BlocProvider.of<RegisterBloc>(context);
    authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: -MediaQuery.of(context).size.height * .15,
                          right: -MediaQuery.of(context).size.width * .4,
                          child: const BezierContainer(),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          //child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(height: height * 0.19),
                              _title(),
                              const SizedBox(
                                height: 20,
                              ),
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: <Widget>[
                                    _nameField(),
                                    _emailField(),
                                    _passwordField(),
                                    const SizedBox(
                                      height: 18,
                                    ),
                                    _submitButton(),
                                    const SizedBox(height: 8),
                                    Text(
                                      error,
                                      style: const TextStyle(color: Colors.red, fontSize: 15.0),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: height * .0000001),
                              _loginAccountLabel(),
                              BlocListener<RegisterBloc,RegisterState>(
                                listener: (context,state){
                                  if(state is RegisterSucced){
                                    setState(() {
                                      error = '';
                                    });
                                    Navigator.pushAndRemoveUntil(
                                        context, PageTransition(child: const LoginPage(), type: PageTransitionType.rightToLeft), (route) => false
                                    );
                                  }else if(state is RegisterFailed){
                                    setState(() {
                                      error = 'Fields are incorrect';
                                    });
                                  }
                                },
                                child: BlocBuilder<RegisterBloc,RegisterState>(
                                    builder: (context,state){
                                      if(state is RegisterLoading){
                                        return const Center(
                                            child: CircularProgressIndicator()
                                        );
                                      }else if(state is RegisterFailed){
                                        error = 'Fields are incorrect';
                                      }else if(state is RegisterSucced){
                                        return Container();
                                      }
                                      return Container();
                                    }
                                ),
                              ),
                            ],
                          ),
                        ),
                        //),
                        Positioned(top: 38, left: 0, child: _backButton()),
                      ],
                    ),
                  ),
                ],
              )
      ),
    );
  }
}
