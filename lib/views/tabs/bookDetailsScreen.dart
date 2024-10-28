import 'package:flutter/material.dart';
import 'package:namer_app/state/app_state.dart';
import 'package:namer_app/widgets/book_api.dart';
import 'package:provider/provider.dart'; // Import mô hình Books

class BookDetailScreen extends StatelessWidget {
  final Books book; // Nhận thông tin cuốn sách từ BookDetailsTab

  BookDetailScreen({required this.book});

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.name),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border), // Icon trái tim
            onPressed: () {
              Provider.of<MyAppState>(context, listen: false).addFavorite(book);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${book.name} đã được thêm vào yêu thích!')),
              );
            },
          ),
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
                'Published on: ${book.publishDate.toLocal().toString().split(' ')[0]}',
                style: TextStyle(fontSize: 14),
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
