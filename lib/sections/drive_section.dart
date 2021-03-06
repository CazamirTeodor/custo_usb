import 'package:custo_usb/models/configuration.dart';
import 'package:custo_usb/widgets/dropdown_button.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import '../constants.dart';
import '../widgets/dropdown_button.dart';

class DriveSection extends StatelessWidget {
  var config = Configuration();

  String selectedDrive;
  List<String> drives = List<String>();

  @override
  Widget build(BuildContext context) {
    drives = [];
    getDrives();
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Drive: ", style: kTextStyle(kColor: Colors.black)),
          Padding(padding: EdgeInsets.only(right: 10)),
          MyDropdownButton(options: drives, updateParameter: "drive"),
        ],
      ),
    );
  }

  void getDrives() {
    var temp = Process.runSync('df', ["-P"]).stdout.toString().split("\n");

    temp.removeWhere((element) => !element.contains(new RegExp(r'/dev')));

    if (Platform.isLinux) {
      temp.forEach((element) {
        element.trim();
        var list = element.split(" ");
        list.removeWhere((element) => element == "");

        if (list[5].startsWith("/media/")) {
          StringBuffer to_add = StringBuffer();
          to_add.write(list[5].substring(list[5].lastIndexOf("/") + 1));

          if (list.length > 6) {
            for (int i = 6; i < list.length; i++) to_add.write(" " + list[i]);
          }

          drives.add(to_add.toString());
          return;
        }
      });
    }
  }
}
