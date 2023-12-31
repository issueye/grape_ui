import 'package:go_grape_ui/model/base_model.dart';
import 'datum.dart';

class Node extends BaseModel {
	int? code;
	String? message;
	String? requestDatetime;
	String? responseDatetime;
	String? requestId;
	List<Datum>? data;

	Node({
		this.code, 
		this.message, 
		this.requestDatetime, 
		this.responseDatetime, 
		this.requestId, 
		this.data, 
	});

	@override
	String toString() {
		return 'Node(code: $code, message: $message, requestDatetime: $requestDatetime, responseDatetime: $responseDatetime, requestId: $requestId, data: $data)';
	}

	factory Node.fromJson(Map<String, dynamic> json) => Node(
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
        // ignore: avoid_renaming_method_parameters
        Map<String, dynamic> getByIndex(int index) {
          return data![index].toJson();
        }
      
        @override
        int len() {
          if (data == null) return 0;
          return data!.length;
        }
}
