import 'package:flutter/material.dart';
import 'package:namer_app/service/book_provider.dart';
import 'package:namer_app/views/tabs/bookDetailsScreen.dart';
import 'package:namer_app/widgets/book_api.dart';
import 'package:provider/provider.dart';

class BookdetailsTab extends StatefulWidget {
  @override
  _BookdetailsTab createState() => _BookdetailsTab();
}

class _BookdetailsTab extends State<BookdetailsTab> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  
  List<Books> filteredBooks = []; // Danh sách sách được lọc

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final bookProvider = context.read<BookProvider>();
      bookProvider.fetchBooks().then((_) {
        setState(() {
          filteredBooks = bookProvider.books; // Gán toàn bộ sách vào filteredBooks
        });
      });
    });
  }

  void _searchBooks() {
    final bookProvider = context.read<BookProvider>();
    final query = _searchController.text;
    setState(() {
      // Nếu truy vấn rỗng, hiển thị toàn bộ sách
      if (query.isEmpty) {
        filteredBooks = bookProvider.books;
      } else {
        // Lọc sách dựa trên truy vấn
        filteredBooks = bookProvider.books
            .where((book) => book.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
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
                  filteredBooks = context.read<BookProvider>().books; // Reset filteredBooks khi không tìm kiếm
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
                        onPressed: _searchBooks, // Gọi phương thức tìm kiếm khi nhấn nút
                      ),
                    ),
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

          if (filteredBooks.isEmpty) {
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

          return GridView.builder(
            padding: EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.7,
            ),
            itemCount: filteredBooks.length,
            itemBuilder: (context, index) {
              final book = filteredBooks[index];
              return GestureDetector(
                onTap: () {
                  // Điều hướng đến màn hình BookDetailScreen khi nhấn vào Card
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookDetailScreen(book: book),
                    ),
                  );
                },
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 160,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(8)),
                        ),
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(8)),
                          child: Image.network(
                            book.coverImgUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                book.name,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                              Text(
                                book.details,
                                style: TextStyle(fontSize: 14),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Published on: ${book.publishDate.toLocal().toString().split(' ')[0]}',
                                style: TextStyle(fontSize: 11),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Price: \$${book.price}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
