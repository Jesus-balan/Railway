import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:railway/presentation/widgets/drawer_widget.dart';
import 'package:railway/presentation/widgets/textfield_widget.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final TextEditingController sourceController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking",style: GoogleFonts.poppins(color: Colors.white),),
        backgroundColor: Color(0xFF053149),
        iconTheme: IconThemeData(
          color: Colors.white
        ),
      ),
      drawer: RailwayDrawer(),
      body: SafeArea(
        child: Stack(
          children: [
            /// 🔹 Background Image with Gradient Overlay
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 400,
              child: Stack(
                children: [
                  Image.asset(
                    "assets/images/booking.jpg",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 400,
                  ),
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF053149).withOpacity(0.8), Colors.transparent],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// 🔹 Booking Form
            Positioned(
              top: 360,
              left: 0,
              right: 0,
              child: Container(
                height: 600,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F7FA), // Soft background color
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 15,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Book Your Journey",
                        style: GoogleFonts.poppins(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF053149),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),

                    /// 🔹 Source Text Field
                    CustomTextField(
                      label: "Source",
                      controller: sourceController,
                      prefixIcon: Icons.location_on,
                    ),
                    SizedBox(height: 15),

                    /// 🔹 Destination Text Field
                    CustomTextField(
                      label: "Destination",
                      controller: destinationController,
                      prefixIcon: Icons.location_on_outlined,
                    ),
                    SizedBox(height: 30),

                    /// 🔹 Search Button with Gradient
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Implement Search Action
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero, // Remove padding to apply Ink Gradient
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF085A8C), Color(0xFF053149)],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            child: Text(
                              "Search Trains",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
