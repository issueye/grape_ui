class ResMessage {
	int? code;
	String? message;
	String? requestDatetime;
	String? responseDatetime;
	String? requestId;

	ResMessage({
		this.code, 
		this.message, 
		this.requestDatetime, 
		this.responseDatetime, 
		this.requestId, 
	});

	@override
	String toString() {
		return 'ResMessage(code: $code, message: $message, requestDatetime: $requestDatetime, responseDatetime: $responseDatetime, requestId: $requestId)';
	}

	factory ResMessage.fromJson(Map<String, dynamic> json) => ResMessage(
				code: json['code'] as int?,
				message: json['message'] as String?,
				requestDatetime: json['requestDatetime'] as String?,
				responseDatetime: json['responseDatetime'] as String?,
				requestId: json['requestId'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'code': code,
				'message': message,
				'requestDatetime': requestDatetime,
				'responseDatetime': responseDatetime,
				'requestId': requestId,
			};
}
