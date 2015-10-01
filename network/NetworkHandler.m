//
//  NetworkHandler.m
//
//  Created by wjhong on 2015. 4. 28..
//

#import "NetworkHandler.h"
#import "CommonDefine.h"

@interface NetworkHandler(){
    
    // request
    AFHTTPRequestOperationManager *manager;
    
    // download
    AFDownloadRequestOperation *downloadOperation;
        
    // unzip block
    unzipProgressBlock unzipProgress;
    unzipCompleteBlock unzipComplete;
}

@end

@implementation NetworkHandler

static BOOL isLoading = NO;

- (id)init
{
    if((self = [super init]))
    {
        manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
        
        downloadOperation = nil;
        
        isLoading = NO;
    }
     
    return self;
}

#pragma mark - Request.
- (void)requestPostURL:(NSString*)url
            parameters:(NSDictionary*)param
               success:(void (^)(NSDictionary *jsonResult))success
               failure:(void (^)(NSString *strError))failure
{
    [manager POST:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:(NSData*)responseObject options:NSJSONReadingMutableContainers error:nil];
        
        success((NSDictionary*)response);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failure([error localizedDescription]);
        
    }];
}

- (void)requestPostURL:(NSString *)url
                   raw:(NSDictionary *)raw
               success:(void (^)(NSDictionary *))success
               failure:(void (^)(NSString *))failure
{
    AFHTTPRequestOperationManager *requestManager = [AFHTTPRequestOperationManager manager];
    
    requestManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    requestManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    
    requestManager.requestSerializer = [AFJSONRequestSerializer serializer];
    [requestManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [requestManager POST:url parameters:raw success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:(NSData*)responseObject options:NSJSONReadingMutableContainers error:nil];
        
        success((NSDictionary*)response);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
               
        failure([error localizedDescription]);
    }];
}

- (void)requestGetURL:(NSString*)url
           parameters:(NSDictionary*)param
              success:(void (^)(NSDictionary *jsonResult))success
              failure:(void (^)(NSString *strError))failure
{
    [manager GET:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:(NSData*)responseObject options:NSJSONReadingMutableContainers error:nil];
        
        success((NSDictionary*)response);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failure([error localizedDescription]);
        
    }];
}

- (void)setHeaderValue:(NSString*)value Filed:(NSString*)filed
{
    [manager.requestSerializer setValue:value forHTTPHeaderField:filed];
}

#pragma mark - Download.
- (void)downloadFile:(NSString*)url toPath:(NSString*)path name:(NSString*)name progress:(void (^)(float current, float total))progress complete:(void (^)(BOOL success))complete
{
    // make directory
    if (![[NSFileManager defaultManager] fileExistsAtPath:path])
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:nil];

    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    downloadOperation = [[AFDownloadRequestOperation alloc] initWithRequest:request targetPath:[NSString stringWithFormat:@"%@/%@", path, name] shouldResume:YES];
    
    [downloadOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if(complete)
        {
            if([operation.response expectedContentLength] > 0)
                complete(YES);
            else
                complete(NO);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        DebugLog(@"Error: %@", error);
        
        if(complete)
            complete(NO);
    }];
    
    [downloadOperation setProgressiveDownloadProgressBlock:^(AFDownloadRequestOperation *operation, NSInteger bytesRead, long long totalBytesRead, long long totalBytesExpected, long long totalBytesReadForFile, long long totalBytesExpectedToReadForFile) {
    
        if(totalBytesRead > totalBytesExpectedToReadForFile)
            totalBytesRead = totalBytesExpectedToReadForFile;
        
        if(progress)
            progress(totalBytesRead, totalBytesExpected);
        
    }];
    
    [downloadOperation start];
}

- (void)pauseDownload
{
    if(downloadOperation)
        [downloadOperation pause];
}

- (void)resumeDownload
{
    if(downloadOperation)
        [downloadOperation resume];
}

#pragma mark - Unzip.
- (void)unZipFilePath:(NSString*)filePath
               toPath:(NSString*)toPath
        unzipProgress:(unzipProgressBlock)progress
        unzipComplete:(unzipCompleteBlock)complete;
{
    unzipProgress = progress;
    unzipComplete = complete;
    
    if([SSZipArchive unzipFileAtPath:filePath toDestination:toPath delegate:self])
    {
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }
}

// SSZipArchive Delegate Functions.
- (void)zipArchiveDidUnzipArchiveAtPath:(NSString *)path zipInfo:(unz_global_info)zipInfo unzippedPath:(NSString *)unzippedPath
{
    if(unzipComplete)
    {
        unzipComplete(YES);
    }
}

- (void)zipArchiveProgressEvent:(NSInteger)loaded total:(NSInteger)total
{
    if(unzipProgress)
    {
        if(loaded >= total)
        {
            unzipProgress((float)loaded, (float)total);
        }
        else
        {
            unzipProgress((float)loaded, (float)total);
        }
    }
}

#pragma mark - Loading Helper.
- (void)showLoadingTo:(UIView*)view
{
    if(!isLoading)
    {
        isLoading = YES;
        
        [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
}

- (void)hideLoadingFor:(UIView*)view
{
    if(isLoading)
    {
        isLoading = NO;
        
        [MBProgressHUD hideHUDForView:view animated:YES];
    }
}

#pragma mark - Reachbility
- (BOOL)reachable
{
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

@end
