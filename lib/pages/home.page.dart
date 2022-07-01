import 'dart:math';
import 'package:devrnz/bloc/contentBloc/content.event.dart';
import 'package:devrnz/bloc/enums/EnumEvent.dart';
import 'package:devrnz/bloc/lessonBloc/course.bloc.dart';
import 'package:devrnz/bloc/lessonBloc/course.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/authBloc/auth_bloc.dart';
import '../bloc/contentBloc/content.bloc.dart';
import '../widgets/drawer.widget.dart';
import 'content.page.dart';

class HomePage extends StatelessWidget {
  late ContentBloc contentBloc;
  @override
  Widget build(BuildContext context) {
    contentBloc = BlocProvider.of<ContentBloc>(context);
    return BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthenticateState) {
            return Scaffold(
                drawer: MyDrawer(),
                appBar: AppBar(
                    leading: Builder(
                        builder: (BuildContext context) {
                          return IconButton(
                              icon: const Icon(
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
                                style: const TextStyle(color: Colors.orange,
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
                            Text(state.error,style: const TextStyle(color: Colors.red, fontSize: 22),),
                            ElevatedButton(
                                onPressed: (){},
                                child: const Text("Réessayer"),
                            )
                          ]
                        );
                      } else if (state.eventState == EventState.LOADING) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state.eventState == EventState.LOADED) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 35.0, bottom: 25.0),
                          child: GridView.builder(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                ),
                                padding: EdgeInsets.only(left: 45, right: 45),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      contentBloc.add(ContentLoading(state.lessons!.data[index].id));
                                      Navigator.push(
                                          context,MaterialPageRoute(builder: (context)=>ContentPage())
                                      );
                                    },
                                    child: lesson(state.lessons!.data[index].attributes.image.data.attributes.url,
                                        "${state.lessons!.data[index].attributes.king}",
                                        state.lessons!.data[index].attributes.title, Colors.blue
                                    ),
                                  );
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
      const SizedBox(width: 20,),
      lesson2
    ],
  );
}

Widget lesson(String image, String number, String title, Color color){
  return Column(
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
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.yellow),
                  value: Random().nextDouble(),
                  strokeWidth: 60,
                ),
              ),
              const Padding(
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
              Text(number,style: const TextStyle(color: Colors.deepOrange),)
            ],
          )
        ],
      ),
      const SizedBox(height: 10,),
      Text(title,style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)
    ],
  );
}
