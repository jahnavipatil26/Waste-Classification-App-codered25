class Category {
  final String id;
  final String imageURL;
  final int points;
  final String name;

  Category({
    this.id = '',  // Default value provided
    this.name = '',  // Default value provided
    this.imageURL = '',  // Default value provided
    this.points = 0,  // Default value provided
  });

  factory Category.fromMap(Map<String, dynamic> json) => Category(
    id: json['id'] ?? '',  // Default to '' if 'id' is null
    name: json['name'] ?? '',  // Default to '' if 'name' is null
    imageURL: json['imageURL'] ?? '',  // Default to '' if 'imageURL' is null
    points: json['points'] ?? 0,  // Default to 0 if 'points' is null
  );

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "imageURL": imageURL,
      "points": points,
    };
  }
}
