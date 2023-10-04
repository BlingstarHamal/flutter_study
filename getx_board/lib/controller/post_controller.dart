import 'package:get/get.dart';
import 'package:getx_board/domain/post/post.dart';
import 'package:getx_board/domain/post/post_repository.dart';

class PostController extends GetxController {
  final PostRepository _postRepository = PostRepository();
  final posts = <Post>[].obs; // 관찰가능
  final post = Post().obs;

  @override
  void onInit() {
    super.onInit();
    findAll();
  }

  Future<void> save(String title, String content) async {
    Post post = await _postRepository.save(title, content);
    if (post.id != null) {
      posts.add(post);
    }
  }

  Future<void> updateById(int id, String title, String content) async {
    Post post = await _postRepository.updateById(id, title, content);
    if (post.id != null) {
      this.post.value = post;
      posts.value = posts
          .map((e) => e.id == id ? post : e)
          .toList(); // posts를 map으로 순회하면서 e를 담고 이값이 수정한 id와 같으면 수정된 post로 받음
    }
  }

  Future<void> deleteById(int id) async {
    int result = await _postRepository.deleteById(id);
    if (result == 1) {
      print('서버 쪽 삭제 성공');
      List<Post> result = posts.where((post) => post.id != id).toList();
      print(result.length);
      posts.value = result;
    }
  }

  Future<void> findAll() async {
    List<Post> posts = await _postRepository.findAll();
    this.posts.value = posts;
  }

  Future<void> findById(int id) async {
    Post post = await _postRepository.findById(id);
    this.post.value = post; // this는 상단의 post를 말함 우항의 post가 바로위의 post
  }
}
