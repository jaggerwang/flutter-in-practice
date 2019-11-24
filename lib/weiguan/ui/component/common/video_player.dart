import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../entity/entity.dart';
import '../../../container.dart';
import '../../ui.dart';

class VideoPlayerWithControlBar extends StatefulWidget {
  final FileEntity video;
  final File file;
  final bool isAutoPlay;
  final bool isFull;
  final VideoPlayerController controller;

  VideoPlayerWithControlBar({
    Key key,
    this.video,
    this.file,
    this.isAutoPlay = false,
    this.isFull = false,
    this.controller,
  })  : assert(video != null || file != null),
        super(key: key);

  @override
  _VideoPlayerWithControlBarState createState() =>
      _VideoPlayerWithControlBarState();
}

class _VideoPlayerWithControlBarState extends State<VideoPlayerWithControlBar> {
  static VideoPlayerController _activeController;

  VideoPlayerController _controller;
  var _isInitialized = false;
  var _isPlaying = false;
  var _isEnded = false;
  var _isControlBarVisible = true;
  Timer _controlBarInvisibleTimer;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      if (widget.video != null) {
        _controller = VideoPlayerController.network(widget.video.url);
      } else if (widget.file != null) {
        _controller = VideoPlayerController.file(widget.file);
      }
      _controller
        ..addListener(_controllerListener)
        ..initialize();
    } else {
      _controller = widget.controller;
      _controller.addListener(_controllerListener);
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller
        ..removeListener(_controllerListener)
        ..dispose();
    } else {
      _controller.removeListener(_controllerListener);
    }

    if (_activeController == _controller) {
      _activeController = null;
    }

    if (_controlBarInvisibleTimer?.isActive == true) {
      _controlBarInvisibleTimer.cancel();
    }

    super.dispose();
  }

  void _controllerListener() {
    if (!_controller.value.initialized) {
      return;
    }

    if (!_isInitialized) {
      _isInitialized = true;

      if (widget.isAutoPlay && !_isPlaying) {
        _play();
      }
    }

    if (!_isEnded && _controller.value.position >= _controller.value.duration) {
      _isEnded = true;
      _isControlBarVisible = true;
    } else if (_isEnded &&
        _controller.value.position < _controller.value.duration) {
      _isEnded = false;
      _isControlBarVisible = false;
    }

    if (_controller.value.isPlaying && !_isEnded) {
      _isPlaying = true;
    } else {
      _isPlaying = false;
    }

    setState(() {});
  }

  void _play() {
    if (_activeController != _controller) {
      if (_activeController != null && _activeController.value.isPlaying) {
        _activeController.pause();
      }
      _activeController = _controller;
    }

    if (_isEnded) {
      _controller.seekTo(Duration(seconds: 0));
    } else {
      _controller.play();
    }

    if (_isControlBarVisible) {
      if (_controlBarInvisibleTimer?.isActive == true) {
        _controlBarInvisibleTimer.cancel();
      }
      _controlBarInvisibleTimer = Timer(Duration(seconds: 4), () {
        if (_isPlaying) {
          setState(() {
            _isControlBarVisible = false;
          });
        }
      });
    }
  }

  void _togglePlaying() {
    if (_isPlaying) {
      _controller.pause();
    } else {
      _play();
    }
  }

  void _toggleControlling() {
    setState(() {
      _isControlBarVisible = !_isControlBarVisible;
    });
  }

  void _toggleFull() {
    if (widget.isFull) {
      WgContainer().basePresenter.navigator().pop();
    } else {
      WgContainer().basePresenter.navigator().push(MaterialPageRoute(
            builder: (context) => VideoPlayerPage(
              video: widget.video,
              file: widget.file,
              controller: _controller,
            ),
          ));
    }
  }

  Widget _buildControlBar(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: Feedback.wrapForTap(_togglePlaying, context),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.black26,
              child: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
                size: 45,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: DefaultTextStyle(
            style: TextStyle(color: Colors.white),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                      '${(_controller.value.position.inSeconds / 60).floor().toString().padLeft(2, '0')}:${(_controller.value.position.inSeconds % 60).toString().padLeft(2, '0')}'),
                ),
                Expanded(
                  child: VideoProgressIndicator(
                    _controller,
                    allowScrubbing: true,
                    padding: EdgeInsets.symmetric(vertical: 5),
                    colors: VideoProgressColors(
                      backgroundColor: Colors.grey[500],
                      bufferedColor: Colors.white70,
                      playedColor: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                      '${((_controller.value.duration?.inSeconds ?? 0) / 60).floor().toString().padLeft(2, '0')}:${((_controller.value.duration?.inSeconds ?? 0) % 60).toString().padLeft(2, '0')}'),
                ),
                GestureDetector(
                  onTap: Feedback.wrapForTap(_toggleFull, context),
                  child: Icon(
                    widget.isFull ? Icons.fullscreen_exit : Icons.fullscreen,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Feedback.wrapForTap(_toggleControlling, context),
      child: AspectRatio(
        aspectRatio: _isInitialized ? _controller.value.aspectRatio : 16 / 9,
        child: Stack(
          children: [
            if (_isInitialized) VideoPlayer(_controller),
            if (_isInitialized && _isControlBarVisible)
              _buildControlBar(context),
            if (!_isInitialized)
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}

class VideoPlayerWithCover extends StatefulWidget {
  final FileEntity video;

  VideoPlayerWithCover({
    Key key,
    @required this.video,
  }) : super(key: key);

  @override
  _VideoPlayerWithCoverState createState() => _VideoPlayerWithCoverState();
}

class _VideoPlayerWithCoverState extends State<VideoPlayerWithCover> {
  var _isPlayMode = false;

  void _switchToPlayMode() {
    setState(() {
      _isPlayMode = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isPlayMode
        ? VideoPlayerWithControlBar(
            video: widget.video,
            isAutoPlay: true,
          )
        : GestureDetector(
            onTap: Feedback.wrapForTap(_switchToPlayMode, context),
            child: AspectRatio(
              aspectRatio: widget.video.ratio,
              child: Stack(
                children: [
                  CachedNetworkImage(
                      imageUrl: widget.video.thumbs[FileThumbType.LARGE]),
                  Container(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.black26,
                      child: Icon(
                        Icons.play_arrow,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
