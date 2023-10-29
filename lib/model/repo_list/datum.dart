import 'dart:convert';

class Datum {
	String? id;
	String? projectName;
	String? serverName;
	String? repoUrl;
	String? code;
	String? proxyUrl;
	String? proxyUser;
	String? proxyPwd;
	String? createAt;

	Datum({
		this.id, 
		this.projectName, 
		this.serverName, 
		this.repoUrl, 
		this.code, 
		this.proxyUrl, 
		this.proxyUser, 
		this.proxyPwd, 
		this.createAt, 
	});

	@override
	String toString() {
		return 'Datum(id: $id, projectName: $projectName, serverName: $serverName, repoUrl: $repoUrl, code: $code, proxyUrl: $proxyUrl, proxyUser: $proxyUser, proxyPwd: $proxyPwd, createAt: $createAt)';
	}

	factory Datum.fromMap(Map<String, dynamic> data) => Datum(
				id: data['id'] as String?,
				projectName: data['project_name'] as String?,
				serverName: data['server_name'] as String?,
				repoUrl: data['repo_url'] as String?,
				code: data['code'] as String?,
				proxyUrl: data['proxy_url'] as String?,
				proxyUser: data['proxy_user'] as String?,
				proxyPwd: data['proxy_pwd'] as String?,
				createAt: data['create_at'] as String?,
			);

	Map<String, dynamic> toMap() => {
				'id': id,
				'project_name': projectName,
				'server_name': serverName,
				'repo_url': repoUrl,
				'code': code,
				'proxy_url': proxyUrl,
				'proxy_user': proxyUser,
				'proxy_pwd': proxyPwd,
				'create_at': createAt,
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
		String? projectName,
		String? serverName,
		String? repoUrl,
		String? code,
		String? proxyUrl,
		String? proxyUser,
		String? proxyPwd,
		String? createAt,
	}) {
		return Datum(
			id: id ?? this.id,
			projectName: projectName ?? this.projectName,
			serverName: serverName ?? this.serverName,
			repoUrl: repoUrl ?? this.repoUrl,
			code: code ?? this.code,
			proxyUrl: proxyUrl ?? this.proxyUrl,
			proxyUser: proxyUser ?? this.proxyUser,
			proxyPwd: proxyPwd ?? this.proxyPwd,
			createAt: createAt ?? this.createAt,
		);
	}
}
