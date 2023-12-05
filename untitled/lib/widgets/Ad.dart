class Ad {
  final String id;
  final String image;
  final String link;
  final String description;

  Ad({
    required this.id,
    required this.image,
    required this.link,
    required this.description
  });

  factory Ad.fromJson(Map<String, dynamic> json) {
    return Ad(
      id: json['id'] ?? '',
      image: json['image'] ?? '',
      link: json['link'] ?? '',
      description: json['description']??'',
    );
  }
}