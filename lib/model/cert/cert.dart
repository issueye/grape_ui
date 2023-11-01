import 'package:go_grape_ui/model/base_model.dart';

import 'datum.dart';

class Cert extends BaseModel {
  int? code;
  String? message;
  String? requestDatetime;
  String? responseDatetime;
  String? requestId;
  List<Datum>? data;

  Cert({
    this.code,
    this.message,
    this.requestDatetime,
    this.responseDatetime,
    this.requestId,
    this.data,
  });

  @override
  String toString() {
    return 'Cert(code: $code, message: $message, requestDatetime: $requestDatetime, responseDatetime: $responseDatetime, requestId: $requestId, data: $data)';
  }

  factory Cert.fromJson(Map<String, dynamic> json) => Cert(
        code: json['code'] as int?,
        message: json['message'] as String?,
        requestDatetime: json['requestDatetime'] as String?,
        responseDatetime: json['responseDatetime'] as String?,
        requestId: json['requestId'] as String?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'message': message,
        'requestDatetime': requestDatetime,
        'responseDatetime': responseDatetime,
        'requestId': requestId,
        'data': data?.map((e) => e.toJson()).toList(),
      };

  @override
  Map<String, dynamic> getByIndex(int index) {
    return data![index].toJson();
  }

  @override
  int len() {
    if (data == null) return 0;
    return data!.length;
  }
}
