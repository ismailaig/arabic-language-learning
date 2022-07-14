import 'dart:io';
import 'package:AgeArabic/bloc/authBloc/auth_bloc.dart';
import 'package:AgeArabic/bloc/enums/EnumEvent.dart';
import 'package:AgeArabic/models/users.model.dart';
import 'package:AgeArabic/pages/maps.page.dart';
import 'package:flutter/material.dart';
import 'package:AgeArabic/widgets/profile.widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/utils.dart';

class ProfilePage extends StatefulWidget {

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late AuthBloc authBloc;
  final storage = const FlutterSecureStorage();
  late TextEditingController passwordTextEditing = TextEditingController();
  late TextEditingController fullnameTextEditing = TextEditingController();
  String fullname = "";
  bool notVisible = true;
  String password = "";
  final _formKey = GlobalKey<FormState>();

  _onUpdateUserInfo(String password) async {
    await storage.write(key: "password", value: password);
  }

  @override
  Widget build(BuildContext context) {
    authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile', style: TextStyle(color: Colors.white),),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: BlocListener<AuthBloc,AuthenticateState>(
          listener: (context, state) {
            if(state.eventState == EventState.LOADED && state.error == "Updated") {
              if(password.isNotEmpty){
                _onUpdateUserInfo(password);
              }
              showUpdateDialog(context,true,"Successfully updated");
            }else if(state.eventState == EventState.LOADED && state.error == "Not updated") {
              showUpdateDialog(context,false,"Error in updating. Retry");
            }
          },
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 25, right: 25, bottom: 30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocBuilder<AuthBloc,AuthenticateState>(
                        builder: (context,state) {
                          if(state.eventState==EventState.LOADING) {
                            return Center(
                                child: SpinKitThreeInOut(
                                  color: Theme
                                      .of(context)
                                      .primaryColor,
                                  size: 40.0,
                                )
                            );
                          }else if(state.eventState == EventState.LOADED) {
                            return Column(
                                children: [
                                  ProfileWidget(
                                      imagePath: state.listUsers!.data[0]
                                          .attributes.photo
                                          .data == null
                                          ? "assets/images/profile.jpg"
                                          : state.listUsers!.data[0].attributes
                                          .photo
                                          .data!.attributes.url,
                                      mode: state.listUsers!.data[0].attributes
                                          .photo
                                          .data == null ? "asset" : "network",
                                      onClicked: () {
                                        openDialog(context, state.listUsers!);
                                      }
                                  ),
                                  const SizedBox(height: 20),
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            const Text("Email", style: TextStyle(
                                                fontWeight: FontWeight.bold),),
                                            const SizedBox(height: 7),
                                            TextFormField(
                                              readOnly: true,
                                              //initialValue: state.listUsers!.data[0].attributes.email,
                                              decoration: InputDecoration(
                                                hintText: state.listUsers!.data[0]
                                                    .attributes.email,
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme
                                                          .of(context)
                                                          .primaryColor,
                                                      width: 1.5),
                                                  borderRadius: BorderRadius
                                                      .circular(12),
                                                ),
                                              ),
                                              maxLines: 1,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 22),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            const Text(
                                              "Fullname", style: TextStyle(
                                                fontWeight: FontWeight.bold),),
                                            const SizedBox(height: 8),
                                            TextFormField(
                                              validator: (value) {
                                                if (fullname.isNotEmpty) {
                                                  if (value == null ||
                                                      value.isEmpty ||
                                                      value.length < 3) {
                                                    return 'Please enter a fullname with at least 3 characters';
                                                  }
                                                }
                                                return null;
                                              },
                                              controller: fullnameTextEditing,
                                              decoration: InputDecoration(
                                                hintText: state.listUsers!.data[0]
                                                    .attributes.fullname,
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme
                                                          .of(context)
                                                          .primaryColor,
                                                      width: 1.5),
                                                  borderRadius: BorderRadius
                                                      .circular(12),
                                                ),
                                              ),
                                              maxLines: 1,
                                              onChanged: (value) {
                                                setState(() {
                                                  fullname = value;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 22),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            const Text(
                                              "Password", style: TextStyle(
                                                fontWeight: FontWeight.bold),),
                                            const SizedBox(height: 8),
                                            TextFormField(
                                              validator: (value) {
                                                if (password.isNotEmpty) {
                                                  if (value == null ||
                                                      value.isEmpty ||
                                                      value.length < 8) {
                                                    return "Enter a password with at least 8 characters";
                                                  }
                                                }
                                                return null;
                                              },
                                              obscureText: notVisible,
                                              controller: passwordTextEditing,
                                              decoration: InputDecoration(
                                                hintText: state.listUsers!.data[0]
                                                    .attributes.password,
                                                suffixIcon: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      notVisible = !notVisible;
                                                    });
                                                  },
                                                  icon: Icon(
                                                      notVisible == true ? Icons
                                                          .visibility_off : Icons
                                                          .visibility,
                                                      color: Theme
                                                          .of(context)
                                                          .primaryColor
                                                  ),
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme
                                                          .of(context)
                                                          .primaryColor,
                                                      width: 1.5),
                                                  borderRadius: BorderRadius
                                                      .circular(12),
                                                ),
                                              ),
                                              maxLines: 1,
                                              onChanged: (value) {
                                                setState(() {
                                                  password = value;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 50,
                                    width:310,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  18.0),
                                            ),
                                          ),
                                          backgroundColor: MaterialStateProperty
                                              .all<
                                              Color>(Theme
                                              .of(context)
                                              .primaryColor)
                                      ),
                                      onPressed: () {
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        setState(() {
                                          _formKey.currentState?.reset();
                                        });
                                        if (_formKey.currentState?.validate() ==
                                            true) {
                                          if (password.isEmpty &&
                                              fullname.isNotEmpty) {
                                            setState(() {
                                              fullname = fullnameTextEditing.text;
                                            });
                                            authBloc.add(UpdateInfos(
                                                id: state.listUsers!.data[0].id,
                                                fullname: fullname,
                                                email: state.listUsers!.data[0]
                                                    .attributes.email,
                                                listUsers: state.listUsers!,
                                                password: state.listUsers!.data[0]
                                                    .attributes.password));
                                          } else if (password.isNotEmpty &&
                                              fullname.isEmpty) {
                                            setState(() {
                                              password = passwordTextEditing.text;
                                            });
                                            authBloc.add(UpdateInfos(
                                                id: state.listUsers!.data[0].id,
                                                fullname: state.listUsers!.data[0]
                                                    .attributes.fullname,
                                                email: state.listUsers!.data[0]
                                                    .attributes.email,
                                                listUsers: state.listUsers!,
                                                password: password));
                                          } else if (password.isNotEmpty &&
                                              fullname.isNotEmpty) {
                                            setState(() {
                                              password = passwordTextEditing.text;
                                              fullname = fullnameTextEditing.text;
                                            });
                                            authBloc.add(UpdateInfos(
                                                id: state.listUsers!.data[0].id,
                                                fullname: fullname,
                                                email: state.listUsers!.data[0]
                                                    .attributes.email,
                                                listUsers: state.listUsers!,
                                                password: password));
                                          }
                                        }
                                      },
                                      child: const Text("Update informations",
                                          style: TextStyle(color: Colors.white,
                                              fontSize: 18)),
                                    ),
                                  ),
                                ]
                            );
                          }
                          return Container();
                        }
                  ),
                ]
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
          builder: (context) => const MapPage()));
          },
          child: const Icon(Icons.location_on, color: Colors.white,),
        )
    );
  }

  Future<void> showUpdateDialog(BuildContext context, bool updated, String content) {
    return showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        title: Center(child: Icon(
            updated==true?Icons.check_circle_outline:Icons.error_outline, color: updated==true?Colors.green:Colors.red, size: 45)),
        content: Text(content, style: const TextStyle(fontSize: 20),),
        actions: <Widget>[
          OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK", style: TextStyle(color: Theme.of(context).primaryColor,))
          )
        ],
      );
    }
    );
  }

    Future<void> openDialog(BuildContext context,ListUsers listUsers) {
      return showDialog(context: context,builder: (BuildContext context){
        return AlertDialog(
          title: const Text('Profile picture'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                authBloc.add(DeletePicture(listUsers));
              },
              child: Text('Delete', style: TextStyle(fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor,),),
            ),
            TextButton(
              onPressed: () async{
                Navigator.of(context).pop();
                File? file = await Utils().pickImage(ImageSource.camera,false,500,500);
                if(file == null) {
                  return;
                }else{
                  authBloc.add(UpdatePicture(file,listUsers));
                }
              },
              child: Text('Camera', style: TextStyle(fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor,),),
            ),
            TextButton(
                onPressed: () async{
                  Navigator.of(context).pop();
                  File? file = await Utils().pickImage(ImageSource.gallery,false,500,500);
                  if(file == null) {
                    return;
                  }else{
                    authBloc.add(UpdatePicture(file,listUsers));
                  }
                },
                child: Text('Gallery', style: TextStyle(fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor,))
            ),
          ],
        );
      });
    }
}
