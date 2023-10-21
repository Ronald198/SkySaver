class WelcomeModel {
  final String title;
  final String subTitle;
  final String description;
  final String imageUrl;

  WelcomeModel({
    required this.title,
    required this.subTitle,
    required this.description,
    required this.imageUrl,
  });
}

List<WelcomeModel> welcomeComponents = [
  WelcomeModel(
      title: "Welcome to",
      subTitle: "SkySaver",
      description: "\n\n\n",
      imageUrl: "assets/welcomePage/attendants.jpg"),
  WelcomeModel(
      title: "Join SkyClub",
      subTitle: "to take advantage of\nfantastic benefits",
      description: "\n",
      imageUrl: "assets/welcomePage/discount.jpg"),
  WelcomeModel(
      title: "View",
      subTitle: "trending offers\nworldwide",
      description: "\n",
      imageUrl: "assets/welcomePage/trips.jpg"),
];
