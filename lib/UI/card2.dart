import 'package:flutter/material.dart';
import 'detail.dart';
import '../api/api.dart';
import '../models/favorites.dart';
void main() {
  runApp(FavoritesPage());
}

class FavoritesPage extends StatelessWidget {
 final API api = API();
 
  FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: API.getArticleInFavorites(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done &&
            !snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        if (snapshot.data != null) {
          return ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (BuildContext context, index) {
              int itemNo = snapshot.data?[index].id ?? 0;
              return Card(
                color: Colors.white,
                elevation: 7,
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    child: Image.network(
                      snapshot.data?[index].image ?? "",
                      width: 200,
                      height: 200,
                    )
                  ),
                  title: Text(snapshot.data?[index].title ?? ""),
                  subtitle: Text(snapshot.data?[index].tags.join(" ") ?? ""),
                  trailing: Wrap(
                    children: [
                    IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Detail(article: snapshot.data![index]),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    key: Key('icon_$itemNo'),
                    icon: Favorites.staticItems.contains(itemNo)
                        ? const Icon(Icons.favorite)
                        : const Icon(Icons.favorite_border),
                    onPressed: () {
                      !Favorites.staticItems.contains(itemNo)
                          ? Favorites.staticItems.add(itemNo)
                          : Favorites.staticItems.remove(itemNo);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(Favorites.staticItems.contains(itemNo)
                              ? 'Added to favorites.'
                              : 'Removed from favorites.'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  )
                    ],
                ),
                ),
              );
            },
          );
        }
        return Container();
      },
    );
  }
}