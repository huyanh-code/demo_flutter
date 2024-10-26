import 'package:flutter/material.dart';
import 'package:namer_app/common/app_theme.dart';
import 'package:namer_app/widgets/book_card.dart';
import 'package:namer_app/widgets/book_card.dart';

class BookmarkTab extends StatelessWidget {
  final SearchController controller = SearchController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookmarks"),
        actions: [
          // Search button in the AppBar
          SearchAnchor(
            searchController: controller,
            builder: (BuildContext context, SearchController controller) {
              return IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  controller.openView();
                },
              );
            },
            suggestionsBuilder:
                (BuildContext context, SearchController controller) {
              return List<ListTile>.generate(5, (int index) {
                final String item = 'item $index';
                return ListTile(
                  title: Text(item),
                  onTap: () {
                    controller.closeView(item);
                  },
                );
              });
            },
          ),
        ],
      ),
      body: Center(
        child: ListView(
          children: const [
            // Text('Bookmark Page',
            //     style: TextStyle(fontSize: 24, color: Color(0xFFfc4e03))),
            // SizedBox(height: 20),
            // Thêm card sách tại đây
            BookCard(
              bookName: "The godfather",
              author: "Mario puzo",
              price: "\$29.99",
              rating: "3",
              details:
                  "Bố già (tiếng Anh: The Godfather) là tên một cuốn tiểu thuyết nổi tiếng của nhà văn người Mỹ gốc Ý Mario Puzo, được nhà xuất bản G. P. Putnam's Sons xuất bản lần đầu vào năm 1969. Tác phẩm là câu chuyện về một gia đình mafia gốc Sicilia tại Mỹ, được một nhân vật gọi là Bố già (Godfather) Don Vito Corleone tạo lập và lãnh đạo. Các sự kiện chính của tiểu thuyết xảy ra từ năm 1945 đến 1955, ngoài ra cũng đề cập đến thời thơ ấu và giai đoạn thanh niên của Vito Corleone vào đầu thế kỉ 20.",
              imageUrl:
                  "https://randomwordgenerator.com/img/picture-generator/52e3d6464353a414f1dc8460962e33791c3ad6e04e50744172287ad39644cc_640.jpg",
            ),
            BookCard(
              bookName: "Ormeta",
              author: "Mario puzo",
              price: "\$39.99",
              rating: "4.8",
              details:
                  "Luật im lặng (Omertà) là tiểu thuyết sáng tác bởi Mario Puzo (tác giả của tiểu thuyết Bố già), được xuất bản năm 2000 sau khi tác giả qua đời bởi Ballantine Books. Tiểu thuyết kể về cuộc phiêu lưu của chàng thanh niên Astorre Viola, cháu nuôi của Trùm mafia Raymond Aprile, trong thế giới xã hội đen của Mafia Mỹ và Ý.",
              imageUrl:
                  "https://randomwordgenerator.com/img/picture-generator/55e3d3444a52b10ff3d8992cc12c30771037dbf85254784a722e7cd09e4d_640.jpg",
            ),
            BookCard(
              bookName: "Ormeta",
              author: "Mario puzo",
              price: "\$39.99",
              rating: "4.8",
              details:
                  "Luật im lặng (Omertà) là tiểu thuyết sáng tác bởi Mario Puzo (tác giả của tiểu thuyết Bố già), được xuất bản năm 2000 sau khi tác giả qua đời bởi Ballantine Books. Tiểu thuyết kể về cuộc phiêu lưu của chàng thanh niên Astorre Viola, cháu nuôi của Trùm mafia Raymond Aprile, trong thế giới xã hội đen của Mafia Mỹ và Ý.",
              imageUrl:
                  "https://randomwordgenerator.com/img/picture-generator/57e5d2424a54a414f1dc8460962e33791c3ad6e04e507440762e7adc904cc6_640.jpg",
            ),
            BookCard(
              bookName: "Ormeta",
              author: "Mario puzo",
              price: "\$39.99",
              rating: "4.8",
              details:
                  "Luật im lặng (Omertà) là tiểu thuyết sáng tác bởi Mario Puzo (tác giả của tiểu thuyết Bố già), được xuất bản năm 2000 sau khi tác giả qua đời bởi Ballantine Books. Tiểu thuyết kể về cuộc phiêu lưu của chàng thanh niên Astorre Viola, cháu nuôi của Trùm mafia Raymond Aprile, trong thế giới xã hội đen của Mafia Mỹ và Ý.",
              imageUrl:
                  "https://randomwordgenerator.com/img/picture-generator/57e4d04a4950ae14f1dc8460962e33791c3ad6e04e5074417d2d73d3934ac3_640.jpg",
            ),
            BookCard(
              bookName: "Ormeta",
              author: "Mario puzo",
              price: "\$39.99",
              rating: "4.8",
              details:
                  "Luật im lặng (Omertà) là tiểu thuyết sáng tác bởi Mario Puzo (tác giả của tiểu thuyết Bố già), được xuất bản năm 2000 sau khi tác giả qua đời bởi Ballantine Books. Tiểu thuyết kể về cuộc phiêu lưu của chàng thanh niên Astorre Viola, cháu nuôi của Trùm mafia Raymond Aprile, trong thế giới xã hội đen của Mafia Mỹ và Ý.",
              imageUrl:
                  "https://randomwordgenerator.com/img/picture-generator/52e0d74a495bb10ff3d8992cc12c30771037dbf85257714b7d2679d59048_640.jpg",
            ),
            BookCard(
              bookName: "Ormeta",
              author: "Mario puzo",
              price: "\$39.99",
              rating: "4.8",
              details:
                  "Luật im lặng (Omertà) là tiểu thuyết sáng tác bởi Mario Puzo (tác giả của tiểu thuyết Bố già), được xuất bản năm 2000 sau khi tác giả qua đời bởi Ballantine Books. Tiểu thuyết kể về cuộc phiêu lưu của chàng thanh niên Astorre Viola, cháu nuôi của Trùm mafia Raymond Aprile, trong thế giới xã hội đen của Mafia Mỹ và Ý.",
              imageUrl:
                  "https://randomwordgenerator.com/img/picture-generator/50e2dd414d4faa0df7c5d57bc32f3e7b1d3ac3e456587049722c7dd291_640.jpg",
            ),
            BookCard(
              bookName: "Ormeta",
              author: "Mario puzo",
              price: "\$39.99",
              rating: "4.8",
              details:
                  "Luật im lặng (Omertà) là tiểu thuyết sáng tác bởi Mario Puzo (tác giả của tiểu thuyết Bố già), được xuất bản năm 2000 sau khi tác giả qua đời bởi Ballantine Books. Tiểu thuyết kể về cuộc phiêu lưu của chàng thanh niên Astorre Viola, cháu nuôi của Trùm mafia Raymond Aprile, trong thế giới xã hội đen của Mafia Mỹ và Ý.",
              imageUrl:
                  "https://randomwordgenerator.com/img/picture-generator/g5900afbace889449de13b9517d62c4523c263e41fb608327c8cc26f1ad4e5b85f9414b61f23590fe1db589b27a043bf2_640.jpg",
            ),
            BookCard(
              bookName: "Ormeta",
              author: "Mario puzo",
              price: "\$39.99",
              rating: "4.8",
              details:
                  "Luật im lặng (Omertà) là tiểu thuyết sáng tác bởi Mario Puzo (tác giả của tiểu thuyết Bố già), được xuất bản năm 2000 sau khi tác giả qua đời bởi Ballantine Books. Tiểu thuyết kể về cuộc phiêu lưu của chàng thanh niên Astorre Viola, cháu nuôi của Trùm mafia Raymond Aprile, trong thế giới xã hội đen của Mafia Mỹ và Ý.",
              imageUrl:
                  "https://randomwordgenerator.com/img/picture-generator/51e3d7444c52b10ff3d8992cc12c30771037dbf85254784e77267fd39f4d_640.jpg",
            ),
          ],
        ),
      ),
    );
  }
}
