import 'package:flutter/material.dart' hide MenuBar;
import '../models/book.dart';
import '../data/http_helper.dart';
import 'package:menu_bar/menu_bar.dart';

class BookListScreen extends StatefulWidget {
  const BookListScreen({super.key});

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  final HttpHelper helper = HttpHelper();
  List<Book> books = [];
  List<Color> bgColors = [];

  @override
  void initState() {
    super.initState();
    helper.getBooks('flutter').then((List<Book> value) {
      int i;
      for (i = 0; i < value.length; i++) {
        bgColors.add(Colors.white);
      }

      setState(() {
        books = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isLargeScreen;
    if (MediaQuery.of(context).size.width > 600) {
      isLargeScreen = true;
    } else {
      isLargeScreen = false;
    }
    List<BarButton> myMenu = buildBarButton();

    return MenuBarWidget(
      barButtons: myMenu,
      child: Scaffold(
          appBar: AppBar(title: const Text('Books')),
          body: GridView.count(
              childAspectRatio: isLargeScreen ? 8 : 5,
              crossAxisCount: isLargeScreen ? 2 : 1,
              children: List.generate(books.length, (index) {
                return GestureDetector(
                  onTap: () => setColor(Colors.lightBlue, index),
                  onSecondaryTap: () => setColor(Colors.white, index),
                  onLongPress: () => setColor(Colors.white, index),
                  child: ColoredBox(
                    color: bgColors.isNotEmpty ? bgColors[index] : Colors.white,
                    child: ListTile(
                      title: Text(books[index].title),
                      subtitle: Text(books[index].authors),
                      leading: CircleAvatar(
                        backgroundImage: (books[index].thumbnail) == ''
                            ? null
                            : NetworkImage(books[index].thumbnail),
                      ),
                    ),
                  ),
                );
              }))),
    );
  }

  void setColor(Color color, int index) {
    setState(() {
      bgColors[index] = color;
    });
  }

  void updateBooks(String key) {
    helper.getBooks(key).then((List<Book> value) {
      List<Color> newBgColors = List.generate(value.length, (index) => Colors.white);
      setState(() {
        books = value;
        bgColors = newBgColors;
      });
    });
  }

  List<BarButton> buildBarButton() {
    return [
      BarButton(
        text: const Text(
          'Search',
          style: TextStyle(color: Colors.white),
        ),
        submenu: SubMenu(menuItems: [
          MenuButton(
            onTap: () {
              updateBooks('Flutter');
            },
            text: const Text('Flutter'),
          ),
          MenuButton(
            onTap: () {
              updateBooks('C#');
            },
            text: const Text('C#'),
          ),
          MenuButton(
            onTap: () {
              updateBooks('JavaScript');
            },
            text: const Text('JavaScript'),
          ),
        ]),
      )
    ];
  }
}
