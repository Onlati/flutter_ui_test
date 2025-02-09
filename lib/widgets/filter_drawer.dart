import 'package:flutter/material.dart';
import 'package:flutter_ui_test/theme_notifier.dart';

class FilterDrawer extends StatefulWidget {
  const FilterDrawer({Key? key}) : super(key: key);

  @override
  _FilterDrawerState createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer>
    with AutomaticKeepAliveClientMixin {
  String? _selectedPublicationDate;
  String _selectedSource = "Apple";
  List<String> _selectedMediaTypes = [];
  String _selectedRelevance = "Most Relevant";
  String _selectedCategory = "Politics";
  String _selectedNewsTone = "Positive";
  String _selectedLanguage = "English";
  String _location = "";
  double _sliderValue = 50;
  String _selectedFormat = "Written Article";
  bool _hasFilterChanges = false;
  bool get _hasSelectedFilters {
    return _selectedPublicationDate != null ||
        _selectedSource != "Apple" ||
        _selectedMediaTypes.isNotEmpty ||
        _selectedRelevance != "Most Relevant" ||
        _selectedCategory != "Politics" ||
        _selectedNewsTone != "Positive" ||
        _selectedLanguage != "English" ||
        _location.isNotEmpty ||
        _sliderValue != 50 ||
        _selectedFormat != "Written Article";
  }

  @override
  bool get wantKeepAlive => true;

  void _clearFilters() {
    setState(() {
      _selectedPublicationDate = null;
      _selectedSource = "Apple";
      _selectedMediaTypes = [];
      _selectedRelevance = "Most Relevant";
      _selectedCategory = "Politics";
      _selectedNewsTone = "Positive";
      _selectedLanguage = "English";
      _location = "";
      _sliderValue = 50;
      _selectedFormat = "Written Article";
      _hasFilterChanges = false;
    });
    Navigator.pop(context);
  }

  void _applyFilters() {
    setState(() {
      _hasFilterChanges = false;
    });
    Navigator.pop(context);
  }

  Widget _buildStickyFilterActions(BuildContext context) {
    final theme = Theme.of(context);
    final mainColor = const Color(0xFFEF3054);
    final bool isDark = theme.brightness == Brightness.dark;
    if (_hasFilterChanges) {
      return Container(
        color: theme.canvasColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark ? Colors.grey[700] : Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _clearFilters,
                child: Text(
                  "Clear Filters",
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _applyFilters,
                child: const Text(
                  "Apply Filters",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else if (_hasSelectedFilters) {
      return Container(
        color: theme.canvasColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark ? Colors.grey[700] : Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _clearFilters,
                child: Text(
                  "Clear Filters",
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);
    bool isWide = MediaQuery.of(context).size.width >= 800;
    return Drawer(
      backgroundColor: theme.canvasColor,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(8.0),
                children: [
                  _buildExpandableDateRangeFilter(
                    context,
                    leadingIcon:
                        const Icon(Icons.date_range, color: Colors.blue),
                  ),
                  const SizedBox(height: 8),
                  _buildExpandableDropdownFilter(
                    context,
                    "Source",
                    ["Apple", "Google", "Tesla"],
                    leadingIcon:
                        const Icon(Icons.business, color: Colors.green),
                  ),
                  const SizedBox(height: 8),
                  _buildExpandableMultiSelectFilter(
                    context,
                    "Media Type",
                    [
                      "Digital Press",
                      "Blog",
                      "Social Media",
                      "Television",
                      "Radio"
                    ],
                    leadingIcon:
                        const Icon(Icons.perm_media, color: Colors.orange),
                  ),
                  const SizedBox(height: 8),
                  _buildExpandableDropdownFilter(
                    context,
                    "Relevance",
                    ["Most Relevant", "Most Recent", "Most Shared"],
                    leadingIcon:
                        const Icon(Icons.trending_up, color: Colors.purple),
                  ),
                  const SizedBox(height: 8),
                  _buildExpandableDropdownFilter(
                    context,
                    "Category",
                    [
                      "Politics",
                      "Economy",
                      "Technology",
                      "Entertainment",
                      "Sports"
                    ],
                    leadingIcon: const Icon(Icons.category, color: Colors.red),
                  ),
                  const SizedBox(height: 8),
                  _buildExpandableRadioFilter(
                    context,
                    "News Tone",
                    ["Positive", "Negative", "Neutral"],
                    leadingIcon:
                        const Icon(Icons.record_voice_over, color: Colors.teal),
                  ),
                  const SizedBox(height: 8),
                  _buildExpandableDropdownFilter(
                    context,
                    "Language",
                    ["English", "Spanish", "French"],
                    leadingIcon: const Icon(Icons.language, color: Colors.pink),
                  ),
                  const SizedBox(height: 8),
                  _buildExpandableTextInputFilter(
                    context,
                    "Location",
                    leadingIcon:
                        const Icon(Icons.location_on, color: Colors.amber),
                  ),
                  const SizedBox(height: 8),
                  _buildExpandableSliderFilter(
                    context,
                    "Popularity/Impact",
                    leadingIcon:
                        const Icon(Icons.bar_chart, color: Colors.cyan),
                    showCloseButton: isWide,
                  ),
                  const SizedBox(height: 8),
                  _buildExpandableDropdownFilter(
                    context,
                    "Format",
                    ["Written Article", "Video", "Podcast", "Infographic"],
                    leadingIcon:
                        const Icon(Icons.format_align_left, color: Colors.lime),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildStickyFilterActions(context),
                _buildActionTile(context, Icons.save, "Save Filters", () {}),
                _buildActionTile(context, Icons.notifications,
                    "Alerts & Notifications", () {}),
                _buildColorModeSwitch(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableDateRangeFilter(BuildContext context,
      {Icon? leadingIcon}) {
    final theme = Theme.of(context);
    List<String> options = ["Today", "Last Week", "Last Month", "Custom"];
    return Theme(
      data: theme.copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        leading: leadingIcon,
        title: Text(
          "Publication Date",
          style: theme.textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        childrenPadding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
        children: [
          Wrap(
            spacing: 4,
            children: options.map((option) {
              bool selected = _selectedPublicationDate == option;
              return OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor:
                      selected ? Colors.blue.withOpacity(0.2) : null,
                ),
                onPressed: () {
                  setState(() {
                    _selectedPublicationDate = option;
                    _hasFilterChanges = true;
                  });
                },
                child: Text(
                  option,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 12,
                    color: selected ? Colors.blue : null,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableDropdownFilter(
      BuildContext context, String title, List<String> items,
      {Icon? leadingIcon}) {
    final theme = Theme.of(context);
    String currentValue;
    switch (title) {
      case "Source":
        currentValue = _selectedSource;
        break;
      case "Relevance":
        currentValue = _selectedRelevance;
        break;
      case "Category":
        currentValue = _selectedCategory;
        break;
      case "Language":
        currentValue = _selectedLanguage;
        break;
      case "Format":
        currentValue = _selectedFormat;
        break;
      default:
        currentValue = items[0];
    }
    return Theme(
      data: theme.copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        leading: leadingIcon,
        title: Text(
          title,
          style: theme.textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        childrenPadding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: DropdownButton<String>(
              isExpanded: true,
              value: currentValue,
              items: items.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item,
                      style:
                          theme.textTheme.bodyMedium?.copyWith(fontSize: 12)),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _hasFilterChanges = true;
                    switch (title) {
                      case "Source":
                        _selectedSource = value;
                        break;
                      case "Relevance":
                        _selectedRelevance = value;
                        break;
                      case "Category":
                        _selectedCategory = value;
                        break;
                      case "Language":
                        _selectedLanguage = value;
                        break;
                      case "Format":
                        _selectedFormat = value;
                        break;
                    }
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableMultiSelectFilter(
      BuildContext context, String title, List<String> options,
      {Icon? leadingIcon}) {
    final theme = Theme.of(context);
    return Theme(
      data: theme.copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        leading: leadingIcon,
        title: Text(
          title,
          style: theme.textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        childrenPadding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Wrap(
              spacing: 4,
              children: options.map((option) {
                bool selected = _selectedMediaTypes.contains(option);
                return FilterChip(
                  label: Text(option,
                      style:
                          theme.textTheme.bodyMedium?.copyWith(fontSize: 12)),
                  selected: selected,
                  onSelected: (bool value) {
                    setState(() {
                      _hasFilterChanges = true;
                      if (value) {
                        _selectedMediaTypes.add(option);
                      } else {
                        _selectedMediaTypes.remove(option);
                      }
                    });
                  },
                  selectedColor: Colors.blue.withOpacity(0.2),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableRadioFilter(
      BuildContext context, String title, List<String> options,
      {Icon? leadingIcon}) {
    final theme = Theme.of(context);
    return Theme(
      data: theme.copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        leading: leadingIcon,
        title: Text(
          title,
          style: theme.textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        childrenPadding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(
              children: options.map((option) {
                bool selected = _selectedNewsTone == option;
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<String>(
                      value: option,
                      groupValue: _selectedNewsTone,
                      onChanged: (value) {
                        setState(() {
                          _hasFilterChanges = true;
                          _selectedNewsTone = value!;
                        });
                      },
                    ),
                    Text(option,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 12,
                          color: selected ? Colors.blue : null,
                        )),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableTextInputFilter(BuildContext context, String title,
      {Icon? leadingIcon}) {
    final theme = Theme.of(context);
    return Theme(
      data: theme.copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        leading: leadingIcon,
        title: Text(
          title,
          style: theme.textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        childrenPadding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: TextField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: "Enter $title",
              ),
              onChanged: (value) {
                setState(() {
                  _hasFilterChanges = true;
                  _location = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableSliderFilter(BuildContext context, String title,
      {Icon? leadingIcon, bool showCloseButton = false}) {
    final theme = Theme.of(context);
    return Theme(
      data: theme.copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        key: showCloseButton ? UniqueKey() : null,
        leading: leadingIcon,
        title: Text(
          title,
          style: theme.textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        childrenPadding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
        children: [
          StatefulBuilder(
            builder: (context, innerSetState) {
              return Slider(
                value: _sliderValue,
                min: 0,
                max: 100,
                divisions: 100,
                label: _sliderValue.round().toString(),
                onChanged: (value) {
                  innerSetState(() {
                    _sliderValue = value;
                  });
                  setState(() {
                    _hasFilterChanges = true;
                  });
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile(
      BuildContext context, IconData icon, String title, VoidCallback onTap) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Icon(icon),
      title: Text(title, style: theme.textTheme.titleMedium),
      onTap: onTap,
    );
  }

  Widget _buildColorModeSwitch(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: const Icon(Icons.brightness_6),
      title: Text("Color Mode",
          style: theme.textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.bold)),
      trailing: ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (context, themeMode, child) {
          return Switch(
            value: themeMode == ThemeMode.dark,
            onChanged: (bool value) {
              themeNotifier.value = value ? ThemeMode.dark : ThemeMode.light;
            },
            thumbIcon: WidgetStateProperty.resolveWith<Icon?>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.selected)) {
                  return const Icon(Icons.wb_sunny,
                      color: Colors.yellow, size: 20);
                }
                return const Icon(Icons.nightlight_round,
                    color: Colors.white, size: 20);
              },
            ),
            thumbColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.selected)) {
                  return const Color.fromARGB(255, 13, 64, 106);
                }
                return Colors.black;
              },
            ),
            activeColor: Colors.white,
            activeTrackColor: Colors.white,
            inactiveTrackColor: Colors.white,
          );
        },
      ),
    );
  }
}
