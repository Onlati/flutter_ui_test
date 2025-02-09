import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ArticleCard extends StatefulWidget {
  final Map<String, String> article;
  final int index;
  final VoidCallback onShare;

  const ArticleCard({
    Key? key,
    required this.article,
    required this.index,
    required this.onShare,
  }) : super(key: key);

  @override
  _ArticleCardState createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard>
    with AutomaticKeepAliveClientMixin {
  bool _isLoading = true;

  @override
  bool get wantKeepAlive => true; // Conservar el estado de la tarjeta

  @override
  void initState() {
    super.initState();
    // Simula una carga desde el servidor durante 2 segundos
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Obligatorio al usar AutomaticKeepAliveClientMixin
    final theme = Theme.of(context);
    final List<Color> iconColors = [
      Colors.blue,
      Colors.red,
      Colors.orange,
      Colors.green,
      Colors.purple,
    ];
    String snippet = widget.article["snippet"]!;
    if (snippet.length > 60) {
      snippet = snippet.substring(0, 60) + "...";
    }
    if (_isLoading) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Card(
          margin: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(width: 24, height: 24, color: Colors.white),
                    const SizedBox(width: 8),
                    Expanded(child: Container(height: 16, color: Colors.white)),
                  ],
                ),
                const SizedBox(height: 8),
                Container(height: 12, width: 100, color: Colors.white),
                const SizedBox(height: 4),
                Container(height: 14, color: Colors.white),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(width: 60, height: 20, color: Colors.white),
                    const SizedBox(width: 8),
                    Container(width: 60, height: 20, color: Colors.white),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return Card(
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor:
                        iconColors[widget.index % iconColors.length],
                    radius: 12,
                    child:
                        const Icon(Icons.public, size: 12, color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.article["title"]!,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                widget.article["url"]!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.secondary,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                snippet,
                style: theme.textTheme.bodyMedium?.copyWith(fontSize: 14),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text("View More"),
                  ),
                  TextButton(
                    onPressed: widget.onShare,
                    child: const Text("Share"),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }
}
