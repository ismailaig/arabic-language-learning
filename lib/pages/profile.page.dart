import 'package:devrnz/bloc/authBloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:devrnz/widgets/profile.widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/drawer.widget.dart';
import '../widgets/textfield.widget.dart';

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
                        onClicked:() async {}
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
}





