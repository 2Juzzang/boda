class DiaryList {
  final String? id;
  final String? title;
  final String? author;
  final List<String>? diarys;
  final DateTime? created;
  final DateTime? updated;

  DiaryList({
    this.id,
    this.title,
    this.author,
    this.diarys,
    this.created,
    this.updated,
  });

  DiaryList.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json['title'],
        author = json['author'],
        diarys = json['diarys'],
        created = json['created'],
        updated = json['updated'];
}
