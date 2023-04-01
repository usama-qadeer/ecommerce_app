class Categoery {
  String? title;
  String? image;

  Categoery({required this.title, this.image});

  // static map(DropdownMenuItem<String> Function(dynamic e) param0) {}
}

List<Categoery> categories = [
  Categoery(title: "SHOES", image: "assets/shoe.png"),
  Categoery(title: "ELECTRONIC", image: "assets/electronics.png"),
  Categoery(title: "GARMENTS", image: "assets/garments.png"),
  Categoery(title: "COSMATICS", image: "assets/cosmatics.png"),
  Categoery(title: "PHARMACY", image: "assets/pharmacy.png"),
];
