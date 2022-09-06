import 'package:flutter/material.dart';

class OpenImageWidget extends StatefulWidget {
  String path;
   OpenImageWidget({Key? key,required this.path}) : super(key: key);

  @override
  _OpenImageWidgetState createState() => _OpenImageWidgetState();
}

class _OpenImageWidgetState extends State<OpenImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image "),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: Image.network(
        widget.path,
        width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,)
    );
  }
}
