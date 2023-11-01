class Datum {
	String? id;
	DateTime? createdAt;
	DateTime? updatedAt;
	String? name;
	String? portId;
	String? nodeId;
	int? matchType;
	String? mark;
	int? port;

	Datum({
		this.id, 
		this.createdAt, 
		this.updatedAt, 
		this.name, 
		this.portId, 
		this.nodeId, 
		this.matchType, 
		this.mark, 
		this.port, 
	});

	@override
	String toString() {
		return 'Datum(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, name: $name, portId: $portId, nodeId: $nodeId, matchType: $matchType, mark: $mark, port: $port)';
	}

	factory Datum.fromJson(Map<String, dynamic> json) => Datum(
				id: json['id'] as String?,
				createdAt: json['createdAt'] == null
						? null
						: DateTime.parse(json['createdAt'] as String),
				updatedAt: json['updatedAt'] == null
						? null
						: DateTime.parse(json['updatedAt'] as String),
				name: json['name'] as String?,
				portId: json['portId'] as String?,
				nodeId: json['nodeId'] as String?,
				matchType: json['matchType'] as int?,
				mark: json['mark'] as String?,
				port: json['port'] as int?,
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'createdAt': createdAt?.toIso8601String(),
				'updatedAt': updatedAt?.toIso8601String(),
				'name': name,
				'portId': portId,
				'nodeId': nodeId,
				'matchType': matchType,
				'mark': mark,
				'port': port,
			};
}
