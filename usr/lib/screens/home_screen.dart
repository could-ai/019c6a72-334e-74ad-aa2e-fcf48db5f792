import 'package:flutter/material.dart';
import 'trending_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Map sidebar IDs to widgets, similar to home.js pages map
  // "sidebar-home": "Pages/home-content.html" -> Index 0
  // "sidebar-search": "Pages/search.html" -> Index 1
  // "sidebar-trending": "Pages/Trending.html" -> Index 2
  // ...
  final List<Widget> _pages = [
    const Center(child: Text("Home Content")), // Placeholder for Home
    const Center(child: Text("Search")), // Placeholder for Search
    const TrendingScreen(), // Implemented based on trending.html
    const Center(child: Text("Notifications")),
    const Center(child: Text("Bookmarks")),
    const Center(child: Text("Profile")),
    const Center(child: Text("Settings")),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _handleLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Do you really want to log out?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pushReplacementNamed(context, '/'); // Go to login
            },
            child: const Text("Logout", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Responsive layout: Sidebar for desktop, Drawer/BottomNav for mobile
    final isDesktop = MediaQuery.of(context).size.width > 900;

    if (isDesktop) {
      return Scaffold(
        body: Row(
          children: [
            // Sidebar
            Container(
              width: 260,
              decoration: const BoxDecoration(
                border: Border(right: BorderSide(color: Color(0xFFEEEEEE))),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "Samaze",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Expanded(
                    child: ListView(
                      children: [
                        _buildSidebarItem(0, Icons.home, "Home"),
                        _buildSidebarItem(1, Icons.search, "Search"),
                        _buildSidebarItem(2, Icons.trending_up, "Trending"),
                        _buildSidebarItem(3, Icons.notifications, "Notifications"),
                        _buildSidebarItem(4, Icons.bookmark, "Bookmarks"),
                        _buildSidebarItem(5, Icons.person, "Profile"),
                        _buildSidebarItem(6, Icons.settings, "Settings"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1DA1F2),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text("Post", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: _handleLogout,
                    icon: const Icon(Icons.logout, color: Colors.grey),
                    label: const Text("Logout", style: TextStyle(color: Colors.grey)),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            // Main Content
            Expanded(
              child: _pages[_selectedIndex],
            ),
          ],
        ),
      );
    } else {
      // Mobile Layout
      return Scaffold(
        appBar: AppBar(
          title: const Text("Samaze", style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white,
          elevation: 1,
          iconTheme: const IconThemeData(color: Colors.black),
          titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              const DrawerHeader(
                child: Center(
                  child: Text(
                    "Samaze",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              _buildDrawerItem(0, Icons.home, "Home"),
              _buildDrawerItem(1, Icons.search, "Search"),
              _buildDrawerItem(2, Icons.trending_up, "Trending"),
              _buildDrawerItem(3, Icons.notifications, "Notifications"),
              _buildDrawerItem(4, Icons.bookmark, "Bookmarks"),
              _buildDrawerItem(5, Icons.person, "Profile"),
              _buildDrawerItem(6, Icons.settings, "Settings"),
              const Spacer(),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text("Logout", style: TextStyle(color: Colors.red)),
                onTap: _handleLogout,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        body: _pages[_selectedIndex],
      );
    }
  }

  Widget _buildSidebarItem(int index, IconData icon, String label) {
    final isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE8F5F3) : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFF1DA1F2) : Colors.black87,
              size: 24,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                color: isSelected ? const Color(0xFF1DA1F2) : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(int index, IconData icon, String label) {
    final isSelected = _selectedIndex == index;
    return ListTile(
      leading: Icon(icon, color: isSelected ? const Color(0xFF1DA1F2) : null),
      title: Text(
        label,
        style: TextStyle(
          color: isSelected ? const Color(0xFF1DA1F2) : null,
          fontWeight: isSelected ? FontWeight.bold : null,
        ),
      ),
      selected: isSelected,
      onTap: () {
        _onItemTapped(index);
        Navigator.pop(context); // Close drawer
      },
    );
  }
}
