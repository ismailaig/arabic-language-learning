import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language/bloc/regBloc/reg_bloc.dart';
import 'package:language/pages/login.page.dart';
import '../utils/bezierContainer.dart';
import 'home.page.dart';

class SignUpPage extends StatefulWidget {

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  late RegisterBloc registerBloc;
  TextEditingController nameTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();
  late String name = "";
  late String email = "";
  late String password = "";
  String? uid;
  late bool notVisible = true;
  String error = '';
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

  Widget _nameField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Name",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 8,
          ),
          TextFormField(
              onChanged: (value){
                setState(() {
                    this.name = value;
                });
              },
              controller: nameTextEditingController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
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
              onChanged: (value){
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
              onChanged: (value){
                setState(() {
                  this.password = value;
                });
              },
              obscureText: notVisible,
              controller: passwordTextEditingController,
              validator: (value) {
                if (value == null || value.isEmpty) {
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
                      notVisible==true?Icons.visibility_off:Icons.visibility, color: Color(0xffe46b10)
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
      onPressed: () {
        setState(() {
          _formKey.currentState?.reset();
          this.error = '';
        });
        if (_formKey.currentState?.validate() == true) {
          this.name = nameTextEditingController.text;
          this.email = emailTextEditingController.text;
          this.password = passwordTextEditingController.text;
          registerBloc.add(SignUpButtonPressed(email: this.email,password: this.password));
          Map<String, dynamic> data = {
            'uid':this.uid,
            'name':this.name,
            'photo':null,
            'country':null
          };
          FirebaseFirestore.instance.collection('users').add(data);
        }
      },
      child: Text(
        "Register",
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
      style: ElevatedButton.styleFrom(
          primary: Color(0xffe46b10),
          fixedSize: Size(410, 45),
      )
    );
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()
        ));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
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
    registerBloc = BlocProvider.of<RegisterBloc>(context);
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
                          top: -MediaQuery.of(context).size.height * .15,
                          right: -MediaQuery.of(context).size.width * .4,
                          child: BezierContainer(),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          //child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(height: height * 0.19),
                              _title(),
                              SizedBox(
                                height: 20,
                              ),
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: <Widget>[
                                    _nameField(),
                                    _emailField(),
                                    _passwordField(),
                                    SizedBox(
                                      height: 18,
                                    ),
                                    _submitButton(),
                                    SizedBox(height: 8),
                                    Text(
                                      this.error,
                                      style: TextStyle(color: Colors.red, fontSize: 15.0),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: height * .0000001),
                              _loginAccountLabel(),
                            ],
                          ),
                        ),
                        //),
                        Positioned(top: 8, left: 0, child: _backButton()),
                      ],
                    ),
                  ),
                  BlocListener<RegisterBloc,RegisterState>(
                    listener: (context,state){
                      if(state is RegisterSucced){
                        this.error = '';
                        this.name = '';
                        this.password = '';
                        this.email = '';
                        Navigator.push(
                            context, MaterialPageRoute(builder: (_) => HomePage())
                        );
                      }
                    },
                    child: BlocBuilder<RegisterBloc,RegisterState>(
                        builder: (context,state){
                          if(state is RegisterLoading){
                            return Center(
                                child: CircularProgressIndicator()
                            );
                          }else if(state is RegisterFailed){
                            this.error = 'Email or password is incorrect';
                          }else if(state is RegisterSucced){
                            this.uid = state.user?.uid;
                            return Container();
                          }
                          return Container();
                        }
                    ),
                  ),
                ],
              )
      ),
    );
  }
}
