import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: NavigationRailPage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}

class NavigationRailPage extends StatefulWidget {
  const NavigationRailPage({Key? key}) : super(key: key);

  @override
  State<NavigationRailPage> createState() => _NavigationRailPageState();
}

const _navBarItems = [
  BottomNavigationBarItem(
    icon: Icon(Icons.home_outlined),
    activeIcon: Icon(Icons.home_rounded),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.favorite),
    activeIcon: Icon(Icons.favorite_rounded),
    label: 'Favorites',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.bookmark_border_outlined),
    activeIcon: Icon(Icons.bookmark_rounded),
    label: 'Bookmarks',
  ),
];

class _NavigationRailPageState extends State<NavigationRailPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isSmallScreen = width < 600;
    final bool isLargeScreen = width > 800;

    Widget page;
    switch (_selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        page = FavoritesPage();
        break;
      case 2:
        page = BookmarkPage();
        break;
      default:
        throw UnimplementedError('no widget for $_selectedIndex');
    }

    return Scaffold(
      bottomNavigationBar: isSmallScreen
          ? BottomNavigationBar(
              items: _navBarItems,
              currentIndex: _selectedIndex,
              onTap: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            )
          : null,
      body: Row(
        children: <Widget>[
          if (!isSmallScreen)
            NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              extended: isLargeScreen,
              destinations: _navBarItems
                  .map((item) => NavigationRailDestination(
                        icon: item.icon,
                        selectedIcon: item.activeIcon,
                        label: Text(
                          item.label!,
                        ),
                      ))
                  .toList(),
            ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: page, // Chuyển nội dung chính sang trang tương ứng
          )
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: pair),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return Center(child: Text('No favorites yet.'));
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('You have ${appState.favorites.length} favorites:'),
        ),
        for (var pair in appState.favorites)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(pair.asLowerCase),
          ),
      ],
    );
  }
}

class BookmarkPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Bookmark Page', style: TextStyle(fontSize: 24)),
          SizedBox(height: 20),
          // Thêm card sách tại đây
          BookCard(
            bookName: "The godfather",
            author: "John Doe",
            price: "\$29.99",
            rating: "4.5",
            details: "Bố già (tiếng Anh: The Godfather) là tên một cuốn tiểu thuyết nổi tiếng của nhà văn người Mỹ gốc Ý Mario Puzo, được nhà xuất bản G. P. Putnam's Sons xuất bản lần đầu vào năm 1969. Tác phẩm là câu chuyện về một gia đình mafia gốc Sicilia tại Mỹ, được một nhân vật gọi là Bố già (Godfather) Don Vito Corleone tạo lập và lãnh đạo. Các sự kiện chính của tiểu thuyết xảy ra từ năm 1945 đến 1955, ngoài ra cũng đề cập đến thời thơ ấu và giai đoạn thanh niên của Vito Corleone vào đầu thế kỉ 20.",
            imageUrl: "data:image/jpeg;base64,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",
          ),
          BookCard(
            bookName: "Ormeta",
            author: "Jane Smith",
            price: "\$39.99",
            rating: "4.8",
            details: "Luật im lặng (Omertà) là tiểu thuyết sáng tác bởi Mario Puzo (tác giả của tiểu thuyết Bố già), được xuất bản năm 2000 sau khi tác giả qua đời bởi Ballantine Books. Tiểu thuyết kể về cuộc phiêu lưu của chàng thanh niên Astorre Viola, cháu nuôi của Trùm mafia Raymond Aprile, trong thế giới xã hội đen của Mafia Mỹ và Ý.",
            imageUrl: "data:image/jpeg;base64,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", 
          ),
        ],
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  final String bookName;
  final String author;
  final String price;
  final String rating;
  final String details;
  final String imageUrl;

  const BookCard({
    super.key,
    required this.bookName,
    required this.author,
    required this.price,
    required this.rating,
    required this.details,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row( // Sử dụng Row để sắp xếp các thành phần theo chiều ngang
          children: [
            // Hình ảnh ở bên trái
            Image.network(
              imageUrl,
              width: 100,
              height: 150,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 15),
            Expanded( 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bookName,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text('Author: $author'),
                  Text('Price: $price'),
                  Text('Rating: $rating ⭐'),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 60,
                    child: SingleChildScrollView(  
                      child: Text(details),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


