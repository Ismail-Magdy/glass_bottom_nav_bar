import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GlassBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<BottomNavigationBarItemData> items;

  final Color selectedItemColor;
  final Color unselectedItemColor;
  final double height;
  final EdgeInsets margin;
  final double innerPadding;

  final bool enableHapticFeedback;

  const GlassBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.selectedItemColor = Colors.blue,
    this.unselectedItemColor = Colors.white,
    this.height = 70.0,
    this.margin = const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
    this.innerPadding = 16.0,
    this.enableHapticFeedback = false,
  }) : assert(items.length >= 2,
            "GlassBottomNavigationBar must have at least 2 items!");

  @override
  State<GlassBottomNavigationBar> createState() =>
      _GlassBottomNavigationBarState();
}

class BottomNavigationBarItemData {
  final Widget icon;
  final String label;

  BottomNavigationBarItemData({
    required this.icon,
    required this.label,
  });
}

class _GlassBottomNavigationBarState extends State<GlassBottomNavigationBar> {
  double? _dragX;
  bool _isDragging = false;
  int? _hoverIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin,
      child: Material(
        color: Colors.transparent,
        elevation: 0,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final totalWidth = constraints.maxWidth;
            final usableWidth = totalWidth - (widget.innerPadding * 2);
            final itemWidth = usableWidth / widget.items.length;

            final activeIndicatorWidth =
                _isDragging ? (itemWidth * 0.9) : (itemWidth * 0.65);

            double currentIndicatorLeft;
            if (_isDragging && _dragX != null) {
              currentIndicatorLeft = _dragX! - (activeIndicatorWidth / 2);
              final minLeft = widget.innerPadding +
                  (itemWidth / 2) -
                  (activeIndicatorWidth / 2);
              final maxLeft = totalWidth -
                  widget.innerPadding -
                  (itemWidth / 2) -
                  (activeIndicatorWidth / 2);
              currentIndicatorLeft =
                  currentIndicatorLeft.clamp(minLeft, maxLeft);
            } else {
              currentIndicatorLeft = widget.innerPadding +
                  (itemWidth * widget.currentIndex) +
                  (itemWidth / 2) -
                  (activeIndicatorWidth / 2);
            }

            final int activeIndex = _isDragging && _hoverIndex != null
                ? _hoverIndex!
                : widget.currentIndex;

            return Container(
              height: widget.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.03),
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.15),
                        width: 1.0,
                      ),
                    ),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTapUp: (details) {
                        double normalizedDx =
                            details.localPosition.dx - widget.innerPadding;
                        final index = (normalizedDx / itemWidth)
                            .floor()
                            .clamp(0, widget.items.length - 1);

                        // Make small Vibration when user taps on a different icon
                        if (widget.enableHapticFeedback &&
                            widget.currentIndex != index) {
                          HapticFeedback.lightImpact();
                        }

                        widget.onTap(index);
                      },
                      onHorizontalDragStart: (details) {
                        setState(() {
                          _isDragging = true;
                          _dragX = details.localPosition.dx;
                          double normalizedDx = _dragX! - widget.innerPadding;
                          _hoverIndex =
                              (normalizedDx / itemWidth).floor().clamp(
                                    0,
                                    widget.items.length - 1,
                                  );
                        });
                      },
                      onHorizontalDragUpdate: (details) {
                        setState(() {
                          _dragX = details.localPosition.dx;
                          double normalizedDx = _dragX! - widget.innerPadding;
                          int newHoverIndex =
                              (normalizedDx / itemWidth).floor().clamp(
                                    0,
                                    widget.items.length - 1,
                                  );

                          // Make small Vibration when user hovers over a different icon
                          if (widget.enableHapticFeedback &&
                              _hoverIndex != newHoverIndex) {
                            HapticFeedback.selectionClick();
                          }

                          _hoverIndex = newHoverIndex;
                        });
                      },
                      onHorizontalDragEnd: (details) {
                        if (_hoverIndex != null &&
                            _hoverIndex != widget.currentIndex) {
                          // Make small Vibration when user releases the drag on a different icon
                          if (widget.enableHapticFeedback) {
                            HapticFeedback.lightImpact();
                          }
                          widget.onTap(_hoverIndex!);
                        }
                        setState(() {
                          _isDragging = false;
                          _hoverIndex = null;
                          _dragX = null;
                        });
                      },
                      onHorizontalDragCancel: () {
                        setState(() {
                          _isDragging = false;
                          _hoverIndex = null;
                          _dragX = null;
                        });
                      },
                      child: Stack(
                        children: [
                          AnimatedPositioned(
                            duration: Duration(
                              milliseconds: _isDragging ? 150 : 600,
                            ),
                            curve: _isDragging
                                ? Curves.easeOut
                                : Curves.fastLinearToSlowEaseIn,
                            left: currentIndicatorLeft,
                            top: widget.height * 0.11,
                            bottom: widget.height * 0.11,
                            width: activeIndicatorWidth,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.white.withValues(alpha: 0.5),
                                    Colors.white.withValues(alpha: 0.05),
                                    Colors.white.withValues(alpha: 0.0),
                                  ],
                                  stops: const [0.0, 0.4, 1.0],
                                ),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.4),
                                  width: 1.2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.05),
                                    blurRadius: 8,
                                    spreadRadius: -2,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: widget.innerPadding),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(widget.items.length, (
                                index,
                              ) {
                                final item = widget.items[index];
                                final isSelected = index == activeIndex;
                                final currentColor = isSelected
                                    ? widget.selectedItemColor
                                    : widget.unselectedItemColor;

                                return Expanded(
                                  child: SizedBox(
                                    height: double.infinity,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        AnimatedScale(
                                          scale: isSelected ? 1.15 : 1.0,
                                          duration: const Duration(
                                            milliseconds: 400,
                                          ),
                                          curve: Curves.easeOutBack,
                                          child: AnimatedSwitcher(
                                            duration: const Duration(
                                              milliseconds: 300,
                                            ),
                                            transitionBuilder:
                                                (child, animation) =>
                                                    FadeTransition(
                                              opacity: animation,
                                              child: child,
                                            ),
                                            child: IconTheme(
                                              key: ValueKey(isSelected),
                                              data: IconThemeData(
                                                size: 24,
                                                color: currentColor,
                                              ),
                                              child: item.icon,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        AnimatedDefaultTextStyle(
                                          duration: const Duration(
                                            milliseconds: 300,
                                          ),
                                          curve: Curves.fastOutSlowIn,
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: isSelected
                                                ? FontWeight.w700
                                                : FontWeight.w500,
                                            color: currentColor,
                                          ),
                                          child: Text(item.label),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
