import 'package:dio/dio.dart';

class CustomHttp {
  static uploadFile(String filePath, String fileName) async {
    /*FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: false);

    File file = File(result!.files.single.path!);
    print("file::: name ${file.path}");*/
    final dio = Dio();
    String uploadUrl = "https://api.cloudinary.com/v1_1/djwjyopfv/image/upload";

    print("File path frommmmmmmmm: $filePath");
    try {
      final fromData = FormData.fromMap({
        "file": await MultipartFile.fromFile(filePath, filename: "robin"),
        "upload_preset": "cndirnd5"
      });
      final responce = await dio.post(
        uploadUrl,
        data: fromData,
        onSendProgress: (int sent, int total) {
          print("Upload: ${sent}, Total: ${total}");
        },
      );
      print("Responce::::${responce}");
    } catch (e) {
      print(e);
    }
  }
}
