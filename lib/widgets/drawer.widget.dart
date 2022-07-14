import 'package:AgeArabic/bloc/enums/EnumEvent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:AgeArabic/bloc/theme.bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../bloc/authBloc/auth_bloc.dart';
import '../pages/splash.page.dart';

class MyDrawer extends StatelessWidget {

  late AuthBloc authBloc;

  MyDrawer({Key? key}) : super(key: key);

  final storage = const FlutterSecureStorage();

  _onDeleteUserInfo() async {
    await storage.deleteAll();
  }

  @override
  Widget build(BuildContext context) {
    authBloc = BlocProvider.of<AuthBloc>(context);
    final menus = [
      {"title":"Home", "icon": Icon(Icons.home, color: Theme.of(context).primaryColor,), "route":"/home"},
      {"title":"Profile", "icon": Icon(Icons.account_circle_rounded, color: Theme.of(context).primaryColor), "route":"/profile"},
      {"title":"OCR", "icon": Icon(Icons.ac_unit, color: Theme.of(context).primaryColor), "route":"/ocr"},
      {"title":"Face Detector", "icon": Icon(Icons.face, color: Theme.of(context).primaryColor), "route":"/face"},
      {"title":"QR Code Generate", "icon": Icon(Icons.qr_code, color: Theme.of(context).primaryColor), "route":"/QR"},
      {"title":"QR Scan & Generate", "icon": Icon(Icons.qr_code, color: Theme.of(context).primaryColor), "route":"/scanQR"},
      {"title":"Animation", "icon": Icon(Icons.grading, color: Theme.of(context).primaryColor), "route":"/graphics"},
      {"title":"Log out", "icon": Icon(Icons.logout, color: Theme.of(context).primaryColor), "route":"/welcome"}
    ];
    return BlocBuilder<AuthBloc,AuthenticateState>(
        builder: (context, state) {
          if(state.eventState==EventState.LOADED){
            return Drawer(
              backgroundColor: Colors.white,
              child: Column(
                children: [
                  DrawerHeader(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.white,
                                Theme.of(context).colorScheme.primary
                              ]
                          )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children:  [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: state.listUsers!.data[0].attributes.photo.data==null?const AssetImage("assets/images/profile.jpg"):NetworkImage(state.listUsers!.data[0].attributes.photo.data!.attributes.url) as ImageProvider,
                          ),
                          IconButton(onPressed: (){
                            context.read<ThemeBloc>().add(SwitchThemeEvent());
                          }, icon: const Icon(Icons.palette_outlined, color: Colors.white70, size: 30,))
                        ],
                      )
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
                            onTap: (){
                              if(menus[index]['title']=="Log out"){
                                _onDeleteUserInfo();
                                authBloc.add(LogOut());
                                Navigator.of(context).pop();
                                Navigator.pushAndRemoveUntil(
                                    context,MaterialPageRoute(builder: (context) => const SplashPage()),(route) => false
                                );
                              }else if(menus[index]['title']=="Profile"){
                                context.read<AuthBloc>().add(AppLoaded(listUsers: state.listUsers!));
                                Navigator.of(context).pop();
                                Navigator.pushNamed(context, "${menus[index]['route']}");
                              }else if(menus[index]['title']=="Home"){
                                Navigator.of(context).pop();
                                Navigator.pushNamedAndRemoveUntil(context, "${menus[index]['route']}", (route) => false);
                              }else {
                                Navigator.of(context).pop();
                                Navigator.pushNamed(context, "${menus[index]['route']}");
                              }
                            },
                          );
                        }
                    ),
                  )
                ],
              ),
            );
          }
          return Container();
        });
  }
}






