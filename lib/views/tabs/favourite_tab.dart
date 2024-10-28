import 'package:flutter/material.dart';
import 'package:namer_app/state/app_state.dart';
import 'package:namer_app/views/tabs/bookDetailsScreen.dart';
import 'package:provider/provider.dart';

class FavouriteTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myAppState = Provider.of<MyAppState>(context);
    final favorites = myAppState.favorites; // Lấy danh sách yêu thích

    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite Books'),
      ),
      body: favorites.isEmpty
          ? Center(child: Text('No favorites yet.')) // Thông báo nếu không có sách yêu thích
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final book = favorites[index];
                return ListTile(
                  title: Text(book.name), // Hiển thị tên sách
                  subtitle: Text(book.details), // Hiển thị chi tiết sách
                  leading: Image.network(book.coverImgUrl), // Hiển thị hình ảnh bìa sách
                  onTap: () {
                    // Mở màn hình chi tiết cuốn sách
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailScreen(book: book),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
