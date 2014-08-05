//
//  SqliteWrapper.h
//
//  Created by hwj4477 on 2014. 1. 3..
//

#import <Foundation/Foundation.h>

//needs: libsqlite3.dylib
#import <sqlite3.h>

@interface SqliteWrapper : NSObject{
    sqlite3* database;
}


- (id)initWithFilepath:(NSString*)filePath;

- (bool)executeQueryString:(NSString*)query;

- (NSArray*)selectQueryString:(NSString*)query WithParameters:(NSArray*)parameters;

@end
