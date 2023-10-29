import 'dart:convert';

import 'datum.dart';

class RepoList {
	int? code;
	String? message;
	String? requestDatetime;
	String? responseDatetime;
	String? requestId;
	List<Datum>? data;

	RepoList({
		this.code, 
		this.message, 
		this.requestDatetime, 
		this.responseDatetime, 
		this.requestId, 
		this.data, 
	});

	@override
	String toString() {
		return 'RepoList(code: $code, message: $message, requestDatetime: $requestDatetime, responseDatetime: $responseDatetime, requestId: $requestId, data: $data)';
	}

	factory RepoList.fromMap(Map<String, dynamic> data) => RepoList(
				code: data['code'] as int?,
				message: data['message'] as String?,
				requestDatetime: data['requestDatetime'] as String?,
				responseDatetime: data['responseDatetime'] as String?,
				requestId: data['requestId'] as String?,
				data: (data['data'] as List<dynamic>?)
						?.map((e) => Datum.fromMap(e as Map<String, dynamic>))
						.toList(),
			);

	Map<String, dynamic> toMap() => {
				'code': code,
				'message': message,
				'requestDatetime': requestDatetime,
				'responseDatetime': responseDatetime,
				'requestId': requestId,
				'data': data?.map((e) => e.toMap()).toList(),
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [RepoList].
	factory RepoList.fromJson(String data) {
		return RepoList.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [RepoList] to a JSON string.
	String toJson() => json.encode(toMap());

	RepoList copyWith({
		int? code,
		String? message,
		String? requestDatetime,
		String? responseDatetime,
		String? requestId,
		List<Datum>? data,
	}) {
		return RepoList(
			code: code ?? this.code,
			message: message ?? this.message,
			requestDatetime: requestDatetime ?? this.requestDatetime,
			responseDatetime: responseDatetime ?? this.responseDatetime,
			requestId: requestId ?? this.requestId,
			data: data ?? this.data,
		);
	}
}
