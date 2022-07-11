import 'dart:io';
import 'package:devrnz/bloc/authBloc/auth_bloc.dart';
import 'package:devrnz/bloc/enums/EnumEvent.dart';
import 'package:devrnz/models/users.model.dart';
import 'package:devrnz/pages/maps.page.dart';
import 'package:flutter/material.dart';
import 'package:devrnz/widgets/profile.widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
        appBar: AppBar(title: const Text('Profile'),),
        body: BlocBuilder<AuthBloc,AuthenticateState>(
            builder: (context,state){
              if(state.eventState==EventState.LOADED){
                return Padding(
                  padding: const EdgeInsets.only(bottom: 18),
                  child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 30),
                      physics: const BouncingScrollPhysics(),
                      children: [
                        ProfileWidget(
                            imagePath:state.listUsers!.data[0].attributes.photo.data==null?"assets/images/profile.jpg":state.listUsers!.data[0].attributes.photo.data!.attributes.url,
                            mode:state.listUsers!.data[0].attributes.photo.data==null?"asset":"network",
                            onClicked:() {
                              openDialog(context,state.listUsers!);
                            }
                        ),
                        const SizedBox(height: 24),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Email", style: TextStyle(fontWeight: FontWeight.bold),),
                                  const SizedBox(height: 8),
                                  TextFormField(
                                    enabled: false,
                                    //initialValue: state.listUsers!.data[0].attributes.email,
                                    decoration: InputDecoration(
                                      hintText: state.listUsers!.data[0].attributes.email,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Fullname", style: TextStyle(fontWeight: FontWeight.bold),),
                                  const SizedBox(height: 8),
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty || value.length<3) {
                                        return 'Please enter a fullname with at least 3 characters';
                                      }
                                      return null;
                                    },
                                    controller: fullnameTextEditing,
                                    decoration: InputDecoration(
                                      hintText: state.listUsers!.data[0].attributes.fullname,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    maxLines: 1,
                                    onChanged: (value){
                                      setState(() {
                                        fullname = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Password", style: TextStyle(fontWeight: FontWeight.bold),),
                                  const SizedBox(height: 8),
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty || value.length < 8) {
                                        return "Enter a password with at least 8 characters";
                                      }
                                      return null;
                                    },
                                    obscureText: notVisible,
                                    controller: passwordTextEditing,
                                    decoration: InputDecoration(
                                      hintText: state.listUsers!.data[0].attributes.password,
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            notVisible = !notVisible;
                                          });
                                        },
                                        icon: Icon(
                                            notVisible == true ? Icons.visibility_off : Icons.visibility, color: Theme.of(context).primaryColor
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    maxLines: 1,
                                    onChanged: (value){
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
                        const SizedBox(height: 30),
                        SizedBox(
                          height: 45,
                          width: 300,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor)
                            ),
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              setState(() {
                                _formKey.currentState?.reset();
                              });
                              if (_formKey.currentState?.validate() == true) {
                                password = passwordTextEditing.text;
                                fullname = fullnameTextEditing.text;
                                authBloc.add(UpdateInfos(state.listUsers!.data[0].id, fullname, state.listUsers!.data[0].attributes.email, password));
                                _onUpdateUserInfo(password);
                              }
                            },
                            child: const Text("Update informations",style: TextStyle(fontSize: 18)),
                          ),
                        ),
                      ],
                  ),
                );
              }
              return Container();
            }
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const MapPage()));
          },
          child: const Icon(Icons.location_on),
        ),
    );
  }

  Future<void> openDialog(BuildContext context,ListUsers listUsers) {
    return showDialog(context: context,builder: (BuildContext context){
      return AlertDialog(
        title: const Text('Source de l\'image'),
        actions: <Widget>[
          MaterialButton(
            child: const Text('Gallery'),
            onPressed: () async{
              Navigator.of(context).pop();
              File file = await Utils().pickImage(ImageSource.gallery,false,500,500);
              if(file == null) {
                return;
              }else{
                authBloc.add(UpdatePicture(file,listUsers));
              }
            },
          ),
          MaterialButton(
            child: const Text('Camera'),
            onPressed: () async{
              Navigator.of(context).pop();
              File file = await Utils().pickImage(ImageSource.camera,false,500,500);
              if(file == null) {
                return;
              }else{
                authBloc.add(UpdatePicture(file,listUsers));
              }
            },
          )
        ],
      );
    });
  }
}