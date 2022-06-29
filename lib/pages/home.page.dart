import 'dart:math';
import 'package:devrnz/bloc/enums/EnumEvent.dart';
import 'package:devrnz/bloc/lessonBloc/course.bloc.dart';
import 'package:devrnz/bloc/lessonBloc/course.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/authBloc/auth_bloc.dart';
import '../widgets/drawer.widget.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthenticateState) {
            return Scaffold(
                drawer: MyDrawer(),
                appBar: AppBar(
                    leading: Builder(
                        builder: (BuildContext context) {
                          return IconButton(
                              icon: Icon(
                                  Icons.menu, color: Colors.orange, size: 30),
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                              tooltip: MaterialLocalizations
                                  .of(context)
                                  .openAppDrawerTooltip
                          );
                        }
                    ),
                    backgroundColor: Colors.white,
                    elevation: 1.7,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.asset(
                          "assets/images/saudi-arabia.png", height: 50,
                          width: 50,),
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset("assets/images/crown.png", height: 40,
                                width: 40,),
                              Text("${state.listUsers.data[0].attributes.king}",
                                style: TextStyle(color: Colors.orange,
                                    fontSize: 18),)
                            ],
                          ),
                        )
                      ],
                    )
                ),
                body: BlocBuilder<CourseBloc, CourseState>(
                    builder: (context, state) {
                      if (state.eventState == EventState.ERROR) {
                        return Column(
                          children:[
                            Text(state.error,style: TextStyle(color: Colors.red, fontSize: 22),),
                            ElevatedButton(
                                onPressed: (){},
                                child: Text("Réessayer"),
                            )
                          ]
                        );
                      } else if (state.eventState == EventState.LOADING) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state.eventState == EventState.LOADED) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 25.0, bottom: 25.0),
                          child: ListView.separated(
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () => print("ontap fonctionne"),
                                    child: lesson("assets/images/egg.png",
                                        "${state.lessons!.data[index].attributes.king}",
                                        state.lessons!.data[index].attributes.title, Colors.blue
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(height: 40);
                                },
                                itemCount: state.lessons!.data.length
                          ),
                        );
                      }
                      return Container();
                    }
                )
            );
          }
          return Container();
        }
    );
  }

}

Widget twoLessons(Widget lesson1, Widget lesson2){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      lesson1,
      SizedBox(width: 20,),
      lesson2
    ],
  );
}

Widget lesson(String image, String number, String title, Color color){
  return Container(
    child: Column(
      children: <Widget>[
        Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Transform.rotate(
                  angle: 3*pi/4,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                    value: Random().nextDouble(),
                    strokeWidth: 60,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 42,
                  ),
                ),
                CircleAvatar(
                  child: Image.network(image,height: 50,),
                  radius: 35,
                  backgroundColor: color
                )
              ],
            ),
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Image.asset("assets/images/crown.png",height: 30,),
                Text(number,style: TextStyle(color: Colors.deepOrange),)
              ],
            )
          ],
        ),
        SizedBox(height: 10,),
        Text(title,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)
      ],
    ),
  );
}
