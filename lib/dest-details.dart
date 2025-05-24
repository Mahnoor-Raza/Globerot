import 'package:flutter/material.dart';
import 'home.dart';      // for Destination
import 'calender.dart'; // for BookingManager

class DestinationDetailPage extends StatefulWidget {
  final Destination destination;
  const DestinationDetailPage({Key? key, required this.destination})
      : super(key: key);

  @override
  _DestinationDetailPageState createState() => _DestinationDetailPageState();
}

class _DestinationDetailPageState extends State<DestinationDetailPage> {
  /// Returns true if this destination is already in the bookings list.
  bool get isBooked =>
      BookingManager.bookings.any((b) => b.destination == widget.destination);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Details',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background image
          Image.asset(
            widget.destination.imageAsset,
            width: double.infinity,
            height: 350,
            fit: BoxFit.cover,
          ),

          // Draggable details sheet
          DraggableScrollableSheet(
            initialChildSize: 0.55,
            minChildSize: 0.55,
            maxChildSize: 0.9,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  children: [
                    // Drag handle
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Title row with avatar
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.destination.name,
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage('assets/images/user_avatar.jpg'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // Location subtitle
                    Text(
                      widget.destination.location,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 16),

                    // Icons row: location & rating
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(widget.destination.location),
                        const Spacer(),
                        const Icon(Icons.star, size: 16, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(widget.destination.rating.toString()),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // About section
                    const Text(
                      'About Destination',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.destination.about,
                      style: const TextStyle(fontSize: 14, height: 1.5),
                    ),
                    const SizedBox(height: 24),

                    // Book / Unbook button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          final wasBooked = isBooked;
                          setState(() {
                            if (wasBooked) {
                              // remove booking
                              BookingManager.bookings.removeWhere(
                                      (b) => b.destination == widget.destination);
                            } else {
                              // add booking
                              BookingManager.addBooking(widget.destination);
                            }
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                wasBooked
                                    ? 'Booking cancelled!'
                                    : 'Booking confirmed!',
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF973232),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(isBooked ? 'Unbook Now' : 'Book Now'),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
