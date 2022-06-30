import 'package:devrnz/bloc/contentBloc/content.bloc.dart';
import 'package:devrnz/bloc/enums/EnumEvent.dart';
import 'package:devrnz/pages/content.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/contentBloc/content.state.dart';


class PageContent extends StatefulWidget {
  const PageContent({Key? key}) : super(key: key);

  @override
  State<PageContent> createState() => _PageContentState();
}

class _PageContentState extends State<PageContent> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContentBloc, ContentState>(
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
          } else if(state.eventState==EventState.LOADED) {
            return ListView.separated(
                  itemBuilder: (context, index) {
                    return ContentPage(imageName: state.contents!.data[index].attributes.imageName,
                        imagePath: state.contents!.data[index].attributes.image.data[0].attributes.url,
                        contentsLength: state.contents!.meta.pagination.total,
                    pageNumber: state.contents!.data[index].attributes.pageNumber,);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 40);
                  },
                  itemCount: state.contents!.data.length
            );
          }
          return Container();
        }
    );
  }
}