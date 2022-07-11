import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:devrnz/bloc/contentBloc/content.event.dart';
import 'package:devrnz/bloc/enums/EnumEvent.dart';
import 'package:devrnz/bloc/lessonBloc/course.bloc.dart';
import 'package:devrnz/bloc/lessonBloc/course.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../bloc/AlphabetsBloc/alphabet.bloc.dart';
import '../bloc/AlphabetsBloc/alphabet.event.dart';
import '../bloc/AlphabetsBloc/alphabet.state.dart';
import '../bloc/NumbersBloc/number.bloc.dart';
import '../bloc/NumbersBloc/number.event.dart';
import '../bloc/NumbersBloc/number.state.dart';
import '../bloc/authBloc/auth_bloc.dart';
import '../bloc/contentBloc/content.bloc.dart';
import '../bloc/lessonBloc/course.event.dart';
import '../widgets/drawer.widget.dart';
import 'content.page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late ContentBloc contentBloc;

  late CourseBloc courseBloc;

  late AlphabetBloc alphabetBloc;

  late NumberBloc numberBloc;

  bool alpha = false;

  final audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {

    alphabetBloc = BlocProvider.of<AlphabetBloc>(context);
    courseBloc = BlocProvider.of<CourseBloc>(context);
    numberBloc = BlocProvider.of<NumberBloc>(context);
    contentBloc = BlocProvider.of<ContentBloc>(context);

    return BlocBuilder<AuthBloc, AuthenticateState>(
        builder: (context, state) {
          if (state.eventState==EventState.LOADED) {
            return Scaffold(
                drawer: MyDrawer(),
                appBar: AppBar(
                    leading: Builder(
                        builder: (BuildContext context) {
                          return IconButton(
                              icon: const Icon(
                                  Icons.menu, color: Colors.deepOrange, size: 35),
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
                        InkWell(
                          onTap: (){
                            courseBloc.add(CourseLoading());
                            setState((){
                              alpha = false;
                            });
                          },
                          child: Image.asset(
                            "assets/images/saudi-arabia.png", height: 40,
                            width: 40,
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            alphabetBloc.add(AlphabetLoading());
                            numberBloc.add(NumberLoading());
                            setState((){
                              alpha = true;
                            });
                          },
                          child: Image.asset(
                            "assets/images/arabic-language.png", height: 35,
                            width: 35,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset("assets/images/crown.png", height: 33,
                                width: 33,),
                              Text("${state.listUsers!.data[0].attributes.king}",
                                style: const TextStyle(color: Colors.orange,
                                    fontSize: 18),)
                            ],
                          ),
                        )
                      ],
                    )
                ),
                body: alpha == false? homeLesson():alphaNumber()
            );
          }
          return Container();
        }
    );
  }


  Widget homeLesson(){
    return BlocBuilder<CourseBloc, CourseState>(
        builder: (context, state) {
          if (state.eventState == EventState.ERROR) {
            return Center(
              child: Column(
                  children:[
                    Text(state.error,style: const TextStyle(color: Colors.red, fontSize: 22),),
                    ElevatedButton(
                      onPressed: (){},
                      child: const Text("Retry"),
                    )
                  ]
              ),
            );
          } else if (state.eventState == EventState.LOADING) {
            return const Center(
              child: SpinKitThreeInOut(
                color: Colors.redAccent,
                size: 80.0,
              ),
            );
          } else if (state.eventState == EventState.LOADED) {
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                padding: const EdgeInsets.only(left: 20, top: 35, bottom: 25, right: 20),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return lesson(state.lessons!.data[index].id, context, state.lessons!.data[index].attributes.image.data.attributes.url,
                      "${state.lessons!.data[index].attributes.king}",
                      state.lessons!.data[index].attributes.title, Colors.blue
                  );
                },
                itemCount: state.lessons!.data.length
            );
          }
          return Container();
        }
    );
  }

  Widget alphaNumber() {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.only(top: 35.0, bottom: 25.0),
          child: Column(
            children: [
              BlocBuilder<AlphabetBloc, AlphabetState>(
                  builder: (context, state) {
                    if (state.eventState == EventState.ERROR) {
                      return Center(
                        child: Column(
                            children:[
                              Text(state.error,style: const TextStyle(color: Colors.red, fontSize: 22),),
                              ElevatedButton(
                                onPressed: (){},
                                child: const Text("Retry"),
                              )
                            ]
                        ),
                      );
                    } else if (state.eventState == EventState.LOADING) {
                      return const Center(
                        child: SpinKitThreeInOut(
                          color: Colors.redAccent,
                          size: 80.0,
                        ),
                      );
                    } else if (state.eventState == EventState.LOADED) {
                      return Column(
                        children: [
                          const Center(
                            child: Text("Alphabets", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: GridView.builder(
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      crossAxisSpacing: 6,
                                      mainAxisSpacing: 6
                                    ),
                                    padding: const EdgeInsets.all(13),
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return alphaNumberContainer(state.alphabet!.data[index].attributes.arabe, state.alphabet!.data[index].attributes.french, state.alphabet!.data[index].attributes.song.data[0].attributes.url);
                                    },
                                    itemCount: state.alphabet!.data.length
                            ),
                          ),
                        ],
                      );
                  }
                    return Container();
                  }
              ),
              BlocBuilder<NumberBloc, NumberState>(
                  builder: (context, state) {
                    if (state.eventState == EventState.ERROR) {
                      return Center(
                        child: Column(
                            children:[
                              Text(state.error,style: const TextStyle(color: Colors.red, fontSize: 22),),
                              ElevatedButton(
                                onPressed: (){},
                                child: const Text("Retry"),
                              )
                            ]
                        ),
                      );
                    } else if (state.eventState == EventState.LOADING) {
                      return Container();
                    } else if (state.eventState == EventState.LOADED) {
                      return Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Center(
                            child: Text("Nombres", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GridView.builder(
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      crossAxisSpacing: 6,
                                      mainAxisSpacing: 6
                                  ),
                                  padding: const EdgeInsets.all(13),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return alphaNumberContainer(state.number!.data[index].attributes.arabe, state.number!.data[index].attributes.french, state.number!.data[index].attributes.song.data[0].attributes.url);
                                  },
                                  itemCount: state.number!.data.length
                          )
                        ],
                      );
                    }
                    return Container();
                  }
              ),
            ],
          )
      ),
    );
  }

  Widget lesson(int id, BuildContext context, String image, String number, String title, Color color){
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
                InkWell(
                  onTap:() {
                    contentBloc.add(ContentLoading(id));
                    Navigator.push(
                        context,MaterialPageRoute(builder: (context) => const ContentPage())
                    );
                  },
                  child: CircleAvatar(
                      radius: 35,
                      backgroundColor: color,
                      child: Image.network(image,height: 50,)
                  ),
                )
              ],
            ),
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Image.asset("assets/images/crown.png",height: 39),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(number,style: const TextStyle(color: Colors.deepOrange,fontSize: 13,fontWeight: FontWeight.bold),),
                )
              ],
            )
          ],
        ),
        const SizedBox(height: 10,),
        Text(title,textAlign: TextAlign.center, overflow: TextOverflow.visible,style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)
      ],
    );
  }

  Widget alphaNumberContainer(String arabic, String french, String urlAudio){
    return InkWell(
      onTap: (){
        audioPlayer.play(UrlSource(urlAudio));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.black12,width: 2)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(arabic,style: const TextStyle(fontSize:20,fontWeight: FontWeight.w700,color: Colors.deepOrange),),
              const SizedBox(
                height: 2,
              ),
              Text(french, style: const TextStyle(fontSize:20,fontWeight: FontWeight.w700,)),
            ],
          ),
        ),
      ),
    );
  }
}
















