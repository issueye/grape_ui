class AddRepo {
	String? id;
	String? projectName;
	String? serverName;
	String? repoUrl;
	String? proxyUrl;
	String? proxyUser;
	String? proxyPwd;
	String? mark;

	AddRepo({
		this.id, 
		this.projectName, 
		this.serverName, 
		this.repoUrl, 
		this.proxyUrl, 
		this.proxyUser, 
		this.proxyPwd, 
		this.mark, 
	});

	@override
	String toString() {
		return 'AddRepo(id: $id, projectName: $projectName, serverName: $serverName, repoUrl: $repoUrl, proxyUrl: $proxyUrl, proxyUser: $proxyUser, proxyPwd: $proxyPwd, mark: $mark)';
	}

	factory AddRepo.fromJson(Map<String, dynamic> json) => AddRepo(
				id: json['id'] as String?,
				projectName: json['project_name'] as String?,
				serverName: json['server_name'] as String?,
				repoUrl: json['repo_url'] as String?,
				proxyUrl: json['proxy_url'] as String?,
				proxyUser: json['proxy_user'] as String?,
				proxyPwd: json['proxy_pwd'] as String?,
				mark: json['mark'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'project_name': projectName,
				'server_name': serverName,
				'repo_url': repoUrl,
				'proxy_url': proxyUrl,
				'proxy_user': proxyUser,
				'proxy_pwd': proxyPwd,
				'mark': mark,
			};
}
