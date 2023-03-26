/*
pickASingleFile() async {
  Map<String, dynamic> listOfPickFile;
  FilePickerResult? result =
      await FilePicker.platform.pickFiles(allowMultiple: false);
  if (result != null) {
    File file = File(result.files.single.path!);
*/
/*
    if (kDebugMode) {
      print(file.);
      print(file.size);
      print(file.bytes);
      print(file.extension);
      print(file.path);
      print(file.identifier);
      // print(listOfPickFile);
    }*/ /*

    listOfPickFile = {
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
    }
  } else {
    if (kDebugMode) {
      print("Gowa Mara Kha");
    }
  }
}
*/
