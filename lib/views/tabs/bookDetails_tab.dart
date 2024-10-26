import 'package:flutter/material.dart';
import 'package:namer_app/main.dart';
import 'package:namer_app/service/book_provider.dart';
import 'package:provider/provider.dart';

class BookdetailsTab extends StatefulWidget {
  @override
  _BookdetailsTab createState() => _BookdetailsTab();
}

class _BookdetailsTab extends State<BookdetailsTab> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<BookProvider>().fetchBooks());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Library Management'),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                  context
                      .read<BookProvider>()
                      .searchBooks(''); // Reset kết quả tìm kiếm
                }
              });
            },
          ),
        ],
        bottom: _isSearching
            ? PreferredSize(
                preferredSize: Size.fromHeight(50.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Tìm kiếm sách...',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          // Gọi phương thức tìm kiếm khi nhấn nút tìm kiếm
                          context
                              .read<BookProvider>()
                              .searchBooks(_searchController.text);
                        },
                      ),
                    ),
                    onSubmitted: (value) {
                      // Gọi phương thức tìm kiếm khi nhấn Enter
                      context.read<BookProvider>().searchBooks(value);
                    },
                  ),
                ),
              )
            : null,
      ),
      body: Consumer<BookProvider>(
        builder: (context, bookProvider, child) {
          if (bookProvider.state == BookState.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Có lỗi rồi',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(bookProvider.errorMessage ?? ''),
                ],
              ),
            );
          } else if (bookProvider.state == BookState.loading) {
            return Center(child: CircularProgressIndicator());
          }

          if (bookProvider.books.isEmpty) {
            return Center(
              child: Text(
                'Không tìm thấy kết quả nào.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            );
          }

          return bookProvider.books.isEmpty
              ? Center(child: Text('Không có dữ liệu'))
              : ListView.builder(
                  itemCount: (bookProvider.books.length / 2)
                      .ceil(), // Làm tròn lên để tính số hàng
                  itemBuilder: (context, rowIndex) {
                    final firstBookIndex = rowIndex *
                        2; // Tính chỉ số cuốn sách đầu tiên trong hàng
                    final secondBookIndex = firstBookIndex +
                        1; // Tính chỉ số cuốn sách thứ hai trong hàng

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Card đầu tiên
                        if (firstBookIndex <
                            bookProvider.books.length) // Kiểm tra chỉ số hợp lệ
                          Expanded(
                            child: Card(
                              elevation: 4,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Căn chỉnh ảnh cho vừa với Card
                                  Container(
                                    height: 150, // Chiều cao cố định cho ảnh
                                    width: double
                                        .infinity, // Để ảnh chiếm toàn bộ chiều rộng của Card
                                    child: Image.network(
                                      bookProvider
                                          .books[firstBookIndex].coverImgUrl,
                                      fit: BoxFit
                                          .cover, // Căn chỉnh ảnh cho đầy đủ không gian
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          bookProvider
                                              .books[firstBookIndex].name,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          bookProvider
                                              .books[firstBookIndex].details,
                                          style: TextStyle(fontSize: 14),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          'Published on: ${bookProvider.books[firstBookIndex].publishDate.toLocal().toString().split(' ')[0]}',
                                          style: TextStyle(fontSize: 11),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          'Price: \$${bookProvider.books[firstBookIndex].price}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                        // Card thứ hai
                        if (secondBookIndex <
                            bookProvider.books.length) // Kiểm tra chỉ số hợp lệ
                          Expanded(
                            child: Card(
                              elevation: 4,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    bookProvider
                                        .books[secondBookIndex].coverImgUrl,
                                    width: double.infinity,
                                    height:
                                        150, // Điều chỉnh chiều cao hình ảnh
                                    fit: BoxFit.cover,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          bookProvider
                                              .books[secondBookIndex].name,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          bookProvider
                                              .books[secondBookIndex].details,
                                          style: TextStyle(fontSize: 14),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          'Published on: ${bookProvider.books[secondBookIndex].publishDate.toLocal().toString().split(' ')[0]}',
                                          style: TextStyle(fontSize: 11),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          'Price: \$${bookProvider.books[secondBookIndex].price}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                );
        },
      ),
    );
  }
}
