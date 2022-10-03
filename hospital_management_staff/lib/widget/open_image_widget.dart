import 'package:flutter/material.dart';
import 'package:hospital_management_staff/core/strings/strings.dart';
import 'package:hospital_management_staff/utils/colors.dart';
import 'package:share_plus/share_plus.dart';

class OpenImageWidget extends StatefulWidget {
  String path;
   OpenImageWidget({Key? key,required this.path}) : super(key: key);

  @override
  _OpenImageWidgetState createState() => _OpenImageWidgetState();
}

class _OpenImageWidgetState extends State<OpenImageWidget> {


  void _onShare({BuildContext? context,String? path}) async {
    final box = context!.findRenderObject() as RenderBox?;

    if (path!.isNotEmpty) {
      await Share.share(path,
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.colorDarkBlue,
        title: Text(Strings.kImage),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              _onShare(
                context: context,
                path: widget.path
              );
            },
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
