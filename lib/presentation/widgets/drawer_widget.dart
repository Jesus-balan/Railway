import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railway/presentation/bloc/auth/auth_bloc.dart';
import 'package:railway/presentation/ui/auth/login_screen.dart';

class RailwayDrawer extends StatefulWidget {
  @override
  State<RailwayDrawer> createState() => _RailwayDrawerState();
}

class _RailwayDrawerState extends State<RailwayDrawer> {
  void _logout(BuildContext context) {
    // Dispatch Bloc Event
    context.read<AuthBloc>().add(SignOutEvent());

    // Navigate to Login Screen after logout
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.train, size: 60, color: Colors.blue),
                SizedBox(height: 10),
                Text("Railway Services",
                    style: TextStyle(fontSize: 18, color: Colors.blue)),
              ],
            ),
          ),
          _buildDrawerItem(
              context, Icons.dashboard, "Dashboard", () {
            Navigator.pushNamed(context, '/dashboard');
          }),
          _buildDrawerItem(
              context, Icons.directions_train, "Train Schedule", () {
            Navigator.pushNamed(context, '/schedule');
          }),
          _buildDrawerItem(context, Icons.confirmation_number, "Book Tickets",
              () {
            Navigator.pushNamed(context, '/book');
          }),
          _buildDrawerItem(context, Icons.search, "PNR Status", () {
            Navigator.pushNamed(context, '/pnr');
          }),
          _buildDrawerItem(context, Icons.settings, "Settings", () {
            Navigator.pushNamed(context, '/settings');
          }),
          Spacer(),
          Divider(),
          _buildDrawerItem(context, Icons.logout, "Logout", () => _logout(context)),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
      BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title, style: TextStyle(fontSize: 16)),
      onTap: onTap,
    );
  }
}
