import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dest-details.dart'; // for Destination
import 'home.dart';

// Booking model
class Booking {
  final Destination destination;
  final DateTime date;
  Booking({required this.destination, required this.date});
}

// Simple in-memory booking manager
class BookingManager {
  static final List<Booking> bookings = [];
  static void addBooking(Destination dest) {
    bookings.add(Booking(destination: dest, date: DateTime.now()));
  }
}

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);
  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _selectedDay = DateTime.now();
  int _selectedIndex = 1; // default to Home

  // Compute start of week (Sunday)
  DateTime get _startOfWeek {
    final weekday = _selectedDay.weekday % 7; // Sunday=7→0, Monday=1→1...
    return _selectedDay.subtract(Duration(days: weekday));
  }

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    final monthDayLabel = DateFormat('d MMMM').format(_selectedDay);
    final bookings = BookingManager.bookings;

    return Scaffold(
      backgroundColor: const Color(0xFFF2DEDE),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text('Schedule',
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.notifications),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Calendar card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    // Month-Day and nav arrows
                    Row(
                      children: [
                        Text(monthDayLabel,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.chevron_left),
                          onPressed: () {
                            setState(() {
                              _selectedDay = _selectedDay.subtract(
                                  const Duration(days: 1));
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.chevron_right),
                          onPressed: () {
                            setState(() {
                              _selectedDay = _selectedDay.add(
                                  const Duration(days: 1));
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Weekday labels
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
                          .map((d) => Expanded(
                          child: Center(
                              child: Text(d,
                                  style: const TextStyle(
                                      color: Colors.grey)))))
                          .toList(),
                    ),
                    const SizedBox(height: 4),
                    // Dates row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(7, (i) {
                        final date = _startOfWeek.add(Duration(days: i));
                        final isSelected = date.day == _selectedDay.day &&
                            date.month == _selectedDay.month;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() {
                              _selectedDay = date;
                            }),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: isSelected
                                  ? BoxDecoration(
                                color: const Color(0xFF973232),
                                borderRadius: BorderRadius.circular(8),
                              )
                                  : null,
                              child: Column(
                                children: [
                                  Text(date.day.toString(),
                                      style: TextStyle(
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.black)),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Our Schedule header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Our Schedule',
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  TextButton(onPressed: () {}, child: const Text('View all')),
                ],
              ),
              const SizedBox(height: 8),

              // Booked list
              Expanded(
                child: bookings.isEmpty
                    ? const Center(child: Text('No bookings yet.'))
                    : ListView.builder(
                  itemCount: bookings.length,
                  itemBuilder: (context, idx) {
                    final b = bookings[idx];
                    final dateLabel = DateFormat('d MMMM yyyy').format(b.date);

                    return GestureDetector(
                      onTap: () async {
                        // navigate into detail page, passing the destination
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DestinationDetailPage(
                              destination: b.destination,
                            ),
                          ),
                        );
                        // when you pop back, rebuild so the calendar list/button state updates
                        setState(() {});
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                b.destination.imageAsset,
                                width: 80,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                                      const SizedBox(width: 4),
                                      Text(dateLabel,
                                          style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(b.destination.name,
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 2),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on, size: 14, color: Colors.grey),
                                      const SizedBox(width: 4),
                                      Text(b.destination.location,
                                          style: const TextStyle(fontSize: 14, color: Colors.grey)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                          ],
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
      // Bottom navigation bar (calendar selected)
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

          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const HomePage(email: 'mahnoor')),
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
