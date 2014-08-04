//
//  SqliteWrapper.m
//
//  Created by hwj4477 on 2014. 1. 3..
//

#import "SqliteWrapper.h"

@implementation SqliteWrapper

#pragma mark -
#pragma mark init.

- (id)initWithFilepath:(NSString*)filePath
{
	sqlite3* db;
	int error;
	if((error = sqlite3_open([filePath UTF8String], &db)) != SQLITE_OK)
	{
		DebugLog(@"sqlite3_open failed(%d) with %s", error, [filePath UTF8String]);
        
		sqlite3_close(db);
		return nil;
	}
    
	if((self = [super init]))
	{
		database = db;
	}
	
	return self;
}

#pragma mark -
#pragma mark execute query

- (bool)executeQueryString:(NSString*)query
{
    char* error = NULL;
    if (sqlite3_exec(database, [query  UTF8String], NULL, NULL, &error) != SQLITE_OK)
	{
		DebugLog(@"error: %@", [NSString stringWithCString:error
                                                  encoding:NSUTF8StringEncoding]);
		
		sqlite3_free(error);
		return NO;
    }
    
	if(error)
		sqlite3_free(error);
  
	return YES;
}

#pragma mark -
#pragma mark select

- (NSArray*)executeQueryString:(NSString*)query WithParameters:(NSArray*)parameters
{
	NSMutableArray *resultArray = [NSMutableArray array];
	sqlite3_stmt *statement;
	
	if (sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK)
    {
		if (parameters != nil)
        {
			[self bindArguments: parameters toStatement: statement];
		}
		BOOL needsToFetchColumnTypesAndNames = YES;
		NSArray *columnTypes = nil;
		NSArray *columnNames = nil;
		while (sqlite3_step(statement)==SQLITE_ROW)
        {
			if (needsToFetchColumnTypesAndNames)
            {
				columnTypes = [self columnTypesForStatement: statement];
				columnNames = [self columnNamesForStatement: statement];
				needsToFetchColumnTypesAndNames = NO;
			}
            
            NSMutableDictionary *resultRow = [NSMutableDictionary dictionary];
			
			[self copyValuesFromStatement: statement toRow: resultRow columnTypes: columnTypes columnNames: columnNames];
			
            [resultArray addObject:resultRow];
		}
	}
	sqlite3_finalize(statement);
    
	return resultArray;
	
}

#pragma mark -
#pragma mark helper.

- (void)bindArguments: (NSArray *) arguments toStatement: (sqlite3_stmt *) statement
{
	int expectedArguments = sqlite3_bind_parameter_count(statement);
	int nArgumentsCnt = (int)[arguments count];
	for (int i = 1; (i <= expectedArguments) && (i <= nArgumentsCnt); i++)
    {
		id argument = [arguments objectAtIndex:i - 1];
		if([argument isKindOfClass:[NSString class]])
			sqlite3_bind_text(statement, i, [argument UTF8String], -1, SQLITE_TRANSIENT);
		else if([argument isKindOfClass:[NSData class]])
			sqlite3_bind_blob(statement, i, [argument bytes], (int)[argument length], SQLITE_TRANSIENT);
		else if([argument isKindOfClass:[NSNumber class]])
			sqlite3_bind_double(statement, i, [argument doubleValue]);
		else if([argument isKindOfClass:[NSNull class]])
			sqlite3_bind_null(statement, i);
		else
			sqlite3_finalize(statement);
		
	}
}

- (int)columnTypeToInt: (NSString *) columnType
{
	if ([columnType isEqualToString:@"INTEGER"])
    {
		return SQLITE_INTEGER;
	}
	else if ([columnType isEqualToString:@"REAL"])
    {
		return SQLITE_FLOAT;
	}
	else if ([columnType isEqualToString:@"TEXT"])
    {
		return SQLITE_TEXT;
	}
	else if ([columnType isEqualToString:@"BLOB"])
    {
		return SQLITE_BLOB;
	}
	else if ([columnType isEqualToString:@"NULL"])
    {
		return SQLITE_NULL;
	}
	
	return SQLITE_TEXT;
}

- (int)typeForStatement: (sqlite3_stmt *) statement column: (int) column
{
	const char * columnType = sqlite3_column_decltype(statement, column);
	
	if (columnType != NULL)
    {
		return [self columnTypeToInt: [[NSString stringWithUTF8String: columnType] uppercaseString]];
	}
	return sqlite3_column_type(statement, column);
}

- (NSArray *)columnTypesForStatement: (sqlite3_stmt *) statement
{
	int columnCount = sqlite3_column_count(statement);
	
	NSMutableArray *columnTypes = [NSMutableArray array];
	for(int idx = 0; idx < columnCount; idx++)
    {
		[columnTypes addObject:[NSNumber numberWithInt:[self typeForStatement:statement column:idx]]];
	}
	return columnTypes;
}

- (NSArray *)columnNamesForStatement: (sqlite3_stmt *) statement
{
	int columnCount = sqlite3_column_count(statement);
	
	NSMutableArray *columnNames = [NSMutableArray array];
	for (int idx = 0; idx < columnCount; idx++)
    {
		[columnNames addObject:[NSString stringWithUTF8String:sqlite3_column_name(statement, idx)]];
	}
    
	return columnNames;
}

- (void)copyValuesFromStatement: (sqlite3_stmt *) statement toRow: (id) row columnTypes: (NSArray *) columnTypes columnNames: (NSArray *) columnNames
{
	int columnCount = sqlite3_column_count(statement);
	
	for (int idx = 0; idx < columnCount; idx++)
    {
		id value = [self valueFromStatement:statement column:idx columnTypes: columnTypes];
		
        if(value != nil) {
			[row setValue: value forKey: [columnNames objectAtIndex:idx]];
        }
	}
}

- (id)valueFromStatement: (sqlite3_stmt *) statement column: (int) column columnTypes: (NSArray *) columnTypes
{
	int columnType = [[columnTypes objectAtIndex:column] intValue];
	
	if (columnType == SQLITE_INTEGER)
    {
		return [NSNumber numberWithInt:sqlite3_column_int(statement, column)];
	}
	else if (columnType == SQLITE_FLOAT)
    {
		return [NSNumber numberWithDouble: sqlite3_column_double(statement, column)];
	}
	else if (columnType == SQLITE_TEXT)
    {
		const char *text = (const char *) sqlite3_column_text(statement, column);
		if (text != nil)
        {
			return [NSString stringWithUTF8String: text];
		}
		else
        {
			return nil;
		}
	}
	else if (columnType == SQLITE_BLOB)
    {
		return [NSData dataWithBytes:sqlite3_column_blob(statement, column) length:sqlite3_column_bytes(statement, column)];
	}
	else if (columnType == SQLITE_NULL)
    {
		return nil;
	}
	return nil;
}

@end
