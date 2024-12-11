import 'package:flutter/cupertino.dart';
import '../models/news_item.dart';
import '../utils/app_colors.dart';

class FeedTab extends StatelessWidget {
  final List<NewsItem> newsItems = [
    NewsItem(
      title: 'New Advances in Cosmetology',
      summary: 'Discover the latest trends and techniques in the field.',
      imageUrl: 'assets/news1.jpg',
      date: DateTime.now(),
    ),
    NewsItem(
      title: 'Health Tips from Experts',
      summary: 'Learn how to maintain a healthy lifestyle with expert advice.',
      imageUrl: 'assets/news2.jpg',
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Feed', 
          style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
        ),
      ),
      child: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: newsItems.length,
          itemBuilder: (context, index) {
            final newsItem = newsItems[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: CupertinoColors.systemGrey.withOpacity(0.2),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.asset(newsItem.imageUrl, fit: BoxFit.cover),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          newsItem.title,
                          style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          newsItem.summary,
                          style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${newsItem.date.day}/${newsItem.date.month}/${newsItem.date.year}',
                          style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}