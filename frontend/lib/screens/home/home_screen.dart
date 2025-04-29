import 'package:app_01/models/post.dart';
import 'package:app_01/screens/careers/careers_screen.dart';
import 'package:app_01/screens/chat/chat_screen.dart';
import 'package:app_01/screens/profile/profile_screen.dart';
import 'package:app_01/screens/home/video_screen.dart';
import 'package:app_01/widgets/bottom_navigation.dart';
import 'package:app_01/widgets/top_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  final List<Post> posts = [
    Post(
      id: '1',
      userName: 'John Doe',
      userAvatar: 'https://placeholder.com/150',
      content: 'Just had an amazing day at work! #coding #flutter',
      imageUrl: 'https://placeholder.com/400x300',
      timestamp: DateTime.now().subtract(Duration(hours: 2)),
      comments: [],
    ),
        Post(
      id: '2',
      userName: 'John Doe',
      userAvatar: 'https://placeholder.com/150',
      content: 'Just had an amazing day at work! #coding #flutter',
      imageUrl: 'https://placeholder.com/400x300',
      timestamp: DateTime.now().subtract(Duration(hours: 2)),
      comments: [],
    ),
        Post(
      id: '1',
      userName: 'John Doe',
      userAvatar: 'https://placeholder.com/150',
      content: 'Just had an amazing day at work! #coding #flutter',
      imageUrl: 'https://placeholder.com/400x300',
      timestamp: DateTime.now().subtract(Duration(hours: 2)),
      comments: [],
    ),
    // Add more sample posts here
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavigationBar(),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: [
          HomeContent(posts: posts),
          VideoScreen(),
          CareersScreen(),
          ChatScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  final List<Post> posts;

  const HomeContent({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return PostCard(post: posts[index]);
      },
    );
  }
}

class PostCard extends StatefulWidget {
  final Post post;

  const PostCard({Key? key, required this.post}) : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLiked = false;
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _toggleLike() {
    setState(() {
      if (isLiked) {
        widget.post.likes--;
      } else {
        widget.post.likes++;
      }
      isLiked = !isLiked;
    });
  }

  void _showCommentModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  hintText: 'Write a comment...',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  if (_commentController.text.isNotEmpty) {
                    setState(() {
                      widget.post.comments.add(
                        Comment(
                          userName: 'Current User',
                          userAvatar: 'https://placeholder.com/150',
                          content: _commentController.text,
                          timestamp: DateTime.now(),
                        ),
                      );
                    });
                    _commentController.clear();
                    Navigator.pop(context);
                  }
                },
                child: Text('Post Comment'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showShareOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Share to Timeline'),
              onTap: () {
                // Implement share to timeline
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.chat),
              title: Text('Share via Message'),
              onTap: () {
                // Implement share via message
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.copy),
              title: Text('Copy Link'),
              onTap: () {
                // Implement copy link
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(widget.post.userAvatar),
            ),
            title: Text(
              widget.post.userName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              timeago.format(widget.post.timestamp),
            ),
            trailing: IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                // Implement post options menu
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(widget.post.content),
          ),
          if (widget.post.imageUrl != null)
            Image.network(
              widget.post.imageUrl!,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Text('${widget.post.likes} likes'),
                SizedBox(width: 8),
                Text('${widget.post.comments.length} comments'),
              ],
            ),
          ),
          Divider(height: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: _toggleLike,
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.red : null,
                ),
                label: Text('Like'),
              ),
              TextButton.icon(
                onPressed: _showCommentModal,
                icon: Icon(Icons.comment_outlined),
                label: Text('Comment'),
              ),
              TextButton.icon(
                onPressed: _showShareOptions,
                icon: Icon(Icons.share_outlined),
                label: Text('Share'),
              ),
            ],
          ),
          if (widget.post.comments.isNotEmpty)
            Container(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.post.comments
                    .take(2)
                    .map((comment) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 12,
                                backgroundImage:
                                    NetworkImage(comment.userAvatar),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      comment.userName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(comment.content),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}