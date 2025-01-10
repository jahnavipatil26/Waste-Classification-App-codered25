class Item {
  final String id;  // Non-nullable
  final String imageURL;  // Non-nullable
  int points;  // Non-nullable
  final String name;  // Non-nullable
  int count;  // Non-nullable

  Item({
    this.id = '',  // Default value provided
    this.name = '',  // Default value provided
    this.imageURL = '',  // Default value provided
    this.points = 0,  // Default value provided
    this.count = 0,  // Default value provided
  });

  factory Item.fromMap(Map<String, dynamic> json) => Item(
    id: json['id'] ?? '',  // Default to '' if 'id' is null
    name: json['name'] ?? '',  // Default to '' if 'name' is null
    imageURL: json['imageURL'] ?? '',  // Default to '' if 'imageURL' is null
    points: json['points'] ?? 0,  // Default to 0 if 'points' is null
    count: json['count'] ?? 0,  // Default to 0 if 'count' is null
  );

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "imageURL": imageURL,
      "points": points,
      "count": count
    };
  }
}
