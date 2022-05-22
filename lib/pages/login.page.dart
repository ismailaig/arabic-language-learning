import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language/bloc/loginBloc/login_bloc.dart';
import 'package:language/pages/splash.page.dart';
import 'package:language/pages/home.page.dart';
import 'package:language/pages/signup.page.dart';
import '../utils/bezierContainer.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginBloc loginBloc;
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();
  late String email = "";
  late String password = "";
  late bool notVisible = true;
  String error = '';
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }


  Widget _emailField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Email",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 8,
          ),
          TextFormField(
              onChanged: (value) {
                setState(() {
                  this.email = value;
                });
              },
              controller: emailTextEditingController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an email';
                }
                return null;
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _passwordField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Password",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 8,
          ),
          TextFormField(
              onChanged: (value) {
                setState(() {
                  this.password = value;
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
                    onPressed: () {
                      setState(() {
                        notVisible = !notVisible;
                      });
                    },
                    icon: Icon(
                        notVisible == true ? Icons.visibility_off : Icons
                            .visibility, color: Color(0xffe46b10)
                    ),
                  ),
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }


  Widget _submitButton() {
    return ElevatedButton(
        onPressed: () async {
          setState(() {
            _formKey.currentState?.reset();
            this.error = '';
            this.password = '';
            this.email = '';
          });
          if (_formKey.currentState?.validate() == true) {
            this.email = emailTextEditingController.text;
            this.password = passwordTextEditingController.text;
            loginBloc.add(SignInButtonPressed(email: this.email,password: this.password));
          }
        },
        child: Text(
          "Login",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        style: ElevatedButton.styleFrom(
          primary: Color(0xffe46b10),
          fixedSize: Size(410, 45),
        )
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _googleButton() {
    return InkWell(
      onTap: () {
        //Navigator.push(
        //context, MaterialPageRoute(builder: (context) => HomePage()
        //));
      },
      child: Container(
        height: 60,
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  //border: Border.all(width: 5, color: Colors.deepOrange),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      topLeft: Radius.circular(5)),
                ),
                alignment: Alignment.center,
                child: const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage("assets/images/google.png"),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(5),
                      topRight: Radius.circular(5)),
                ),
                child: Text('Log in with Google',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Don\'t have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Register',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
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
    loginBloc = BlocProvider.of<LoginBloc>(context);
    return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: height,
                    child: Stack(
                    children: <Widget>[
                    Positioned(
                      top: -height * .25,
                        right: -MediaQuery.of(context).size.width * .4,
                      child: BezierContainer()),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        //child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: height * .1),
                            _title(),
                            SizedBox(height: 5),
                            Form(
                              key: _formKey,
                              child: Column(
                              children: <Widget>[
                                _emailField(),
                                _passwordField(),
                                SizedBox(height: 15),
                                _submitButton(),
                                SizedBox(height: 8),
                                  Text(
                                    this.error,
                                    style: TextStyle(color: Colors.red, fontSize: 15.0),
                                  )
                              ]
                              ),
                            ),
                            /*Container(
                              margin: EdgeInsets.only(top: 15),
                              padding: EdgeInsets.symmetric(vertical: 5),
                              alignment: Alignment.center,
                              child: Text('Forgot Password ?',
                                style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                             ),*/
                            //_divider(),
                            //_googleButton(),
                            SizedBox(height: height * .0001),
                            _createAccountLabel(),
                          ],
                        ),
                      ),
                    //),
                    Positioned(top: 8, left: 0, child: _backButton()),
                    ],
                  ),
                  ),
                  BlocListener<LoginBloc,LoginState>(
                      listener: (context, state) {
                        if(state is LoginSucced){
                          this.error = '';
                          this.email = '';
                          this.password = '';
                          Navigator.push(
                              context,MaterialPageRoute(builder: (context)=>HomePage())
                          );
                        }
                      },
                      child: BlocBuilder<LoginBloc,LoginState>(
                          builder: (context,state){
                            if(state is LoginLoading){
                              return Center(
                                  child: CircularProgressIndicator()
                              );
                            }if(state is LoginFailed){
                              this.error = 'Email or password is incorrect';
                            }else if(state is LoginSucced){
                              return Container();
                            }
                            return Container();
                          }
                      )
                  ),
                ],
              ),
            )
        );
    }
}
