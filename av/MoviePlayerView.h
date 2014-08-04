//
//  MoviePlayerView.h
//
//  Created by hwj4477 on 2014. 1. 17..
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface MoviePlayerView : UIView{
    MPMoviePlayerController *moviePlayer;
    BOOL isPlaying;
}

@property (retain) NSURL* movieURL;

- (void)playMovie;
- (void)stopMovie;
- (BOOL)isPlaying;

@end
