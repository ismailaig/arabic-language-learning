import 'package:audioplayers/audioplayers.dart';
import 'package:devrnz/bloc/contentBloc/content.event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../bloc/contentBloc/content.bloc.dart';
import '../bloc/contentBloc/content.state.dart';
import '../bloc/enums/EnumEvent.dart';

class ContentPage extends StatelessWidget {

  final audioPlayer = AudioPlayer();
  late ContentBloc contentBloc;

  @override
  Widget build(BuildContext context) {
    contentBloc = BlocProvider.of<ContentBloc>(context);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(58),
          child: BlocBuilder<ContentBloc, ContentState>(
          builder: (context, state) {
            if (state.eventState == EventState.LOADED) {
              return AppBar(
                leading: Builder(
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
                backgroundColor: Colors.white,
                elevation: 1.7,
                title: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: LinearPercentIndicator(
                    padding: const EdgeInsets.only(right: 10),
                    width: 200,
                    lineHeight: 19,
                    percent: state.contents!.data[state.currentContent].attributes.pageNumber/state.contents!.data.length,
                    animation: true,
                    animateFromLastPercent:true,
                    animationDuration: 1000,
                    barRadius: const Radius.circular(120),
                    trailing: Text("${(state.contents!.data[state.currentContent].attributes.pageNumber*100/state.contents!.data.length).round()}%", style: const TextStyle(fontSize: 20, color: Colors.deepOrange),),
                    progressColor: Colors.green,
                  ),
                ),
              );
            }else if(state.eventState == EventState.LOADING){
              return Container();
            }else if(state.eventState == EventState.ERROR){
              return AppBar(title: const Center(child: Text("Not found")));
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
                              children:[
                                Text(state.error,style: const TextStyle(color: Colors.red, fontSize: 22),),
                                ElevatedButton(
                                  onPressed: (){},
                                  child: const Text("Réessayer"),
                                )
                              ]
                            ),
                          );
                        } else if (state.eventState == EventState.LOADING) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if(state.eventState==EventState.LOADED){
                          return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 20.0, left: 6),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () async{
                                            print("Hi"+state.contents!.data[state.currentContent].attributes.imageSong.data[0].attributes.url);
                                            audioPlayer.play(UrlSource(state.contents!.data[state.currentContent].attributes.imageSong.data[0].attributes.url));
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
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Text(state.contents!.data[state.currentContent].attributes.imageName,style: const TextStyle(color:Colors.deepOrange,fontWeight: FontWeight.w400, fontSize: 24),),
                                const SizedBox(height: 40),
                                Text(state.contents!.data[state.currentContent].attributes.nameArFr,style: const TextStyle(color:Colors.deepPurple, fontWeight: FontWeight.w400, fontSize: 24),),
                                const SizedBox(height: 40),
                                Text(state.contents!.data[state.currentContent].attributes.imageNameFr,style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 24),),
                                const SizedBox(height: (60)),
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
                                        backgroundColor: MaterialStateProperty.all<Color>(Colors.deepOrange)
                                    ),
                                    onPressed: (){
                                      if(state.currentContent==(state.contents!.data.length)-1){
                                        Navigator.of(context).pop();
                                      }else{
                                        context.read<ContentBloc>().add(ContentPagination());
                                      }
                                    },
                                    child: const Text("Continuer",style: TextStyle(fontSize: 22)),
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



























