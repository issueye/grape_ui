class Datum {
	String? id;
	DateTime? createdAt;
	DateTime? updatedAt;
	int? port;
	bool? state;
	bool? isTls;
	String? certId;
	String? mark;

	Datum({
		this.id, 
		this.createdAt, 
		this.updatedAt, 
		this.port, 
		this.state, 
		this.isTls, 
		this.certId, 
		this.mark, 
	});

	@override
	String toString() {
		return 'Datum(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, port: $port, state: $state, isTls: $isTls, certId: $certId, mark: $mark)';
	}

	factory Datum.fromJson(Map<String, dynamic> json) => Datum(
				id: json['id'] as String?,
				createdAt: json['createdAt'] == null
						? null
						: DateTime.parse(json['createdAt'] as String),
				updatedAt: json['updatedAt'] == null
						? null
						: DateTime.parse(json['updatedAt'] as String),
				port: json['port'] as int?,
				state: json['state'] as bool?,
				isTls: json['isTLS'] as bool?,
				certId: json['certId'] as String?,
				mark: json['mark'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'createdAt': createdAt?.toIso8601String(),
				'updatedAt': updatedAt?.toIso8601String(),
				'port': port,
				'state': state,
				'isTLS': isTls,
				'certId': certId,
				'mark': mark,
			};
}
