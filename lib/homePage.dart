import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uploader_app/utils/constant.dart';
import 'package:uploader_app/utils/filePicker.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List fileInfo = [];
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "File Uploader App",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.transparent,
        child: Column(children: [
          Container(
            height: height * 0.1,
            width: width,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Color(0xfff1f0ef),
                borderRadius: BorderRadius.circular(16)),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              onPressed: () async {
                setState(() {});
                fileInfo.add(await pickASingleFile());

                setState(() {});

                print(fileInfo);
              },
              child: Center(
                  child: RichText(
                text: const TextSpan(
                    text: "Drag & Drop your files or ",
                    style: TextStyle(color: Color(0xffA7A6A5), fontSize: 16),
                    children: [
                      TextSpan(
                          text: "Browse",
                          style:
                              TextStyle(decoration: TextDecoration.underline))
                    ]),
              )),
            ),
          ),
          Container(
            height: height * 0.72,
            width: width,
            child: ListView.builder(
              itemCount: fileInfo.length,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                    color: kListColor, borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.all(4),
                child: ListTile(
                  title: Text(
                    "${fileInfo[index]["name"]}",
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    "${fileInfo[index]["size"] / 1000} kb",
                    style: TextStyle(color: Colors.grey),
                  ),
                  leading: Image.file(File(fileInfo[index]["path"])),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
