// To parse this JSON data, do
//
//     final uploadModel = uploadModelFromJson(jsonString);

import 'dart:convert';

UploadModel uploadModelFromJson(String str) =>
    UploadModel.fromJson(json.decode(str));

String uploadModelToJson(UploadModel data) => json.encode(data.toJson());

class UploadModel {
  UploadModel({
    required this.assetId,
    required this.publicId,
    required this.version,
    required this.versionId,
    required this.signature,
    required this.width,
    required this.height,
    required this.format,
    required this.resourceType,
    required this.createdAt,
    required this.tags,
    required this.bytes,
    required this.type,
    required this.etag,
    required this.placeholder,
    required this.url,
    required this.secureUrl,
    required this.folder,
    required this.accessMode,
    required this.originalFilename,
  });

  String assetId;
  String publicId;
  int version;
  String versionId;
  String signature;
  int width;
  int height;
  String format;
  String resourceType;
  DateTime createdAt;
  List<dynamic> tags;
  int bytes;
  String type;
  String etag;
  bool placeholder;
  String url;
  String secureUrl;
  String folder;
  String accessMode;
  String originalFilename;

  factory UploadModel.fromJson(Map<String, dynamic> json) => UploadModel(
        assetId: json["asset_id"],
        publicId: json["public_id"],
        version: json["version"],
        versionId: json["version_id"],
        signature: json["signature"],
        width: json["width"],
        height: json["height"],
        format: json["format"],
        resourceType: json["resource_type"],
        createdAt: DateTime.parse(json["created_at"]),
        tags: List<dynamic>.from(json["tags"].map((x) => x)),
        bytes: json["bytes"],
        type: json["type"],
        etag: json["etag"],
        placeholder: json["placeholder"],
        url: json["url"],
        secureUrl: json["secure_url"],
        folder: json["folder"],
        accessMode: json["access_mode"],
        originalFilename: json["original_filename"],
      );

  Map<String, dynamic> toJson() => {
        "asset_id": assetId,
        "public_id": publicId,
        "version": version,
        "version_id": versionId,
        "signature": signature,
        "width": width,
        "height": height,
        "format": format,
        "resource_type": resourceType,
        "created_at": createdAt.toIso8601String(),
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "bytes": bytes,
        "type": type,
        "etag": etag,
        "placeholder": placeholder,
        "url": url,
        "secure_url": secureUrl,
        "folder": folder,
        "access_mode": accessMode,
        "original_filename": originalFilename,
      };
}
