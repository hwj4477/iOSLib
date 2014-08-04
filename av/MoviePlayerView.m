//
//  MoviePlayerView.m
//
//  Created by hwj4477 on 2014. 1. 17..
//

#import "MoviePlayerView.h"

@implementation MoviePlayerView
@synthesize movieURL;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        isPlaying = NO;
        [self setBackgroundColor:[UIColor clearColor]];
        
        
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        isPlaying = NO;
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (BOOL)isPlaying
{
    return isPlaying;
}

- (void)playMovie
{
    if(movieURL && !isPlaying)
    {
        isPlaying = YES;
    
        moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:self.movieURL];
        moviePlayer.view.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        moviePlayer.controlStyle = MPMovieControlStyleNone;
        moviePlayer.scalingMode = MPMovieControlStyleDefault;
        
        [self addSubview:moviePlayer.view];
        [self bringSubviewToFront:moviePlayer.view];
        [moviePlayer prepareToPlay];
        [moviePlayer play];

        moviePlayer.view.backgroundColor = [UIColor clearColor];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(playbackDidFinish:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:moviePlayer];
    }
}

- (void)stopMovie
{
    if(isPlaying)
    {
        DebugLog(@"stop");
        
        [moviePlayer stop];
        
        isPlaying = NO;
    }
}

- (void)playbackDidFinish:(NSNotification *)noti
{
    MPMoviePlayerController *player = [noti object];
	
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:player];
    [player stop];
    [player.view removeFromSuperview];
    [player release];
    player = nil;
    
    isPlaying = NO;
}

@end
