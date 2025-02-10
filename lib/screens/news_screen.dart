// lib/news_screen.dart
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_ui_test/widgets/article_card.dart';
import 'package:flutter_ui_test/widgets/side_menu.dart';
import 'package:flutter_ui_test/widgets/filter_drawer.dart';
import 'package:flutter_ui_test/widgets/header.dart';
import 'package:flutter_ui_test/widgets/search_row.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final List<Map<String, String>> articles = [
    {
      "title": "Apple launches the new iPhone 15",
      "url": "https://www.apple.com/iphone-15",
      "snippet":
          "The new iPhone 15 introduces innovations in camera and battery life, marking a new era in smartphones."
    },
    {
      "title": "Google updates its search algorithm",
      "url": "https://www.google.com",
      "snippet":
          "Google's latest update promises more accurate and relevant results for users worldwide."
    },
    {
      "title": "Tesla announces advances in battery technology",
      "url": "https://www.tesla.com",
      "snippet":
          "Tesla reveals significant improvements in its batteries, reducing charging times and increasing energy efficiency."
    },
    {
      "title": "Netflix premieres original series 'The Conspiracy'",
      "url": "https://www.netflix.com",
      "snippet":
          "Netflix's new series has captured attention with its intriguing plot and high production quality, generating global buzz."
    },
    {
      "title": "Amazon revolutionizes e-commerce in 2025",
      "url": "https://www.amazon.com",
      "snippet":
          "Amazon launches new AI tools to personalize the shopping experience and optimize logistics."
    },
  ];

  void _shareArticle(String url) {
    Share.share(url);
  }

  @override
  Widget build(BuildContext context) {
    bool isWide = MediaQuery.of(context).size.width >= 800;
    return Scaffold(
      drawer: isWide ? null : SideMenu(),
      endDrawer: FilterDrawer(),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= 800) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SideMenu(),
                  Expanded(
                    child: Column(
                      children: [
                        const WideHeader(),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(8.0),
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: articles.asMap().entries.map((entry) {
                                int index = entry.key;
                                Map<String, String> article = entry.value;
                                return ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(maxWidth: 300),
                                  child: ArticleCard(
                                    article: article,
                                    index: index,
                                    onShare: () =>
                                        _shareArticle(article["url"]!),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Column(
                children: [
                  const MobileHeader(),
                  const SearchRow(),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        final article = articles[index];
                        return ArticleCard(
                          article: article,
                          index: index,
                          onShare: () => _shareArticle(article["url"]!),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
