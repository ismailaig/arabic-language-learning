import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ContentPage extends StatefulWidget {

  final String imageName;
  final String imagePath;
  final int pageNumber;
  final int contentsLength;

  const ContentPage({required this.imagePath, required this.imageName, required this.contentsLength, required this.pageNumber});

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
                percent: widget.pageNumber/widget.contentsLength,
                animation: true,
                animationDuration: 500,
                barRadius: const Radius.circular(120),
                trailing: Text("${widget.pageNumber}/${widget.contentsLength}", style: const TextStyle(fontSize: 20, color: Colors.orange),),
                progressColor: Colors.green,
              ),
            ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(80.0),
          child: Center(
            child: Column(
              children: [
                Container(
                    child:Expanded(
                      child: Column(
                        children: [
                          Image.asset(
                            widget.imagePath,
                            width: 200,
                            height: 200,
                          ),
                          SizedBox(height: 40),
                          Text("${widget.imageName}",style: TextStyle(fontWeight: FontWeight.w300, fontSize: 40),),
                          SizedBox(height: 100),
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

                              },
                              child: Text("Memorisé",style: TextStyle(fontSize: 20)),
                            ),
                          )
                        ],
                      ),
                    ),
                ),
              ],
            ),
          ),
        )
    );
  }

}




