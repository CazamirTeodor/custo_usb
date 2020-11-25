import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import './binary.dart';

class BinariesList extends StatefulWidget {
  List<String> list;
  Function updateBinaryFunction;

  BinariesList({this.list, this.updateBinaryFunction});

  @override
  _BinariesListState createState() => _BinariesListState();
}

class _BinariesListState extends State<BinariesList> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    widget.list.sort((a,b){ return a.compareTo(b);});
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            width: 120,
            height: 20,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search...",
              ),
              textAlign: TextAlign.center,
              cursorHeight: 11,
              style: kTextStyle(kColor: Colors.black),
              controller: _controller,
              onChanged: (val) {
                // update binaries list if the name is not empty
              },
            )),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          margin: EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.black),
          width: 200,
          height: 170,
          child: GridView.count(
            childAspectRatio: 2,
            crossAxisCount: 3,
            mainAxisSpacing: 3,
            crossAxisSpacing: 7,
            padding: EdgeInsets.all(5),
            children:
                this.widget.list.map((e) => Binary(name: e)).toList(),
          ),
        ),
      ],
    );
  }
}