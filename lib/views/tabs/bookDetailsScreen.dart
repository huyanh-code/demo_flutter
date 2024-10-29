import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:namer_app/service/book_provider.dart';
import 'package:namer_app/state/app_state.dart';
import 'package:namer_app/widgets/book_api.dart';
import 'package:provider/provider.dart';

class BookDetailScreen extends StatelessWidget {
  final Books book; // Nhận thông tin cuốn sách từ BookDetailsTab
  BookDetailScreen({required this.book});

  @override
  Widget build(BuildContext context) {
    // final bookProvider = context.read<BookProvider>();
    // final myAppState = context.read<MyAppState>();

    return Scaffold(
      appBar: AppBar(
        title: Text(book.name),
        actions: [
          Consumer2<BookProvider, MyAppState>(
            builder: (context, bookProvider, myAppState, child) {
              final isFavorite = bookProvider.isFavorite(book);
              return IconButton(
                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                color: isFavorite ? Colors.red[900] : null,
                onPressed: () {
                  bookProvider.toggleFavoriteStatus(book);
                  if (isFavorite) {
                    myAppState.removeFavorite(book);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              '${book.name} đã bị xóa khỏi danh sách yêu thích!')
                      ),
                    );
                  } else {
                    myAppState.addFavorite(book);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              '${book.name} đã được thêm vào danh sách yêu thích!')
                      ),
                    );
                  }
                  // Cập nhật trạng thái trong BookProvider
                  bookProvider.setFavoriteStatus(book, !isFavorite);
                },
              );
            },
          ),

          // Consumer<BookProvider>(builder: (context, bookProvider, child) {
          //   final isFavorite = bookProvider.isFavorite(book);
          //   return IconButton(
          //     icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
          //     color: isFavorite ? Colors.red[900] : null,
          //     onPressed: () {
          //       if (!isFavorite) {
          //         bookProvider.toggleFavorite(book);
          //         ScaffoldMessenger.of(context).showSnackBar(
          //           SnackBar(content: Text('${book.name} đã được thêm vào danh sách yêu thích!')),
          //         );
          //       } else {
          //         ScaffoldMessenger.of(context).showSnackBar(
          //           SnackBar(content: Text('${book.name} đã tồn tại trong danh sách yêu thích!')),
          //         );
          //       }
          //     },
          //   );
          // }),

          // Builder(builder: (context) {
          //   final myAppState = context.read<MyAppState>();
          //   final isFavourite = myAppState.isFavorite(book);
          //   return IconButton(
          //     icon: Icon(isFavourite ? Icons.favorite : Icons.favorite_border),
          //     color: isFavourite ? Colors.red[900] : null,
          //     onPressed: () {
          //       myAppState.toggleFavorite(book);
          //       ScaffoldMessenger.of(context).showSnackBar(
          //         SnackBar(
          //           content: Text(
          //             isFavourite
          //                 ? '${book.name} đã xóa khỏi danh sách yêu thích!'
          //                 : '${book.name} đã thêm vào danh sách yêu thích!',
          //           ),
          //         ),
          //       );
          //     },
          //   );
          // }),
          IconButton(
            icon: Icon(Icons.shopping_cart), // Icon giỏ hàng
            onPressed: () {
              // Thêm hành động cho nút "cart"
              // Bạn có thể thêm logic để thêm sản phẩm vào giỏ hàng
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hiển thị hình ảnh bìa sách
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(book.coverImgUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Hiển thị tên sách
              Text(
                book.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              // Hiển thị chi tiết sách
              Text(
                book.details,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              // Hiển thị ngày xuất bản
              Text(
                'Published on: ${DateFormat('dd/MM/yyyy').format(book.publishDate)}',
                style: TextStyle(fontSize: 11),
              ),
              SizedBox(height: 8),
              // Hiển thị giá
              Text(
                'Price: \$${book.price}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 16),
              // Nút thêm vào giỏ hàng
              ElevatedButton(
                onPressed: () {
                  // Thêm hành động cho nút "Add to Cart"
                  // Bạn có thể thêm logic để thêm sản phẩm vào giỏ hàng
                },
                child: Text('Add to Cart'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
