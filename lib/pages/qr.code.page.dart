import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodePage extends StatefulWidget {
  const QRCodePage({Key? key}) : super(key: key);

  @override
  State<QRCodePage> createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  final TextEditingController _controller = TextEditingController();
  String data = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: const Text('QR Code Generate', style: TextStyle(color: Colors.white),),
          iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: QrImage(
              data: data,
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                maxLines: 9,
                decoration: InputDecoration(
                    hintText: "Enter a text to generate QR Code",
                    border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1))),
                controller: _controller,
                onChanged: (value) {
                  setState(() {
                    data = value;
                  });
                },
              ),
            ),
          )
        ],
      ),
      /*floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              child: const Icon(Icons.qr_code_2_outlined, color: Colors.white,),
              onPressed: () {}
          )
        ],
      ),*/
    );
  }
}
