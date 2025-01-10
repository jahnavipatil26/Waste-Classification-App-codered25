class Reward {
  final String id;  // Non-nullable
  final String imageURL;  // Non-nullable
  final int points;  // Non-nullable
  final String name;  // Non-nullable

  Reward({
    this.id = '',  // Default value
    this.name = '',  // Default value
    this.imageURL = '',  // Default value
    this.points = 0,  // Default value
  });
}
