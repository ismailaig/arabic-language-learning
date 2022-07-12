import 'dart:io';
import 'package:devrnz/bloc/authBloc/auth_bloc.dart';
import 'package:devrnz/bloc/enums/EnumEvent.dart';
import 'package:devrnz/models/users.model.dart';
import 'package:devrnz/pages/maps.page.dart';
import 'package:flutter/material.dart';
import 'package:devrnz/widgets/profile.widget.dart';
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
    return BlocBuilder<AuthBloc,AuthenticateState>(
            builder: (context,state){
              if(state.eventState==EventState.LOADED){
                return Scaffold(
                  appBar: AppBar(title: const Text('Profile')),
                  body: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.symmetric(horizontal: 28,vertical: 15),
                        physics: const BouncingScrollPhysics(),
                        children: [
                          ProfileWidget(
                              imagePath:state.listUsers!.data[0].attributes.photo.data==null?"assets/images/profile.jpg":state.listUsers!.data[0].attributes.photo.data!.attributes.url,
                              mode:state.listUsers!.data[0].attributes.photo.data==null?"asset":"network",
                              onClicked:() {
                                openDialog(context,state.listUsers!);
                              }
                          ),
                          const SizedBox(height: 20),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Email", style: TextStyle(fontWeight: FontWeight.bold),),
                                    const SizedBox(height: 7),
                                    TextFormField(
                                      readOnly: true,
                                      //initialValue: state.listUsers!.data[0].attributes.email,
                                      decoration: InputDecoration(
                                        hintText: state.listUsers!.data[0].attributes.email,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.5),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 22),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Fullname", style: TextStyle(fontWeight: FontWeight.bold),),
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      validator: (value) {
                                        if(fullname.isNotEmpty){
                                          if (value == null || value.isEmpty || value.length<3) {
                                            return 'Please enter a fullname with at least 3 characters';
                                          }
                                        }
                                        return null;
                                      },
                                      controller: fullnameTextEditing,
                                      decoration: InputDecoration(
                                        hintText: state.listUsers!.data[0].attributes.fullname,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.5),
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
                                const SizedBox(height: 22),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Password", style: TextStyle(fontWeight: FontWeight.bold),),
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      validator: (value) {
                                        if(password.isNotEmpty){
                                          if (value == null || value.isEmpty || value.length < 8) {
                                            return "Enter a password with at least 8 characters";
                                          }
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
                                          borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.5),
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
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 43,
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
                                  if(password.isEmpty && fullname.isNotEmpty){
                                    setState(() {
                                      fullname = fullnameTextEditing.text;
                                    });
                                    authBloc.add(UpdateInfos(id: state.listUsers!.data[0].id, fullname: fullname, email: state.listUsers!.data[0].attributes.email, listUsers: state.listUsers!, password: state.listUsers!.data[0].attributes.password));
                                  }else if(password.isNotEmpty && fullname.isEmpty){
                                    setState(() {
                                      password = passwordTextEditing.text;
                                    });
                                    authBloc.add(UpdateInfos(id: state.listUsers!.data[0].id, fullname: state.listUsers!.data[0].attributes.fullname, email: state.listUsers!.data[0].attributes.email, listUsers: state.listUsers!, password: password));
                                    setState(() {
                                      _onUpdateUserInfo(password);
                                    });
                                  }
                                }
                              },
                              child: const Text("Update informations",style: TextStyle(fontSize: 18)),
                            ),
                          ),
                          const SizedBox(
                            height: 13,
                          ),
                          BlocBuilder<AuthBloc,AuthenticateState>(
                              builder: (context,state){
                                if(state.eventState==EventState.LOADED && state.error=="Updated"){
                                  return const Center(child: Text("Informations successfully updated", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 14),));
                                }else if(state.eventState==EventState.LOADED && state.error=="Not updated"){
                                  return const Center(child: Text("Error in updating. Retry", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 14),));
                                }
                                return Container();
                              }
                          )
                        ],
                    ),
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      authBloc.add(AppLoaded(listUsers: state.listUsers!));
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const MapPage()));
                    },
                    child: const Icon(Icons.location_on),
                  ),
                );
              }else if(state.eventState==EventState.LOADING){
                return Container(color: Colors.white, child: Center(child: SpinKitThreeInOut(color: Theme.of(context).primaryColor,size: 60,)));
              }
              return Container();
            }
    );
  }

  Future<void> openDialog(BuildContext context,ListUsers listUsers) {
    return showDialog(context: context,builder: (BuildContext context){
      return AlertDialog(
        title: const Text('Profile picture'),
        actions: <Widget>[
          TextButton(
            onPressed: () async{
              Navigator.of(context).pop();
              authBloc.add(DeletePicture(listUsers));
            },
            child: Text('Delete', style: TextStyle(color: Theme.of(context).primaryColor,),),
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
            child: Text('Camera', style: TextStyle(color: Theme.of(context).primaryColor,),),
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
            child: Text('Gallery', style: TextStyle(color: Theme.of(context).primaryColor,))
          ),
        ],
      );
    });
  }
}