//
//  FileUtil.h
//
//  Created by wjhong on 2014. 1. 7..
//

#import <Foundation/Foundation.h>

typedef enum _PathType {
	PathTypeLibrary,
	PathTypeDocument,
	PathTypeResource,
	PathTypeBundle,
	PathTypeTemp,
	PathTypeCache,
} PathType;

@interface FileUtil : NSObject

+ (NSString*)getFilePathWithName:(NSString*)filename WithPathType:(PathType)type;

@end
