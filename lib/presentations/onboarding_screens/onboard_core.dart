class Onboard {
  final String image, title1, title2, description1, description2;

  Onboard({
    required this.image,
    required this.title1,
    required this.title2,
    required this.description1,
    required this.description2,
  });
}

final List<Onboard> demoData = [
  Onboard(
    image: 'assets/images/onboardimg.jpeg',
    title2: 'New Arrival Product',
    title1: '20% Discount Available',
    description1: 'Publish up your selfies to make yourself',
    description2: 'more beautiful with this app.',
  ),
  Onboard(
    image: 'assets/images/onboardimg1.jpg',
    title2: 'Take Advantage',
    title1: 'Of The Offer Shopping',
    description1: 'Publish up your selfies to make yourself',
    description2: 'more beautiful with this app.',
  ),
  Onboard(
    image: 'assets/images/onboardimg2.jpg',
    title2: 'All Types Offers',
    title1: 'Within Your Reach',
    description1: 'Publish up your selfies to make yourself',
    description2: 'more beautiful with this app.',
  ),
];
