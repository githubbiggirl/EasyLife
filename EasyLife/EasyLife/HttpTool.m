//
//  HttpTool.m
//  EasyLife
//
//  Created by qingyun on 16/1/8.
//  Copyright © 2016年 lily. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"

@implementation HttpTool

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    //创建管理对象
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //发出请求
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postXmlWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    //创建管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //NSDictionary *params = @{@"format": @"xml"};
    // 发生请求
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // AFNetWorking
    // 创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 发送请求
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> allFormData) {
        for (WBFormData *formData in formDataArray) {
            [allFormData appendPartWithFileData:formData.data name:formData.name fileName:formData.filename mimeType:formData.myType];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // AFNetWorking
    // 创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 发生请求
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}
@end

/**
 *  用来封装文件数据的模型
 */
@implementation WBFormData

@end
