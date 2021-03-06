import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../models/configuration.dart';

class BinaryWidget extends StatefulWidget {
  String name;
  double dimension;

  Stream<List<BinaryWidget>> selectedBinariesStream;

  BinaryWidget({this.name});

  @override
  _BinaryWidgetState createState() => _BinaryWidgetState();
}

class _BinaryWidgetState extends State<BinaryWidget> {
  bool status = false;
  var config = Configuration();
  

  @override
  void initState()
  {
    widget.selectedBinariesStream = config.binariesController.stream;
    super.initState();
    widget.selectedBinariesStream.listen((list) {
      if(list.contains(this.widget))
      {
        setState(() {
          status = true;
        });
      }
      else
      {
        setState(() {
          status = false;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.name,
      waitDuration: Duration(milliseconds: 500),
      child: RaisedButton(
        color: status ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Colors.white, width: 0.7)),
        child: Text(
          widget.name.replaceAll('-', '\u2011'),
          style: kTextStyle(kColor: status ? Colors.black : Colors.white),
          maxLines: 1,
        ),
        visualDensity: VisualDensity(vertical: 1.5, horizontal: -3),
        mouseCursor: MouseCursor.defer,
        onPressed: () {
          setState(() {
            status = !status;
            config.updateParameter(parameter: "binaries", binary: widget);
          });
        },
      ),
    );
  }
}
