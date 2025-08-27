class LocationItemModel {
  final String id;
  final String city;
  final String country;
  final String imgUrl;
  final bool isChosen;

  LocationItemModel({
    required this.id,
    required this.city,
    required this.country,
    this.imgUrl = "https://cdn-icons-png.flaticon.com/512/11105/11105943.png",
    this.isChosen = false,
  });

  LocationItemModel copyWith({
    String? id,
    String? city,
    String? country,
    String? imgUrl,
    bool? isChosen,
  }) {
    return LocationItemModel(
      id: id ?? this.id,
      city: city ?? this.city,
      country: country ?? this.country,
      imgUrl: imgUrl ?? this.imgUrl,
      isChosen: isChosen ?? this.isChosen,
    );
  }
}

List<LocationItemModel> dummyLocations = [
  LocationItemModel(
    id: "1",
    city: "Qena",
    country: "Egypt",
    imgUrl: "https://cdn-icons-png.flaticon.com/512/323/323324.png",
  ),
  LocationItemModel(
    id: "2",
    city: "New York",
    country: "USA",
    imgUrl: "https://cdn-icons-png.flaticon.com/512/2929/2929284.png",
  ),
  LocationItemModel(
    id: "3",
    city: "London",
    country: "UK",
    imgUrl: "https://cdn-icons-png.flaticon.com/512/2706/2706807.png",
  ),
  LocationItemModel(
    id: "4",
    city: "Tokyo",
    country: "Japan",
    imgUrl: "https://cdn-icons-png.flaticon.com/512/2747/2747390.png",
  ),
  LocationItemModel(
    id: "5",
    city: "Doha",
    country: "Qatar",
    imgUrl: "https://cdn-icons-png.flaticon.com/128/197/197618.png",
  ),
];
