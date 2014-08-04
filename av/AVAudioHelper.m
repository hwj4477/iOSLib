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
			[[self alloc]init];
        
		return _instnace;
	}
	return nil;
}

+ (id)alloc
{
	@synchronized([AVAudioHelper class])
	{
		_instnace = [super alloc];
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

+ (void)disposeSharedInstance
{
	@synchronized(self)
	{
        if(_instnace != nil)
        {
            [_instnace release];
            _instnace = nil;
        }
	}
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
        [audioPlayer release];
        audioPlayer = nil;
    }
}

#pragma mark - AVAudioPlayer Delegate functions
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if(flag && player)
    {
        [player stop];
        [player release];
        player = nil;
    }
    
}

@end
