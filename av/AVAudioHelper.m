//
//  AVAudioHelper.m
//
//  Created by hwj4477 on 2014. 1. 7..
//

#import "AVAudioHelper.h"

static AVAudioHelper *_instnace = nil;

@implementation AVAudioHelper

+ (AVAudioHelper*)sharedInstance
{
    @synchronized([AVAudioHelper class])
	{
		if( !_instnace )
			_instnace = [[AVAudioHelper alloc] init];
        
		return _instnace;
	}
	return nil;
}

- (id)init
{
	self = [super init];
	if( self != nil)
	{
        
	}
	return self;
}

#pragma mark - player control

- (void)playSimpleSoundWithFilePath:(NSString*)path
{
    AVAudioPlayer *simplePlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
    simplePlayer.delegate = self;
    [simplePlayer play];
}

- (void)playSoundWithFilePath:(NSString*)path
{
    [self stopSound];
    
    audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
    audioPlayer.delegate = self;
    [audioPlayer play];
    
}

- (void)stopSound
{
    if(audioPlayer)
    {
        [audioPlayer stop];
        audioPlayer = nil;
    }
}

#pragma mark - AVAudioPlayer Delegate functions
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if(flag && player)
    {
        [player stop];
        player = nil;
    }
    
}

@end
