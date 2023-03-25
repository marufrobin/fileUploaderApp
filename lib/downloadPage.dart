import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadPage extends StatefulWidget {
  const DownloadPage({Key? key}) : super(key: key);

  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  TextEditingController textEditingController = TextEditingController();
  String? imageUrl;
  downloadFile() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final baseStorage = await getExternalStorageDirectory();
      final id = await FlutterDownloader.enqueue(
        url: imageUrl!,
        savedDir: baseStorage!.path,
        fileName: imageName,
      );
    } else {
      print("no Permission given for storage");
    }
  }

  int progress = 0;
  String? imageName;

  ReceivePort receivePort = ReceivePort();
  @override
  void initState() {
    // TODO: implement initState
    IsolateNameServer.registerPortWithName(
        receivePort.sendPort, "downloadFile");
    FlutterDownloader.registerCallback(downloadCallBack);
    receivePort.listen((message) {
      setState(() {
        progress = message;
        print("progress : $progress");
      });
    });
    super.initState();
  }

  static downloadCallBack(id, status, progress) {
    SendPort? sendPort = IsolateNameServer.lookupPortByName("downloadFile");
    sendPort!.send(progress);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Download",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: Column(children: [
          TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              hintText: "Download Link",
            ),
          ),
          SizedBox(
            height: height * 0.024,
          ),
          OutlinedButton(
              onPressed: () {
                setState(() {
                  imageUrl = textEditingController.text;
                  List<String> parts = imageUrl!.split("/");
                  print("File name before:$imageName");
                  if (imageName == parts.last) {
                    imageName = parts.last;
                  } else {
                    imageName = "${parts.last}1";
                  }
                  print("File name after:$imageName");

                  downloadFile();
                  receivePort.listen((message) {
                    setState(() {
                      progress = message;
                      print("progress : $progress");
                    });
                  });
                });
                ;
              },
              child: Text("DownLoad")),
          Text("Progress: $progress"),
        ]),
      ),
    );
  }
}
