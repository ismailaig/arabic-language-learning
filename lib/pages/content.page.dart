import 'package:devrnz/bloc/contentBloc/content.event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../bloc/contentBloc/content.bloc.dart';
import '../bloc/contentBloc/content.state.dart';
import '../bloc/enums/EnumEvent.dart';

class ContentPage extends StatefulWidget {


  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(20),
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
                    width: 220,
                    lineHeight: 19,
                    percent: state.contents!.data[state.currentContent].attributes.pageNumber/state.contents!.data.length,
                    animation: true,
                    animationDuration: 500,
                    barRadius: const Radius.circular(120),
                    trailing: Text("${state.contents!.data[state.currentContent].attributes.pageNumber}/${state.contents!.data.length}", style: const TextStyle(fontSize: 20, color: Colors.orange),),
                    progressColor: Colors.green,
                  ),
                ),
              );
            }else if(state.eventState == EventState.LOADING){
              return const CircularProgressIndicator();
            }else if(state.eventState == EventState.ERROR){
              return AppBar(title: const Center(child: Text("Not found")));
            }
            return Container();
          }),
        ),
          body: Expanded(
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
                            Image.network(
                              state.contents!.data[state.currentContent].attributes.image.data[0].attributes.url,
                              width: 200,
                              height: 200,
                            ),
                            const SizedBox(height: 40),
                            Text(state.contents!.data[state.currentContent].attributes.imageName,style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 40),),
                          ],
                        );
                    }
                    return Container();
                  }),
                  const SizedBox(height: (80)),
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
                      onPressed: (){
                        context.read<ContentBloc>().add(ContentPagination());
                      },
                      child: const Text("Memorisé",style: TextStyle(fontSize: 20)),
                    ),
                  )
                ],
            ),
          ),
    );
  }

}



























