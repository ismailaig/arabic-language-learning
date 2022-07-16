import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:aget_arabic/bloc/contentBloc/content.event.dart';
import 'package:aget_arabic/bloc/enums/EnumEvent.dart';
import 'package:aget_arabic/bloc/lessonBloc/course.bloc.dart';
import 'package:aget_arabic/bloc/lessonBloc/course.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';
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
  bool alpha = false;

  final audioPlayer = AudioPlayer();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final colors = [
    Colors.deepOrange,
    Colors.blue,
    Colors.teal,
    Colors.purple,
    Colors.cyan,
    Colors.lightGreen,
    Colors.blueGrey
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_scaffoldKey.currentState!.isDrawerOpen) {
          Navigator.of(context).pop();
          return false;
        } else {
          final shouldPop = await showMyDialog();
          return shouldPop ?? false;
        }
      },
      child:
          BlocBuilder<AuthBloc, AuthenticateState>(builder: (context, state) {
        if (state.eventState == EventState.LOADED) {
          return Scaffold(
              key: _scaffoldKey,
              backgroundColor: Colors.white,
              drawer: MyDrawer(),
              appBar: AppBar(
                  leading: Builder(builder: (BuildContext context) {
                    return IconButton(
                        icon: Icon(Icons.menu,
                            color: Theme.of(context).primaryColor, size: 38),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        tooltip: MaterialLocalizations.of(context)
                            .openAppDrawerTooltip);
                  }),
                  backgroundColor: Colors.white,
                  elevation: 1.7,
                  title: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          onTap: () async {
                            if (alpha == true) {
                              bool hasInternet =
                                  await InternetConnectionChecker()
                                      .hasConnection;
                              if (hasInternet == false) {
                                showSimpleNotification(
                                    const Text(
                                      "No internet connection",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    background: Colors.redAccent);
                              } else {
                                context.read<CourseBloc>().add(CourseLoading());
                                setState(() {
                                  alpha = false;
                                });
                              }
                            }
                          },
                          child: Image.asset(
                            "assets/images/saudi-arabia.png",
                            height: 40,
                            width: 40,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            if (alpha == false) {
                              bool hasInternet =
                                  await InternetConnectionChecker()
                                      .hasConnection;
                              if (hasInternet == false) {
                                showSimpleNotification(
                                    const Text(
                                      "No internet connection",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    background: Colors.redAccent);
                              } else {
                                context
                                    .read<AlphabetBloc>()
                                    .add(AlphabetLoading());
                                context.read<NumberBloc>().add(NumberLoading());
                                setState(() {
                                  alpha = true;
                                });
                              }
                            }
                          },
                          child: Image.asset(
                            "assets/images/arabic-language.png",
                            height: 35,
                            width: 35,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                "assets/images/crown.png",
                                height: 33,
                                width: 33,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                "${state.listUsers!.data[0].attributes.king}",
                                style: const TextStyle(
                                    color: Colors.orange, fontSize: 18),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
              body: alpha == false ? homeLesson() : alphaNumber());
        }
        return Container();
      }),
    );
  }

  Future<bool?> showMyDialog() => showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.spaceAround,
            title: const Center(child: Text('Do you want to quit ?')),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    side: BorderSide(
                      width: 1,
                      color: Theme.of(context).primaryColor,
                    )),
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: Text("Cancel",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 15)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor),
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: const Text("Quit",
                    style: TextStyle(color: Colors.white, fontSize: 15)),
              ),
            ],
          );
        },
      );

  Widget homeLesson() {
    return BlocBuilder<CourseBloc, CourseState>(builder: (context, state) {
      if (state.eventState == EventState.ERROR) {
        return Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Error connexion. Try to connect",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.visible,
                  style: TextStyle(color: Colors.red, fontSize: 22),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<CourseBloc>().add(CourseLoading());
                  },
                  child: const Text(
                    "Retry",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ]),
        );
      } else if (state.eventState == EventState.LOADING) {
        return Center(
          child: SpinKitFadingCircle(
            color: Theme.of(context).primaryColor,
            size: 50.0,
          ),
        );
      } else if (state.eventState == EventState.LOADED) {
        return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            padding:
                const EdgeInsets.only(left: 20, top: 35, bottom: 25, right: 20),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return state.lessons!.data[index].attributes.locked == true
                  ? lessonInkwell()
                  : lesson(
                      state.lessons!.data[index].id,
                      context,
                      state.lessons!.data[index].attributes.image.data
                          .attributes.url,
                      "0",
                      state.lessons!.data[index].attributes.title,
                      colors[Random().nextInt(7)],
                    );
            },
            itemCount: state.lessons!.data.length);
      }
      return Container();
    });
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Error connexion. Try to connect",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.visible,
                            style: TextStyle(color: Colors.red, fontSize: 22),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<AlphabetBloc>()
                                  .add(AlphabetLoading());
                              context.read<NumberBloc>().add(NumberLoading());
                            },
                            child: const Text(
                              "Retry",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ]),
                  );
                } else if (state.eventState == EventState.LOADING) {
                  return Container();
                } else if (state.eventState == EventState.LOADED) {
                  return Column(
                    children: [
                      const Center(
                        child: Text(
                          "Alphabets",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    crossAxisSpacing: 6,
                                    mainAxisSpacing: 6),
                            padding: const EdgeInsets.all(13),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return alphaNumberContainer(
                                  context,
                                  state.alphabet!.data[index].attributes.arabe,
                                  state.alphabet!.data[index].attributes.french,
                                  state.alphabet!.data[index].attributes.song
                                      .data[0].attributes.url);
                            },
                            itemCount: state.alphabet!.data.length),
                      ),
                    ],
                  );
                }
                return Container();
              }),
              BlocBuilder<NumberBloc, NumberState>(builder: (context, state) {
                if (state.eventState == EventState.LOADING) {
                  return Center(
                    child: SpinKitFadingCircle(
                      color: Theme.of(context).primaryColor,
                      size: 50.0,
                    ),
                  );
                } else if (state.eventState == EventState.LOADED) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Center(
                        child: Text(
                          "Nombres",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 6,
                                  mainAxisSpacing: 6),
                          padding: const EdgeInsets.all(13),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return alphaNumberContainer(
                                context,
                                state.number!.data[index].attributes.arabe,
                                state.number!.data[index].attributes.french,
                                state.number!.data[index].attributes.song
                                    .data[0].attributes.url);
                          },
                          itemCount: state.number!.data.length)
                    ],
                  );
                }
                return Container();
              }),
            ],
          )),
    );
  }

  Widget lesson(int id, BuildContext context, String image, String number,
      String title, Color color) {
    return Column(
      children: <Widget>[
        Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Transform.rotate(
                  angle: 3 * pi / 4,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.grey[300],
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.yellow),
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
                  onTap: () async {
                    bool hasInternet =
                        await InternetConnectionChecker().hasConnection;
                    if (hasInternet == false) {
                      showSimpleNotification(
                          const Text(
                            "No internet connection",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          background: Colors.redAccent);
                    } else {
                      context.read<ContentBloc>().add(ContentLoading(id));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ContentPage(
                                    idLesson: id,
                                  )));
                    }
                  },
                  child: CircleAvatar(
                      radius: 35,
                      backgroundColor: color,
                      child: Image.network(
                        image,
                        height: 53,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset("assets/images/egg.png", height: 53),
                      )),
                )
              ],
            ),
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/images/crown.png",
                  height: 34,
                  width: 34,
                ),
                Text(
                  number == "0" ? "" : number,
                  style: const TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                )
              ],
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          overflow: TextOverflow.visible,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        )
      ],
    );
  }

  Widget lessonInkwell() {
    return InkWell(
      onTap: null,
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Transform.rotate(
                    angle: 3 * pi / 4,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.grey[300],
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.yellow),
                      value: 0,
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
                    onTap: null,
                    child: CircleAvatar(
                        radius: 36,
                        backgroundColor: Colors.yellow,
                        child: Image.asset(
                          "assets/images/egg.png",
                          height: 53,
                        )),
                  )
                ],
              ),
              /*Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Image.asset("assets/images/crown.png",height: 34, width: 34,),
                  Text(number=="0"?"":number,style: const TextStyle(color: Colors.deepOrange,fontSize: 13,fontWeight: FontWeight.bold),)
                ],
              )*/
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Locked",
            textAlign: TextAlign.center,
            overflow: TextOverflow.visible,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          )
        ],
      ),
    );
  }

  Widget alphaNumberContainer(
      BuildContext context, String arabic, String french, String urlAudio) {
    return InkWell(
      onTap: () {
        audioPlayer.play(UrlSource(urlAudio));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.black12, width: 2)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                arabic,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryColor),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(french,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
