//
//  FileUtil.m
//
//  Created by wjhong on 2014. 1. 7..
//

#import "FileUtil.h"

@implementation FileUtil

+ (NSString*)getFilePathWithName:(NSString*)filename WithPathType:(PathType)type
{
    NSSearchPathDirectory directory;
	switch(type)
	{
		case PathTypeDocument:
			directory = NSDocumentDirectory;
			break;
		case PathTypeLibrary:
			directory = NSLibraryDirectory;
			break;
		case PathTypeBundle:
			return [[[NSBundle mainBundle] bundlePath] stringByAppendingString:[NSString stringWithFormat:@"/%@", filename]];
			break;
		case PathTypeResource:
			return [[[NSBundle mainBundle] resourcePath] stringByAppendingString:[NSString stringWithFormat:@"/%@", filename]];
			break;
		case PathTypeTemp:
			return NSTemporaryDirectory();
			break;
		case PathTypeCache:
			directory = NSCachesDirectory;
			break;
		default:
			return nil;
	}
	NSArray* directories = NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES);
	if(directories != nil && [directories count] > 0)
    {
        NSString* typePath =[directories objectAtIndex:0];
        
        return [typePath stringByAppendingString:[NSString stringWithFormat:@"/%@", filename]];
    }
    
	return nil;
}

@end
