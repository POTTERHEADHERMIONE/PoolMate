import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InnovativeNavBar extends StatefulWidget {
  final List<String> items;
  final Function(int) onItemSelected;

  const InnovativeNavBar({
    Key? key,
    required this.items,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  _InnovativeNavBarState createState() => _InnovativeNavBarState();
}

class _InnovativeNavBarState extends State<InnovativeNavBar> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _controller;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animations = List.generate(
      widget.items.length,
      (index) => Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            index / widget.items.length,
            (index + 1) / widget.items.length,
            curve: Curves.easeInOut,
          ),
        ),
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(widget.items.length, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
                widget.onItemSelected(index);
                HapticFeedback.lightImpact();
              },
              child: AnimatedBuilder(
                animation: _animations[index],
                builder: (context, child) {
                  return Transform.scale(
                    scale: Tween<double>(begin: 0.8, end: 1.0).evaluate(_animations[index]),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: _selectedIndex == index
                            ? Theme.of(context).primaryColor.withOpacity(0.1)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _getIconForIndex(index),
                            color: _selectedIndex == index
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                            size: 24,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.items[index],
                            style: TextStyle(
                              color: _selectedIndex == index
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey,
                              fontWeight: _selectedIndex == index
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }),
        ),
      ),
    );
  }

  IconData _getIconForIndex(int index) {
    switch (index) {
      case 0:
        return Icons.home;
      case 1:
        return Icons.search;
      case 2:
        return Icons.favorite;
      case 3:
        return Icons.person;
      default:
        return Icons.circle;
    }
  }
}

// Example usage
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(title: Text('Innovative Nav Bar')),
        body: Center(child: Text('Content goes here')),
        bottomNavigationBar: InnovativeNavBar(
          items: ['Home', 'Search', 'Favorites', 'Profile'],
          onItemSelected: (index) {
            print('Selected item: $index');
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}