import 'package:flutter/widgets.dart';

class NavItem {
  const NavItem({required this.label, required this.icon, required this.route});

  final String label;
  final IconData icon;
  final String route;
}

class NavGroup {
  const NavGroup({required this.label, required this.items});

  final String label;
  final List<NavItem> items;
}
