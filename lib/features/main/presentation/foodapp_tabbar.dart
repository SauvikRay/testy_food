import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show HapticFeedback;
import 'dart:ui' show ImageFilter;

// Standard iOS 10 tab bar height.
const double _kTabBarHeight = 62.0;

const Color _kDefaultTabBarBorderColor = CupertinoDynamicColor.withBrightness(
  color: Color(0x1F000000),
  darkColor: Color(0x0A000000),
);
const Color _kDefaultTabBarInactiveColor = CupertinoColors.inactiveGray;

class FoodAppTabBar extends StatefulWidget implements PreferredSizeWidget {
  const FoodAppTabBar({
    super.key,
    required this.items,
    this.onTap,
    this.currentIndex = 0,
    this.backgroundColor,
    this.activeColor,
    this.inactiveColor = _kDefaultTabBarInactiveColor,
    this.iconSize = 24.0,
    this.height = _kTabBarHeight,
    this.border = const Border(
      top: BorderSide(
        color: _kDefaultTabBarBorderColor,
        width: 0.5,
      ),
    ),
  }) : assert(
         items.length >= 2,
         "Tabs need at least 2 items to conform to Apple's HIG",
       ),
       assert(0 <= currentIndex && currentIndex < items.length),
       assert(height >= 0.0);

  final List<FoodAppNavigationBarItem> items;
  final ValueChanged<int>? onTap;
  final int currentIndex;
  final Color? backgroundColor;
  final Color? activeColor;
  final Color inactiveColor;
  final double iconSize;
  final double height;
  final Border? border;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  State<FoodAppTabBar> createState() => _FoodAppTabBarState();
}

class _FoodAppTabBarState extends State<FoodAppTabBar> with TickerProviderStateMixin {
  late List<AnimationController> _iconControllers;

  @override
  void initState() {
    super.initState();
    _iconControllers = List.generate(
      widget.items.length,
      (index) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 250),
        value: index == widget.currentIndex ? 1.0 : 0.0,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant FoodAppTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _iconControllers[oldWidget.currentIndex].reverse();
      _iconControllers[widget.currentIndex].forward();
    }
  }

  @override
  void dispose() {
    for (final controller in _iconControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  bool opaque(BuildContext context) {
    final Color backgroundColor =
        widget.backgroundColor ?? CupertinoTheme.of(context).barBackgroundColor;
    return CupertinoDynamicColor.resolve(backgroundColor, context).a == 1.0;
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    final double bottomPadding = MediaQuery.viewPaddingOf(context).bottom;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double tabWidth = screenWidth / widget.items.length;
    final double pillWidth = 24.0;

    final Color backgroundColor = CupertinoDynamicColor.resolve(
      widget.backgroundColor ?? CupertinoTheme.of(context).barBackgroundColor,
      context,
    );

    BorderSide resolveBorderSide(BorderSide side) {
      return side == BorderSide.none
          ? side
          : side.copyWith(
              color: CupertinoDynamicColor.resolve(side.color, context),
            );
    }

    final Border? resolvedBorder =
        widget.border == null || widget.border.runtimeType != Border
        ? widget.border
        : Border(
            top: resolveBorderSide(widget.border!.top),
            left: resolveBorderSide(widget.border!.left),
            bottom: resolveBorderSide(widget.border!.bottom),
            right: resolveBorderSide(widget.border!.right),
          );

    final Color inactive = CupertinoDynamicColor.resolve(
      widget.inactiveColor,
      context,
    );

    final Color activeColor = CupertinoDynamicColor.resolve(
      widget.activeColor ?? CupertinoTheme.of(context).primaryColor,
      context,
    );

    Widget result = DecoratedBox(
      decoration: BoxDecoration(border: resolvedBorder, color: backgroundColor),
      child: SizedBox(
        height: widget.height + bottomPadding,
        child: Stack(
          children: [
            // Sliding indicator pill at the bottom
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutBack,
              left: (widget.currentIndex * tabWidth) + (tabWidth - pillWidth) / 2,
              bottom: bottomPadding + 3,
              child: Container(
                width: pillWidth,
                height: 3,
                decoration: BoxDecoration(
                  color: activeColor,
                  borderRadius: BorderRadius.circular(1.5),
                  boxShadow: [
                    BoxShadow(
                      color: activeColor.withValues(alpha: 0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
              ),
            ),
            // Tab Items
            Padding(
              padding: EdgeInsets.only(bottom: bottomPadding),
              child: Semantics(
                explicitChildNodes: true,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: _buildTabItems(context, inactive, activeColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    if (!opaque(context)) {
      result = ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
          child: result,
        ),
      );
    }

    return result;
  }

  List<Widget> _buildTabItems(BuildContext context, Color inactiveColor, Color activeColor) {
    final List<Widget> result = <Widget>[];
    final CupertinoLocalizations localizations = CupertinoLocalizations.of(context);

    for (int index = 0; index < widget.items.length; index += 1) {
      final bool active = index == widget.currentIndex;
      final scaleAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
        CurvedAnimation(
          parent: _iconControllers[index],
          curve: Curves.easeOutBack,
        ),
      );

      result.add(
        Expanded(
          child: TextFieldTapRegion(
            child: Semantics(
              selected: active,
              hint: localizations.tabSemanticsLabel(
                tabIndex: index + 1,
                tabCount: widget.items.length,
              ),
              child: MouseRegion(
                cursor: kIsWeb ? SystemMouseCursors.click : MouseCursor.defer,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: widget.onTap == null
                      ? null
                      : () {
                          if (!active) {
                            HapticFeedback.selectionClick();
                          }
                          widget.onTap!(index);
                        },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, top: 4.0),
                    child: ScaleTransition(
                      scale: scaleAnimation,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Center(
                              child: IconTheme(
                                data: IconThemeData(
                                  color: active ? activeColor : inactiveColor,
                                  size: widget.iconSize,
                                ),
                                child: active ? widget.items[index].activeIcon : widget.items[index].icon,
                              ),
                            ),
                          ),
                          if (widget.items[index].label != null)
                            AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 200),
                              style: TextStyle(
                                color: active ? activeColor : inactiveColor,
                                fontSize: 11,
                                fontWeight: active ? FontWeight.bold : FontWeight.w500,
                              ),
                              child: Text(widget.items[index].label!),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return result;
  }
}

class FoodAppNavigationBarItem {
  const FoodAppNavigationBarItem({
    this.key,
    required this.icon,
    this.label,
    Widget? activeIcon,
    this.backgroundColor,
    this.tooltip,
  }) : activeIcon = activeIcon ?? icon;

  final Key? key;
  final Widget icon;
  final Widget activeIcon;
  final String? label;
  final Color? backgroundColor;
  final String? tooltip;
}
