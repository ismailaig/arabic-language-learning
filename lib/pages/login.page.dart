import 'package:AgeArabic/bloc/lessonBloc/course.bloc.dart';
import 'package:AgeArabic/bloc/lessonBloc/course.event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:AgeArabic/bloc/loginBloc/login_bloc.dart';
import 'package:AgeArabic/pages/home.page.dart';
import 'package:AgeArabic/pages/signup.page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../bloc/authBloc/auth_bloc.dart';
import '../utils/bezierContainer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginBloc loginBloc;
  late AuthBloc authBloc;
  final storage = const FlutterSecureStorage();
  late CourseBloc courseBloc;
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  String email = "";
  String password = "";
  bool notVisible = true;
  String error = "";
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  _onSaveUserInfo(String email, String password) async {
    await storage.write(key: "email", value: email);
    await storage.write(key: "password", value: password);
  }

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
            const Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
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
              onChanged: (value) {
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
              onChanged: (value) {
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
                    onPressed: () {
                      setState(() {
                        notVisible = !notVisible;
                      });
                    },
                    icon: Icon(
                        notVisible == true ? Icons.visibility_off : Icons
                            .visibility, color: const Color(0xffe46b10)
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
        onPressed: () async {
          setState(() {
            FocusManager.instance.primaryFocus?.unfocus();
            _formKey.currentState?.reset();
          });
          if (_formKey.currentState?.validate() == true) {
            email = emailTextEditingController.text;
            password = passwordTextEditingController.text;
            loginBloc.add(SignInButtonPressed(email: email,password: password));
          }
        },
        style: ElevatedButton.styleFrom(
          primary: const Color(0xffe46b10),
          fixedSize: const Size(410, 45),
        ),
        child: const Text(
          "Login",
          style: TextStyle(color: Colors.white, fontSize: 18),
        )
    );
  }

  Widget _divider() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: const <Widget>[
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
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                decoration: const BoxDecoration(
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
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(5),
                      topRight: Radius.circular(5)),
                ),
                child: const Text('Log in with Google',
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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.all(15),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Don\'t have an account ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: (){
              Navigator.pushAndRemoveUntil(
                  context, MaterialPageRoute(builder: (context) => const SignUpPage()), (route) => false
              );
            },
            child: const Text(
              'Register',
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
          text: 'A',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Color(0xffe46b10)
          ),
          children: [
            TextSpan(
              text: 'ge',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'arabic',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    loginBloc = BlocProvider.of<LoginBloc>(context);
    authBloc = BlocProvider.of<AuthBloc>(context);
    courseBloc = BlocProvider.of<CourseBloc>(context);
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
                      top: -height * .25,
                      right: -MediaQuery.of(context).size.width * .4,
                      child: const BezierContainer()),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    //child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: height * .1),
                        _title(),
                        const SizedBox(height: 5),
                        Form(
                          key: _formKey,
                          child: Column(
                              children: <Widget>[
                                _emailField(),
                                _passwordField(),
                                const SizedBox(height: 15),
                                _submitButton(),
                                const SizedBox(height: 8),
                                Text(
                                  error,
                                  style: const TextStyle(color: Colors.red, fontSize: 15.0),
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
                        BlocListener<LoginBloc,LoginState>(
                            listener: (context, state) {
                              if(state is LoginSucced){
                                setState(() {
                                  error = '';
                                  _onSaveUserInfo(state.listUsers.data[0].attributes.email, state.listUsers.data[0].attributes.password);
                                });
                                authBloc.add(AppLoaded(listUsers: state.listUsers));
                                courseBloc.add(CourseLoading());
                                Navigator.pushAndRemoveUntil(
                                    context,MaterialPageRoute(builder: (context) => const HomePage()),(route) => false
                                );
                              }else if(state is LoginFailed){
                                setState(() {
                                  error = 'Email or password is incorrect';
                                });
                              }
                            },
                            child: BlocBuilder<LoginBloc,LoginState>(
                                builder: (context,state){
                                  if(state is LoginLoading){
                                    return const Center(
                                        child: SpinKitThreeInOut(
                                          color: Colors.orange,
                                          size: 40.0,
                                        )
                                    );
                                  }else if(state is LoginFailed){
                                    error = 'Email or password is incorrect';
                                  }else if(state is LoginSucced){
                                    return Container();
                                  }
                                  return Container();
                                }
                            )
                        ),
                      ],
                    ),
                  ),
                  //),
                  //²²²²²²²²²Positioned(top: 38, left: 0, child: _backButton()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}