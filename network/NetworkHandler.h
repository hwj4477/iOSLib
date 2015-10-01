//
//  NetworkHandler.h
//
//  referenced
//      - AFNetworking  : https://github.com/AFNetworking/AFNetworking
//      - SSZipArchive  : https://github.com/soffes/ssziparchive
//      - MBProgressHUD : https://github.com/jdg/MBProgressHUD
//
//  usage (cocoapods)
//      pod "AFNetworking", "~> 2.0"
//      pod 'AFDownloadRequestOperation', '~> 2.0.1'
//      pod 'SSZipArchive', '~> 0.3.2'
//      pod 'MBProgressHUD', '~> 0.9.1'
//
//  Created by hwj4477 on 2015. 4. 28..
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"
#import "AFDownloadRequestOperation.h"
#import "MBProgressHUD.h"
#import "SSZipArchive.h"

// Unzip Block
typedef void (^unzipProgressBlock)(float current, float total);
typedef void (^unzipCompleteBlock)(BOOL complete);

@interface NetworkHandler : NSObject <SSZipArchiveDelegate>

// Request
- (void)requestPostURL:(NSString*)url
            parameters:(NSDictionary*)param
               success:(void (^)(NSDictionary *jsonResult))success
               failure:(void (^)(NSString *strError))failure;

- (void)requestPostURL:(NSString *)url
                   raw:(NSDictionary *)raw  // raw body
               success:(void (^)(NSDictionary *))success
               failure:(void (^)(NSString *))failure;

- (void)requestGetURL:(NSString*)url
           parameters:(NSDictionary*)param
              success:(void (^)(NSDictionary *jsonResult))success
              failure:(void (^)(NSString *strError))failure;

- (void)setHeaderValue:(NSString*)value Filed:(NSString*)filed;

// Download
- (void)downloadFile:(NSString*)url
              toPath:(NSString*)path
                name:(NSString*)name
            progress:(void (^)(float current, float total))progress
            complete:(void (^)(BOOL success))complete;

- (void)pauseDownload;
- (void)resumeDownload;

// Unzip
- (void)unZipFilePath:(NSString*)filePath
               toPath:(NSString*)toPath
        unzipProgress:(unzipProgressBlock)progress
        unzipComplete:(unzipCompleteBlock)complete;

// Loading
- (void)showLoadingTo:(UIView*)view;
- (void)hideLoadingFor:(UIView*)view;

// Reachability
- (BOOL)reachable;

@end
