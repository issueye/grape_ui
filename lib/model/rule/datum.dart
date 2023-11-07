class Datum {
	String? id;
	DateTime? createdAt;
	DateTime? updatedAt;
	String? name;
  String? method;
	String? portId;
	String? nodeId;
  String? targetId;
  String? node;
  String? target;
  String? targetRoute;
	int? matchType;
	String? mark;
	int? port;

	Datum({
		this.id, 
		this.createdAt, 
		this.updatedAt, 
		this.name, 
    this.method,
		this.portId, 
		this.nodeId, 
    this.targetId,
    this.node,
    this.target,
    this.targetRoute,
		this.matchType, 
		this.mark, 
		this.port, 
	});

	@override
	String toString() {
		return 'Datum(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, name: $name, method: $method, portId: $portId, nodeId: $nodeId, targetId: $targetId, node: $node, target: $target, targetRoute: $targetRoute, matchType: $matchType, mark: $mark, port: $port)';
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
        method: json['method'] as String?,
				portId: json['portId'] as String?,
				nodeId: json['nodeId'] as String?,
        targetId: json['targetId'] as String?,
        node: json['node'] as String?,
        target: json['target'] as String?,
        targetRoute: json['targetRoute'] as String?,
				matchType: json['matchType'] as int?,
				mark: json['mark'] as String?,
				port: json['port'] as int?,
			);

	Map<String, dynamic> toJson() => { 
				'id': id,
				'createdAt': createdAt?.toIso8601String(),
				'updatedAt': updatedAt?.toIso8601String(),
				'name': name,
        'method': method,
				'portId': portId,
				'nodeId': nodeId,
        'targetId': targetId,
        'node': node,
        'target': target,
        'targetRoute': targetRoute,
				'matchType': matchType,
				'mark': mark,
				'port': port,
			};
}
