import 'dart:io';

import 'package:devrnz/bloc/authBloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:devrnz/widgets/profile.widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../widgets/drawer.widget.dart';
import '../widgets/textfield.widget.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ProfilePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(title: const Text('Profile'),),
        body: BlocBuilder<AuthBloc,AuthState>(
            builder: (context,state){
              if(state is AuthenticateState){
                return SingleChildScrollView(
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 30),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      ProfileWidget(
                          imagePath:state.listUsers.data[0].attributes.photo.data.attributes.url,
                          onClicked:() async {openDialog(context);}
                      ),
                      const SizedBox(height: 24),
                      TextFieldWidget(
                        label:'Full Name',
                        text: state.listUsers.data[0].attributes.fullname,
                        onChanged: (name){},
                      ),
                      const SizedBox(height: 24),
                      TextFieldWidget(
                        label:'Email',
                        text: state.listUsers.data[0].attributes.email,
                        onChanged: (email){},
                      ),
                      const SizedBox(height: 24),
                      TextFieldWidget(
                        label:'Password',
                        text: state.listUsers.data[0].attributes.password,
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




  Future<void> openDialog(BuildContext context) async{
    return showDialog(context: context,builder: (BuildContext context){
      return AlertDialog(
        title: const Text('Source de l\'image'),
        actions: <Widget>[
          MaterialButton(
            child: const Text('Gallery'),
            onPressed: () async{
              Navigator.of(context).pop();
              XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
              if(file==null) {
                return;
              }
              String path = file.path;
              if (kIsWeb) {
                // Set web-specific directory
                file.saveTo(file.name);
              } else {
                final Directory localStorage = await getApplicationDocumentsDirectory();
                final String locaStoragelPath = localStorage.path;
                await file.saveTo('assets/images/${file.name}');
              }
              context.read<AuthBloc>().add(UploadPicture(file));
            },
          ),
          MaterialButton(
            child: const Text('Camera'),
            onPressed: () async{
              Navigator.of(context).pop();
              XFile? file = await ImagePicker().pickImage(source: ImageSource.camera,maxWidth: 400, maxHeight: 400);
              if(file==null) {
                return;
              }
              String path = file.path;
              if (kIsWeb) {
                // Set web-specific directory
                file.saveTo(file.name);
              } else {
                final Directory localStorage = await getApplicationDocumentsDirectory();
                final String locaStoragelPath = localStorage.path;
                await file.saveTo('assets/images/${file.name}');
              }
              context.read<AuthBloc>().add(UploadPicture(file));
            },
          )
        ],
      );
    });
  }
}