import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../../entity/entity.dart';
import '../../../util/util.dart';
import '../../../container.dart';
import '../../ui.dart';

class PostTile extends StatefulWidget {
  final PostEntity post;
  final void Function() onLike;
  final void Function() onUnlike;
  final void Function() onDelete;

  PostTile({
    Key key,
    @required this.post,
    this.onLike,
    this.onUnlike,
    this.onDelete,
  }) : super(key: key);

  @override
  _PostTileState createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  void _likePost() async {
    WgContainer().basePresenter.doWithLoading(() async {
      await WgContainer().postPresenter.like(widget.post.id);

      if (widget.onLike != null) widget.onLike();
    });
  }

  void _unlikePost() async {
    WgContainer().basePresenter.doWithLoading(() async {
      await WgContainer().postPresenter.unlike(widget.post.id);

      if (widget.onUnlike != null) widget.onUnlike();
    });
  }

  void _deletePost() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (c) => AlertDialog(
        title: Text('确认删除'),
        content: Text('是否确认删除动态？'),
        actions: [
          FlatButton(
            onPressed: () => WgContainer().basePresenter.navigator().pop(),
            child: Text('取消'),
          ),
          FlatButton(
            onPressed: () async {
              WgContainer().basePresenter.navigator().pop();

              WgContainer().basePresenter.doWithLoading(() async {
                await WgContainer().postPresenter.delete(widget.post.id);

                if (widget.onDelete != null) widget.onDelete();
              });
            },
            child: Text('确认'),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: Feedback.wrapForTap(
              () => WgContainer().basePresenter.navigator().push(
                    MaterialPageRoute(
                      builder: (context) =>
                          UserDetailPage(userId: widget.post.userId),
                    ),
                  ),
              context,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundImage: widget.post.user.avatar == null
                      ? null
                      : CachedNetworkImageProvider(
                          widget.post.user.avatar.thumbs[FileThumbType.SMALL]),
                  child: widget.post.user.avatar == null
                      ? Icon(Icons.person)
                      : null,
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    widget.post.user.username,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.body2,
                  ),
                ),
              ],
            ),
          ),
          Text(
            widget.post.createdAt.toString().substring(0, 16),
            style: Theme.of(context)
                .textTheme
                .body1
                .copyWith(color: Theme.of(context).hintColor),
          ),
        ],
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(vertical: WgContainer().theme.paddingSizeLarge),
      child: Text(widget.post.text),
    );
  }

  Widget _buildImages(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final margin = 5.0;
        final columns =
            widget.post.images.length >= 3 ? 3 : widget.post.images.length;
        final width = (constraints.maxWidth - (columns - 1) * margin) / columns;
        final height = width;
        var thumbType = FileThumbType.SMALL;
        if (widget.post.images.length == 2) {
          thumbType = FileThumbType.MIDDLE;
        } else if (widget.post.images.length == 1) {
          thumbType = FileThumbType.LARGE;
        }

        return Wrap(
          spacing: margin,
          runSpacing: margin,
          children: widget.post.images
              .asMap()
              .entries
              .map((entry) => GestureDetector(
                  onTap: Feedback.wrapForTap(
                    () => WgContainer()
                        .basePresenter
                        .navigator()
                        .push(MaterialPageRoute(
                          builder: (context) => ImagePlayerPage(
                            images: widget.post.images,
                            initialIndex: entry.key,
                          ),
                        )),
                    context,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: entry.value.thumbs[thumbType],
                    fit: BoxFit.cover,
                    width: width,
                    height: height,
                  )))
              .toList(),
        );
      },
    );
  }

  Widget _buildVideo(BuildContext context) {
    return VideoPlayerWithCover(video: widget.post.video);
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.whatshot,
                color: Theme.of(context).hintColor,
                size: 20,
              ),
              Text(
                '${formatNumber(widget.post.stat?.likeCount ?? 0)}',
                style: Theme.of(context)
                    .textTheme
                    .body1
                    .copyWith(color: Theme.of(context).hintColor),
              ),
            ],
          ),
          Row(
            children: [
              widget.post.liked
                  ? GestureDetector(
                      onTap: Feedback.wrapForTap(_unlikePost, context),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Icon(
                          Icons.favorite,
                          size: 20,
                          color: Colors.red[300],
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: Feedback.wrapForTap(_likePost, context),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Icon(
                          Icons.favorite_border,
                          size: 20,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                    ),
              if (widget.post.userId ==
                  StoreProvider.of<AppState>(context).state.user.logged.id)
                GestureDetector(
                  onTap: Feedback.wrapForTap(_deletePost, context),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Icon(
                      Icons.delete_outline,
                      size: 20,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          _buildHeader(context),
          Divider(height: 1),
          if (widget.post.text != '') _buildText(context),
          if (widget.post.images.isNotEmpty) _buildImages(context),
          if (widget.post.video != null) _buildVideo(context),
          Divider(height: 1),
          _buildFooter(context),
        ],
      ),
    );
  }
}
