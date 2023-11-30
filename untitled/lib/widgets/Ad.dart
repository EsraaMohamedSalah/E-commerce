class Ad {
  final String id;
  final String image;
  final String link;

  Ad({
    required this.id,
    required this.image,
    required this.link,
  });

  factory Ad.fromJson(Map<String, dynamic> json) {
    return Ad(
      id: json['id'] ?? '',
      image: json['image'] ?? '',
      link: json['link'] ?? '',
    );
  }
}