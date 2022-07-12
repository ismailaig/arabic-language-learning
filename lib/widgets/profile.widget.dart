import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {

  final VoidCallback onClicked;
  final String imagePath;
  final String mode;

  const ProfileWidget({
    Key?key,
    required this.onClicked,
    required this.imagePath,
    required this.mode
  }):super(key: key);


  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color),
          )
        ],
      ),
    );
  }

  Widget buildImage(){
    final image;
    if(mode=="network"){
      image = NetworkImage(imagePath);
    }else{
      image = AssetImage(imagePath);
    }
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
            image: image,
            fit: BoxFit.cover,
            width: 155,
            height: 155,
            child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
    color : Colors.white,
    all:3,
    child: buildCircle(
      color :color,
      all:8,
      child:const Icon(
        Icons.add_a_photo,
        color: Colors.white,
        size: 20,
      ),
    ),
  );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}



