import 'dart:convert';

class PageInfo {
	bool? isNotPaging;
	int? pageNum;
	int? pageSize;
	int? total;

	PageInfo({this.isNotPaging, this.pageNum, this.pageSize, this.total});

	@override
	String toString() {
		return 'PageInfo(isNotPaging: $isNotPaging, pageNum: $pageNum, pageSize: $pageSize, total: $total)';
	}

	factory PageInfo.fromMap(Map<String, dynamic> data) => PageInfo(
				isNotPaging: data['isNotPaging'] as bool?,
				pageNum: data['pageNum'] as int?,
				pageSize: data['pageSize'] as int?,
				total: data['total'] as int?,
			);

	Map<String, dynamic> toMap() => {
				'isNotPaging': isNotPaging,
				'pageNum': pageNum,
				'pageSize': pageSize,
				'total': total,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PageInfo].
	factory PageInfo.fromJson(String data) {
		return PageInfo.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [PageInfo] to a JSON string.
	String toJson() => json.encode(toMap());

	PageInfo copyWith({
		bool? isNotPaging,
		int? pageNum,
		int? pageSize,
		int? total,
	}) {
		return PageInfo(
			isNotPaging: isNotPaging ?? this.isNotPaging,
			pageNum: pageNum ?? this.pageNum,
			pageSize: pageSize ?? this.pageSize,
			total: total ?? this.total,
		);
	}
}
