//
//  AVAudioHelper.h
//
//  Created by hwj4477 on 2014. 1. 7..
//

#import <Foundation/Foundation.h>

#import <AVFoundation/AVFoundation.h>

@interface AVAudioHelper : NSObject <AVAudioPlayerDelegate>{
    AVAudioPlayer* audioPlayer;
}

+ (AVAudioHelper*)sharedInstance;

- (void)playSimpleSoundWithFilePath:(NSString*)path;

- (void)playSoundWithFilePath:(NSString*)path;
- (void)stopSound;

@end
