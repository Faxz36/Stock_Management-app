import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _appLockEnabled = false; // Track the state of the switch

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Stock Control and Inventory',
          style: TextStyle(
            color: Colors.white, // Set the color of the text to white
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade400, Colors.purple.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.indigo),
            title: const Text(
              'Settings',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              // Navigate to settings page or perform action
            },
          ),
          ListTile(
            leading: const Icon(Icons.backup, color: Colors.indigo),
            title: const Text(
              'Backup Restore',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              // Navigate to backup restore page or perform action
            },
          ),
          SwitchListTile(
            title: const Text(
              'App Lock',
              style: TextStyle(fontSize: 18),
            ),
            value: _appLockEnabled,
            secondary: const Icon(Icons.lock, color: Colors.indigo),
            onChanged: (bool value) {
              setState(() {
                _appLockEnabled = value; // Update the state of the switch
              });
              // Update the state of app lock here
            },
          ),
          ListTile(
            leading: const Icon(Icons.share, color: Colors.indigo),
            title: const Text(
              'Share With Friends',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              // Code to share the app
            },
          ),
          ListTile(
            leading: const Icon(Icons.star, color: Colors.indigo),
            title: const Text(
              'Rate us',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              // Code to rate the app
            },
          ),
          ListTile(
            leading: const Icon(Icons.description, color: Colors.indigo),
            title: const Text(
              'Privacy Policy',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              // Navigate to privacy policy page or show it
            },
          ),
          ListTile(
            leading: const Icon(Icons.rule, color: Colors.indigo),
            title: const Text(
              'Terms Of Service',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              // Navigate to terms of service page or show it
            },
          ),
        ],
      ),
    );
  }
}
