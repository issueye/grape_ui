import 'dart:convert';

import 'datum.dart';
import 'page_info.dart';

class VersionInfo {
	int? code;
	String? message;
	String? requestDatetime;
	String? responseDatetime;
	String? requestId;
	PageInfo? pageInfo;
	List<Datum>? data;

	VersionInfo({
		this.code, 
		this.message, 
		this.requestDatetime, 
		this.responseDatetime, 
		this.requestId, 
		this.pageInfo, 
		this.data, 
	});

	@override
	String toString() {
		return 'VersionInfo(code: $code, message: $message, requestDatetime: $requestDatetime, responseDatetime: $responseDatetime, requestId: $requestId, pageInfo: $pageInfo, data: $data)';
	}

	factory VersionInfo.fromMap(Map<String, dynamic> data) => VersionInfo(
				code: data['code'] as int?,
				message: data['message'] as String?,
				requestDatetime: data['requestDatetime'] as String?,
				responseDatetime: data['responseDatetime'] as String?,
				requestId: data['requestId'] as String?,
				pageInfo: data['pageInfo'] == null
						? null
						: PageInfo.fromMap(data['pageInfo'] as Map<String, dynamic>),
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
				'pageInfo': pageInfo?.toMap(),
				'data': data?.map((e) => e.toMap()).toList(),
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [VersionInfo].
	factory VersionInfo.fromJson(String data) {
		return VersionInfo.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [VersionInfo] to a JSON string.
	String toJson() => json.encode(toMap());

	VersionInfo copyWith({
		int? code,
		String? message,
		String? requestDatetime,
		String? responseDatetime,
		String? requestId,
		PageInfo? pageInfo,
		List<Datum>? data,
	}) {
		return VersionInfo(
			code: code ?? this.code,
			message: message ?? this.message,
			requestDatetime: requestDatetime ?? this.requestDatetime,
			responseDatetime: responseDatetime ?? this.responseDatetime,
			requestId: requestId ?? this.requestId,
			pageInfo: pageInfo ?? this.pageInfo,
			data: data ?? this.data,
		);
	}
}
