class Datum {
	String? id;
	DateTime? createdAt;
	DateTime? updatedAt;
	String? name;
	String? portId;
	int? nodeType;
	String? target;
	String? pagePath;
	String? mark;

	Datum({
		this.id, 
		this.createdAt, 
		this.updatedAt, 
		this.name, 
		this.portId, 
		this.nodeType, 
		this.target, 
		this.pagePath, 
		this.mark, 
	});

	@override
	String toString() {
		return 'Datum(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, name: $name, portId: $portId, nodeType: $nodeType, target: $target, pagePath: $pagePath, mark: $mark)';
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
				nodeType: json['nodeType'] as int?,
				target: json['target'] as String?,
				pagePath: json['pagePath'] as String?,
				mark: json['mark'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'createdAt': createdAt?.toIso8601String(),
				'updatedAt': updatedAt?.toIso8601String(),
				'name': name,
				'portId': portId,
				'nodeType': nodeType,
				'target': target,
				'pagePath': pagePath,
				'mark': mark,
			};
}
