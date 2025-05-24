import 'package:flutter/material.dart';
import 'dest-details.dart'; // import the detail page
import 'calender.dart';

// Model for a Destination
class Destination {
  final String name;
  final String imageAsset;
  final String location;
  final double rating;
  final String about;

  Destination({
    required this.name,
    required this.imageAsset,
    required this.location,
    required this.rating,
    required this.about,
  });
}

class HomePage extends StatefulWidget {
  final String email;
  const HomePage({Key? key, required this.email}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1; // default to Home

  // Sample list of destinations;
  final List<Destination> _destinations = [
    Destination(
      name: 'Hindu-Buddhist',
      imageAsset: 'assets/images/hindu-temple.png',
      location: 'Indonesia',
      rating: 4.7,
      about: "Hindu and Buddhist temples in Indonesia, known as "'candi'" in Javanese "
          "represent a rich history of religious and architectural influences. These structures,"
          "built during the Hindu-Buddhist period (circa 4th to 15th centuries), reflect a blend of"
          "Indian and local traditions. Famous examples include Borobudur, the world's "
          "largest Buddhist monument, and Prambanan, a major Hindu temple complex. ",
    ),
    Destination(
      name: 'Taj Mahal',
      imageAsset: 'assets/images/taj-mahal.jpg',
      location: 'India',
      rating: 4.6,
      about: "The Taj Mahal is an ivory-white marble mausoleum located on the south bank of the Yamuna River"
          " in Agra, Uttar Pradesh, India. Commissioned in 1631 by Mughal Emperor Shah Jahan, it was built to "
          "house the tomb of his beloved wife Mumtaz Mahal. "
          "Construction began in 1632 and was largely completed by 1648, with additional work on surrounding "
          "structures continuing until about 165",
    ),
    Destination(
      name: 'Grand Canyon National Park',
      imageAsset: 'assets/images/canyon.jpg',
      location: 'Arizona (USA)',
      rating: 4.4,
      about: "Grand Canyon National Park, located in northern Arizona, preserves one of the world’s most "
          "awe-inspiring natural wonders—a vast, 277-mile-long chasm carved by the Colorado River over "
          "six million years. Renowned for its immense size, layered bands of red rock reveal nearly two billion "
          "years of Earth’s geological history. Visitors come for its "
          "breathtaking vistas, diverse desert ecosystems, and unforgettable sunrise and sunset views.",
    ),
    Destination(
      name: 'Machu Picchu',
      imageAsset: 'assets/images/machu-pichu.jpg',
      location: 'Peru',
      rating: 4.8,
      about: 'Machu Picchu is a 15th-century Inca citadel perched high in the Andes Mountains of Peru '
          'at about 2,430 m above sea level. Hidden from the outside world until its “rediscovery” by Hiram Bingham '
          'in 1911, its finely crafted stone structures, agricultural terraces, and dramatic mountain backdrop make '
          'it one of the New Seven Wonders of the World. Today, this '
          'UNESCO World Heritage Site offers visitors a breathtaking glimpse into the ingenuity of the Inca Empire.',
    ),
    // Add more destinations here with asset paths
  ];

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final displayName = widget.email.split('@').first;

    return Scaffold(
      backgroundColor: const Color(0xFFEAD7D7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 24,
                        backgroundImage: AssetImage('assets/images/user_avatar.jpg'),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        displayName,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications, size: 28),
                    onPressed: () {},
                  ),
                ],
              ),

              const SizedBox(height: 24),
              const Text('Your Journey,\nSimplified', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),

              // Best Destination header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Best Destination', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  TextButton(onPressed: () {}, child: const Text('View all')),
                ],
              ),

              const SizedBox(height: 16),

              // Horizontal list of tappable destination cards
              SizedBox(
                height: 320,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _destinations.length,
                  itemBuilder: (context, index) {
                    final dest = _destinations[index];
                    return Padding(
                      padding: EdgeInsets.only(right: index == _destinations.length - 1 ? 0 : 16),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DestinationDetailPage(destination: dest),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            width: 240,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Image.asset(dest.imageAsset, height: 200, width: 240, fit: BoxFit.cover),
                                    Positioned(
                                      top: 10,
                                      right: 10,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.9),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(Icons.bookmark_border, size: 22),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(dest.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.star, size: 18, color: Colors.amber),
                                          const SizedBox(width: 6),
                                          Text(dest.rating.toStringAsFixed(1), style: const TextStyle(fontSize: 16)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.location_on, size: 16, color: Colors.grey),
                                      const SizedBox(width: 6),
                                      Text(dest.location, style: const TextStyle(fontSize: 16, color: Colors.grey)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,       // so >3 items render correctly
        backgroundColor: Colors.white,             // white bar
        selectedItemColor: Colors.blue,            // active icon
        unselectedItemColor: Colors.grey,          // inactive icons
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);

          final labels = ['Calendar', 'Home', 'Search', 'Messages', 'Profile'];
          final label = labels[index];

          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CalendarPage()),
            );
          }

          /*ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$label clicked successfully')),
          );*/
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),


    );
  }
}
