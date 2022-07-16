import 'package:audioplayers/audioplayers.dart';
import 'package:aget_arabic/bloc/contentBloc/content.event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../bloc/contentBloc/content.bloc.dart';
import '../bloc/contentBloc/content.state.dart';
import '../bloc/enums/EnumEvent.dart';

class ContentPage extends StatefulWidget {


  final int idLesson;

  const ContentPage({Key? key, required this.idLesson}) : super(key: key);

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  late ContentBloc contentBloc;

  final audioPlayer = AudioPlayer();
  final url = "";


  _playSound(String url){
    AudioPlayer().play(UrlSource(url));
  }

  _pauseSound(){
    AudioPlayer().pause();
  }

  @override
  Widget build(BuildContext context) {
    contentBloc = BlocProvider.of<ContentBloc>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(58),
          child: BlocBuilder<ContentBloc, ContentState>(
          builder: (context, state) {
            if (state.eventState == EventState.LOADED) {
              return AppBar(
                titleSpacing: 5.0,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Builder(
                      builder: (BuildContext context) {
                        return IconButton(
                          icon: const Icon(
                              Icons.close, color: Colors.grey, size: 40),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        );
                      }
                  ),
                ),
                backgroundColor: Colors.white,
                elevation: 1.5,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: LinearPercentIndicator(
                        padding: const EdgeInsets.only(right: 12),
                        width: 200,
                        lineHeight: 19,
                        percent: state.contents!.data[state.currentContent].attributes.pageNumber/state.contents!.data.length,
                        animation: true,
                        animateFromLastPercent:true,
                        animationDuration: 1000,
                        barRadius: const Radius.circular(120),
                        trailing: Text("${(state.contents!.data[state.currentContent].attributes.pageNumber*100/state.contents!.data.length).round()}%", style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w400, color: Colors.orange),),
                        progressColor: Colors.green,
                      ),
                    ),
                    /*Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset("assets/images/crown.png", height: 33,
                              width: 33,),
                            Text("${state.contents!.data[state.currentContent].attributes.pageNumber}",
                              style: const TextStyle(color: Colors.orange,
                                  fontSize: 18),)
                          ],
                      ),
                    ),*/
                  ],
                )
              );
            }else if(state.eventState == EventState.LOADING){
              return Container();
            }
            return Container();
          }),
        ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                  children: [
                    BlocBuilder<ContentBloc, ContentState>(
                      builder: (context, state) {
                        if(state.eventState == EventState.ERROR) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children:[
                                const Text("Error connexion. Try to connect",textAlign: TextAlign.center, overflow: TextOverflow.visible, style: TextStyle(color: Colors.red, fontSize: 22),),
                                const SizedBox(height: 15,),
                                ElevatedButton(
                                  onPressed: (){
                                    context.read<ContentBloc>().add(ContentLoading(widget.idLesson));
                                  },
                                  child: const Text("Retry", style: TextStyle(color: Colors.white),),
                                )
                              ]
                            ),
                          );
                        } else if (state.eventState == EventState.LOADING) {
                          return Center(
                            child: SpinKitFadingCircle(
                              color: Theme.of(context).primaryColor,
                              size: 50.0,
                            ),
                          );
                        } else if(state.eventState == EventState.LOADED){
                          _playSound(state.contents!.data[state.currentContent].attributes.imageSong.data[0].attributes.url);
                          return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 20.0, left: 6),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          _playSound(state.contents!.data[state.currentContent].attributes.imageSong.data[0].attributes.url);
                                        },
                                        child: Image.asset(
                                            "assets/images/sound.png",
                                          width: 50,
                                          height: 50,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 40,
                                      ),
                                      Image.network(
                                        state.contents!.data[state.currentContent].attributes.image.data[0].attributes.url,
                                        width: 150,
                                        height: 230,
                                        errorBuilder: (context, error, stackTrace) => Image.asset("assets/images/egg.png",height: 230, width: 150,),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 80,
                                      child: Text(state.contents!.data[state.currentContent].attributes.imageName, textAlign: TextAlign.center, overflow: TextOverflow.visible, style: const TextStyle(color:Colors.orange, fontWeight: FontWeight.w300, fontSize: 24)),
                                    ),
                                    SizedBox(
                                      height: 80,
                                      child: Text(state.contents!.data[state.currentContent].attributes.nameArFr, textAlign: TextAlign.center, overflow: TextOverflow.visible, style: const TextStyle(color:Colors.deepPurple, fontSize: 22),),
                                    ),
                                    SizedBox(
                                      height: 80,
                                      child: Text(state.contents!.data[state.currentContent].attributes.imageNameFr, textAlign: TextAlign.center, overflow: TextOverflow.visible, style: const TextStyle(fontSize: 22),),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                SizedBox(
                                  width: 300,
                                  height: 50,
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
                                      if(state.currentContent==(state.contents!.data.length)-1){
                                        Navigator.of(context).pop();
                                      }else{
                                        _pauseSound();
                                        context.read<ContentBloc>().add(ContentPagination());
                                      }
                                    },
                                    child: const Text("Continue",style: TextStyle(color: Colors.white, fontSize: 22)),
                                  ),
                                )
                              ],
                            );
                        }
                        return Container();
                      })
                    ],
                ),
            ),
          ),
    );
  }
}



























