import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';

class MobileTopSection extends StatefulWidget {
  final String selectedTab;
  final ValueChanged<String> onTabChanged;
  final int selectedCategoryIndex;
  final ValueChanged<int> onCategoryChanged;

  const MobileTopSection({
    Key? key,
    required this.selectedTab,
    required this.onTabChanged,
    required this.selectedCategoryIndex,
    required this.onCategoryChanged,
  }) : super(key: key);

  @override
  State<MobileTopSection> createState() => _MobileTopSectionState();
}

class _MobileTopSectionState extends State<MobileTopSection> {
  final ScrollController _scrollController = ScrollController();

  final List<_Category> categories = const [
    _Category(Icons.sports_martial_arts, AppStrings.businessWarfare),
    _Category(Icons.flag, AppStrings.leadHunt),
    _Category(Icons.emoji_events, AppStrings.theContest),
    _Category(Icons.people, AppStrings.theInPerson),
    _Category(Icons.videogame_asset, AppStrings.virtualBu),
    _Category(Icons.sports, AppStrings.virtualWa),
  ];

  void _scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset - 100,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void _scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + 100,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      top: true,
      child: Container(
        color: const Color(0xFF191D45), // Updated primary color
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/lab drawer logo.png',
                    height: 40,
                  ),
                  Row(
                    children: [
                      _TabButton(
                        label: 'Live',
                        selected: widget.selectedTab == AppStrings.liveStatus,
                        onTap: () => widget.onTabChanged(AppStrings.liveStatus),
                      ),
                      const SizedBox(width: 8),
                      _TabButton(
                        label: 'Upcoming',
                        selected:
                            widget.selectedTab == AppStrings.upcomingStatus,
                        onTap: () =>
                            widget.onTabChanged(AppStrings.upcomingStatus),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 12,),
            // Scrollable category bar with overlay buttons (icons outside row)
            SizedBox(
              height: 60,
              width: screenWidth,
              child: Stack(
                children: [
                  // Category buttons row (centered, with horizontal padding for icons)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.separated(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: categories.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, i) {
                        final cat = categories[i];
                        final selected = i == widget.selectedCategoryIndex;
                        return GestureDetector(
                          onTap: () => widget.onCategoryChanged(i),
                          child: Container(
                            width: (screenWidth - 72) / 4,
                            // 4 items visible at once, minus icon buttons
                            padding: const EdgeInsets.only(top: 4, bottom: 8),
                            decoration: BoxDecoration(
                              color: selected
                                  ? const Color(0xF7CFC1A)
                                  : Colors.transparent,
                              borderRadius: selected
                                  ? BorderRadius.zero
                                  : BorderRadius.circular(16),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  cat.icon,
                                  size: 20,
                                  color: selected
                                      ? const Color(0xFF5671F5)
                                      : AppColors.white,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  cat.label,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: selected
                                        ? const Color(0xFF5671F5)
                                        : const Color(0xCCF7FCFC),
                                    // #F7FCFCCC
                                    fontFamily: 'Roboto',
                                    letterSpacing: 0.1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Left scroll icon (center left)
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: GestureDetector(
                        onTap: _scrollLeft,
                        child: const Icon(Icons.chevron_left,
                            size: 22, color: AppColors.white),
                      ),
                    ),
                  ),
                  // Right scroll icon (center right)
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: GestureDetector(
                        onTap: _scrollRight,
                        child: const Icon(Icons.chevron_right,
                            size: 22, color: AppColors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Selected category display
            Container(
              width: double.maxFinite,
              color: Color(0xff2a3162),
              child: Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16,top: 12,bottom: 12),
                    child: Column(

                      children: [
                        Icon(
                          categories[widget.selectedCategoryIndex].icon,
                          color: AppColors.white,
                          size: 20,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          categories[widget.selectedCategoryIndex].label,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Category {
  final IconData icon;
  final String label;

  const _Category(this.icon, this.label);
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _TabButton(
      {required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.secondaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: selected ? AppColors.secondaryColor : AppColors.white,
            width: 2,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? AppColors.white : AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
