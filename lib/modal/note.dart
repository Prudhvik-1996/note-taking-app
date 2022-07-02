import 'package:flutter/material.dart';

class Note {
  int? id;
  String? title;
  String? content;
  int? createdMillis;
  int? lastUpdatedMillis;
  String? colorCode;
  String? status;

  Note({
    this.id,
    this.title,
    this.content,
    this.createdMillis,
    this.lastUpdatedMillis,
    this.colorCode,
    this.status,
  });

  DateTime get createdDate => DateTime.fromMillisecondsSinceEpoch(createdMillis ?? DateTime.now().millisecondsSinceEpoch);

  DateTime get lastUpdatedDate => DateTime.fromMillisecondsSinceEpoch(lastUpdatedMillis ?? DateTime.now().millisecondsSinceEpoch);

  Color get color => colorCode == null ? const Color(0xffffffff) : Color(int.tryParse(colorCode!) ?? 0xffffffff);

  String get noteStatus => status ?? "ACTIVE";

  Note.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    title = json['title']?.toString();
    content = json['content']?.toString();
    createdMillis = json['createdMillis']?.toInt();
    lastUpdatedMillis = json['lastUpdatedMillis']?.toInt();
    colorCode = json['colorCode']?.toString();
    status = json['status']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['content'] = content;
    data['createdMillis'] = createdMillis;
    data['lastUpdatedMillis'] = lastUpdatedMillis;
    data['colorCode'] = colorCode;
    data['status'] = status;
    return data;
  }

  Note copy() {
    return Note.fromJson(toJson());
  }

  @override
  int get hashCode {
    return id ?? 0;
  }

  @override
  bool operator ==(Object other) {
    return hashCode == other.hashCode;
  }
}
