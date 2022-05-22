import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language/bloc/logoutBloc/logout_bloc.dart';
import 'package:language/bloc/theme.bloc.dart';
import 'package:language/pages/welcome.page.dart';
import '../bloc/logoutBloc/logout_event.dart';
import '../bloc/logoutBloc/logout_state.dart';
import '../repositories/user_repositories.dart';

class MyDrawer extends StatelessWidget {
  late LogoutBloc logoutBloc;
  UserRepository userRepository = UserRepository(firebaseAuth: FirebaseAuth.instance);
  var datas;
  @override
  Widget build(BuildContext context) {
    User? user = userRepository.getCurrentUser();
    String? uid = user?.uid;
    logoutBloc = BlocProvider.of<LogoutBloc>(context);
    final menus=[
      {"title":"Home", "icon": Icon(Icons.home, color: Theme.of(context).primaryColor,), "route":"/home"},
      {"title":"Profile", "icon": Icon(Icons.account_circle_rounded, color: Theme.of(context).primaryColor), "route":"/profile"},
      {"title":"Setting", "icon": Icon(Icons.settings, color: Theme.of(context).primaryColor), "route":"/setting"},
      {"title":"Log out", "icon": Icon(Icons.logout, color: Theme.of(context).primaryColor), "route":"/welcome"}
    ];
    return BlocListener<LogoutBloc,LogoutState>(
      listener: (context, state) {
        if(state is LogoutSucced){
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => WelcomePage())
          );
        }
      },
      child: BlocBuilder<LogoutBloc,LogoutState>(
        builder: (context, state) {
          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('users').where('uid',isEqualTo: uid).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if(snapshot.hasError){
                return Text('${snapshot.error}');
              }
              switch (snapshot.connectionState){
                case ConnectionState.waiting : return CircularProgressIndicator();
                default : return ListView(
                  shrinkWrap: true,
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                    return Drawer(
                      child: Column(
                        children: [
                          DrawerHeader(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Theme.of(context).colorScheme.primary,
                                      Colors.white
                                    ]
                                )
                            ),
                            child: Column(
                                children:[
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children:  [
                                        const CircleAvatar(
                                          radius: 50,
                                          backgroundImage: AssetImage("assets/images/profile.jpg"),
                                        ),
                                        IconButton(
                                            onPressed: (){
                                              context.read<ThemeBloc>().add(SwitchThemeEvent());
                                            },
                                            icon: const Icon(Icons.switch_account)
                                        )
                                      ]
                                  ),
                                  Text('${data['name']}',style: Theme.of(context).textTheme.headlineSmall,),
                                ],
                            ),
                          ),
                          Expanded(
                            child: ListView.separated(
                                separatorBuilder: (_,__){
                                  return Divider(color: Theme.of(context).primaryColor,height: 1,);
                                },
                                itemCount: menus.length,
                                itemBuilder: (_,index){
                                  return ListTile(
                                    leading: menus[index]['icon'] as Icon,
                                    title: Text("${menus[index]['title']}"),
                                    onTap: () async {
                                      if(menus[index]['title']=='Log out'){
                                        logoutBloc.add(LogoutButtonPressed());
                                      }
                                      Navigator.of(context).pop();
                                      Navigator.pushNamed(context, "${menus[index]['route']}");
                                    },
                                  );
                                }
                            ),
                          )
                        ],
                      ),
                    );
                  }).toList(),
                );
              }
            },
          );
        }),
      );
  }
}



