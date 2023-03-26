import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uploader_app/Model/uploadModel.dart';
import 'package:uploader_app/appConfig/customHttp.dart';
import 'package:uploader_app/downloadPage.dart';
import 'package:uploader_app/utils/constant.dart';

class UploadPage extends StatefulWidget {
  UploadPage({Key? key}) : super(key: key);

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  List listOfUploaded = [];
  UploadModel? uploadModel;

  List fileInfo = [];
  bool isDownloadCom = false;
  pickASingleFile() async {
    Map<String, dynamic> listOfPickFile;
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: false);
    print("result: $result");

    if (result != null) {
      File file = File(result.files.single.path!);
      print("file Path:${file.path}");
      // listOfPickFile = {
      //   "name": file.name,
      //   "size": file.size,
      //   "path": file.path,
      //   "ext": file.extension!
      // };

      fileInfo.add(file.path);
      listOfUploaded.add("");
      setState(() {});
/*
    if (kDebugMode) {
      print(file.);
      print(file.size);
      print(file.bytes);
      print(file.extension);
      print(file.path);
      print(file.identifier);
      // print(listOfPickFile);
    }*/
      /* listOfPickFile = {
        // "name": file.name,
        // "size": file.size,
        "path": file.path,
        // "ext": file.extension!
      };
      List fileInfo = [];
      // fileInfo.add(listOfPickFile);
      if (file.path == null) {
        return null;
      } else {
        return listOfPickFile;
      }*/
    } else {
      if (kDebugMode) {
        print("Gowa Mara Kha");
      }
    }
  }

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
                // fileInfo!.add(await pickASingleFile());
                pickASingleFile();
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
            height: height * 0.6,
            width: width,
            child: fileInfo.isEmpty == false
                ? ListView.builder(
                    itemCount: fileInfo.length,
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      print("Index$index");
                      print("IndeLength ${fileInfo.length}");
                      // File file = fileInfo[index];
                      print(fileInfo);
                      return Container(
                        decoration: BoxDecoration(
                            color: kListColor,
                            borderRadius: BorderRadius.circular(10)),
                        margin: const EdgeInsets.all(4),
                        child: ListTile(
                          title: Text(
                            "${fileInfo[index].split("/").last}",
                            style: TextStyle(color: Colors.white),
                          ),
                          /*subtitle: Text(
                            "${(fileInfo[index].lengthSync() / 1024).toStringAsFixed(2).toString()} KB",
                            style: TextStyle(color: Colors.grey),
                          ),*/
                          leading: Text(
                              "${fileInfo[index].split("/").last.toString().split(".").last}"),
                          trailing: listOfUploaded.isEmpty ||
                                  fileInfo[index] != listOfUploaded[index]
                              ? IconButton(
                                  onPressed: () async {
                                    uploadModel = await CustomHttp.uploadFile(
                                        fileInfo[index], "robin1");
                                    // listOfUpload.add(uploadModel);
                                    setState(() {});
                                    print(
                                        "Upload Model: ${uploadModel!.secureUrl}");

                                    setState(() {
                                      fileInfo[index] = uploadModel!.secureUrl;
                                      listOfUploaded[index] =
                                          uploadModel!.secureUrl;
                                    });
                                    print("file Info with new link${fileInfo}");
                                  },
                                  icon: Icon(Icons.upload_rounded))
                              : IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DownloadPage(
                                              downloadLink: fileInfo[index]),
                                        ));
                                  },
                                  icon: Icon(Icons.download)),
                        ),
                      );
                    })
                : Text(""),
          ),
        ]),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // fileInfo.clear();
      //     // listOfUploaded.clear();
      //     print('list of Uploaded:$listOfUploaded');
      //     print('list :$fileInfo');
      //     setState(() {});
      //   },
      // ),
    );
  }
}
