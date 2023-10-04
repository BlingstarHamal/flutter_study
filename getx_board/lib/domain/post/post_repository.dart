import 'package:get/get.dart';
import 'package:getx_board/controller/dto/cmrespdto.dart';
import 'package:getx_board/controller/dto/saveorupdatereqdto.dart';
import 'package:getx_board/domain/post/post.dart';
import 'package:getx_board/domain/post/post_provider.dart';
// import 'package:getx_board/util/convert_utf8.dart';

// repository의 역할 : 통신 호출해서 응답되는 데이터를 가공 json => dart 오브젝트로

class PostRepository {
  // _ 하면 여기서만 사용가능해짐
  final PostProvider _postProvider = PostProvider();

  Future<Post> save(String title, String content) async {
    SaveOrUpdateReqdto saveReqdto = SaveOrUpdateReqdto(title, content);
    Response response = await _postProvider.save(saveReqdto.toJson());
    dynamic body = response.body;
    CMRespDto cmRespDto = CMRespDto.fromJson(body);

    if (cmRespDto.code == 1) {
      print('글쓰기 성공');
      Post post = Post.fromJson(cmRespDto.data);
      return post;
    } else {
      print('글쓰기 실패');
      return Post(); // 빈 포스트
    }
  }

  Future<Post> updateById(int id, String title, String content) async {
    SaveOrUpdateReqdto updateReqdto = SaveOrUpdateReqdto(title, content);
    Response response =
        await _postProvider.updateById(id, updateReqdto.toJson());
    dynamic body = response.body;
    CMRespDto cmRespDto = CMRespDto.fromJson(body);

    if (cmRespDto.code == 1) {
      print('수정 성공');
      Post post = Post.fromJson(cmRespDto.data);
      return post;
    } else {
      print('수정 실패');
      return Post(); // 빈 포스트
    }
  }

  Future<int> deleteById(int id) async {
    Response response = await _postProvider.deleteById(id);
    dynamic body = response.body;
    CMRespDto cmRespDto = CMRespDto.fromJson(body);

    return cmRespDto.code ?? -1;
  }

  Future<Post> findById(int id) async {
    Response response = await _postProvider.findById(id);
    dynamic body = response.body;
    //dynamic convertBody = convertUtf8ToObject(body); // 나는 한글 안깨짐
    CMRespDto cmRespDto = CMRespDto.fromJson(body);

    if (cmRespDto.code == 1) {
      Post post = Post.fromJson(cmRespDto.data);
      return post;
    } else {
      return Post();
    }
  }

  Future<List<Post>> findAll() async {
    // await 쓸거면 async 필수 // login -> loginreqdto -> await -> response
    Response response = await _postProvider.findAll();
    dynamic body = response.body;
    // dynamic convertBody = convertUtf8ToObject(body); // UTF-8 한글 깨짐 해결 => 나는 안깨져서 사용할 필요가 없음
    CMRespDto cmRespDto = CMRespDto.fromJson(body);
    // print(cmRespDto.code);
    // print(cmRespDto.msg);
    // print(cmRespDto.data.runtimeType);

    if (cmRespDto.code == 1) {
      List<dynamic> temp = cmRespDto.data;
      List<Post> posts = temp.map((post) => Post.fromJson(post)).toList();
      return posts;
    } else {
      return <Post>[];
    }
  }
}
