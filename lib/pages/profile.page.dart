import 'dart:io';
import 'package:devrnz/bloc/authBloc/auth_bloc.dart';
import 'package:devrnz/bloc/enums/EnumEvent.dart';
import 'package:devrnz/models/users.model.dart';
import 'package:flutter/material.dart';
import 'package:devrnz/widgets/profile.widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/utils.dart';
import '../widgets/textfield.widget.dart';

class ProfilePage extends StatelessWidget {

  late AuthBloc authBloc;

  ProfilePage({Key? key}) : super(key: key);
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
                        TextFieldWidget(
                          label:'Full Name',
                          text: state.listUsers!.data[0].attributes.fullname,
                          onChanged: (name){},
                        ),
                        const SizedBox(height: 24),
                        TextFieldWidget(
                          label:'Email',
                          text: state.listUsers!.data[0].attributes.email,
                          onChanged: (email){},
                        ),
                        const SizedBox(height: 24),
                        TextFieldWidget(
                          label:'Password',
                          text: state.listUsers!.data[0].attributes.password,
                          onChanged: (name){},
                        ),
                      ],
                  ),
                );
              }
              return Container();
            }
        )
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