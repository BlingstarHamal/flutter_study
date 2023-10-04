class SaveOrUpdateReqdto {
  final String? title;
  final String? content;

  SaveOrUpdateReqdto(
    this.title,
    this.content,
  );

  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
      };
}
