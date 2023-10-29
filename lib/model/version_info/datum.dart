import 'dart:convert';

class Datum {
	String? id;
	String? repoId;
	String? appName;
	String? tag;
	String? version;
	int? internalVersion;
	int? versionX;
	int? versionY;
	int? versionZ;
	String? createAt;
	String? branch;
	String? commitHash;
	String? content;

	Datum({
		this.id, 
		this.repoId, 
		this.appName, 
		this.tag, 
		this.version, 
		this.internalVersion, 
		this.versionX, 
		this.versionY, 
		this.versionZ, 
		this.createAt, 
		this.branch, 
		this.commitHash, 
		this.content, 
	});

	@override
	String toString() {
		return 'Datum(id: $id, repoId: $repoId, appName: $appName, tag: $tag, version: $version, internalVersion: $internalVersion, versionX: $versionX, versionY: $versionY, versionZ: $versionZ, createAt: $createAt, branch: $branch, commitHash: $commitHash, content: $content)';
	}

	factory Datum.fromMap(Map<String, dynamic> data) => Datum(
				id: data['id'] as String?,
				repoId: data['repo_id'] as String?,
				appName: data['app_name'] as String?,
				tag: data['tag'] as String?,
				version: data['version'] as String?,
				internalVersion: data['internal_version'] as int?,
				versionX: data['version_x'] as int?,
				versionY: data['version_y'] as int?,
				versionZ: data['version_z'] as int?,
				createAt: data['create_at'] as String?,
				branch: data['branch'] as String?,
				commitHash: data['commit_hash'] as String?,
				content: data['content'] as String?,
			);

	Map<String, dynamic> toMap() => {
				'id': id,
				'repo_id': repoId,
				'app_name': appName,
				'tag': tag,
				'version': version,
				'internal_version': internalVersion,
				'version_x': versionX,
				'version_y': versionY,
				'version_z': versionZ,
				'create_at': createAt,
				'branch': branch,
				'commit_hash': commitHash,
				'content': content,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Datum].
	factory Datum.fromJson(String data) {
		return Datum.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [Datum] to a JSON string.
	String toJson() => json.encode(toMap());

	Datum copyWith({
		String? id,
		String? repoId,
		String? appName,
		String? tag,
		String? version,
		int? internalVersion,
		int? versionX,
		int? versionY,
		int? versionZ,
		String? createAt,
		String? branch,
		String? commitHash,
		String? content,
	}) {
		return Datum(
			id: id ?? this.id,
			repoId: repoId ?? this.repoId,
			appName: appName ?? this.appName,
			tag: tag ?? this.tag,
			version: version ?? this.version,
			internalVersion: internalVersion ?? this.internalVersion,
			versionX: versionX ?? this.versionX,
			versionY: versionY ?? this.versionY,
			versionZ: versionZ ?? this.versionZ,
			createAt: createAt ?? this.createAt,
			branch: branch ?? this.branch,
			commitHash: commitHash ?? this.commitHash,
			content: content ?? this.content,
		);
	}
}
