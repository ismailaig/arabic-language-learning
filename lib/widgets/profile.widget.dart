import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final VoidCallback onClicked;
  final String imagePath;
  final String mode;

  const ProfileWidget(
      {Key? key,
      required this.onClicked,
      required this.imagePath,
      required this.mode})
      : super(key: key);

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

  Widget buildImage() {
    final image;
    if (mode == "network") {
      image = Image.network(imagePath,
          width: 155,
          height: 155,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Image.asset(
              "assets/images/profile.jpg",
              width: 155,
              height: 155,
              fit: BoxFit.cover));
    } else {
      image =
          Image.asset(imagePath, width: 155, height: 155, fit: BoxFit.cover);
    }
    return ClipOval(
      child: Material(
          color: Colors.transparent,
          child: InkWell(onTap: onClicked, child: image)),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: const Icon(
            Icons.add_a_photo,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle(
          {required Widget child, required double all, required Color color}) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
