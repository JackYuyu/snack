

//
//  NetHttpTool.m
//  CiQi
//
//  Created by qq on 2019/6/14.
//  Copyright © 2019 qi. All rights reserved.
//

#import "NetHttpTool.h"
#import <AFNetworking/AFNetworking.h>
@implementation NetHttpTool
+ (AFHTTPSessionManager *)shareInstance{
    static dispatch_once_t onceToken;
    static AFHTTPSessionManager *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg",
                                                             @"image/png", @"application/octet-stream", @"text/json", nil];
//        [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json",@"text/html",nil]];
        [manager.requestSerializer setValue:ShopKey forHTTPHeaderField:@"shopkey"];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    });
    return manager;
}

+ (AFHTTPSessionManager *)Manager{
    static dispatch_once_t onceToken;
    static AFHTTPSessionManager *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg",
                                                             @"image/png", @"application/octet-stream", @"text/json", nil];
       
//        [manager.requestSerializer setValue:ShopKey forHTTPHeaderField:@"shopkey"];
//        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    });
    return manager;
}

+ (void)GET:(NSString *)url paramets:(NSDictionary *)paramets Succeed:(Succeed)succeed Failure:(Failure)failure{
    
    NSString *urls = [NSString stringWithFormat:@"%@%@?shopkey=%@",BaseURL,url,ShopKey];
    NSLog(@"---\n url == %@\nparam = %@\n\n",url, paramets);
    [[NetHttpTool shareInstance]GET:urls parameters:paramets progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;
//        NSDictionary *dic=  [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        succeed(responseObject);
        NSLog(@"success%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *  error) {
        failure(error);
        NSLog(@"error%@",error);
    }];

}


+ (void)GET:(NSString *)url parametsBody:(NSDictionary *)paramets Succeed:(Succeed)succeed Failure:(Failure)failure{
    
    NSString *urls = [NSString stringWithFormat:@"%@%@?shopkey=%@",BaseURL,url,ShopKey];
    NSLog(@"---\n url == %@\nparam = %@\n\n",url, paramets);
    [[NetHttpTool Manager]GET:urls parameters:paramets progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;
       
        succeed(responseObject);
        NSLog(@"success%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *  error) {
        failure(error);
        NSLog(@"error%@",error);
    }];
    
}

+ (void)Post:(NSString *)url paramets:(NSDictionary *)paramts Succeed:(Succeed )succeed Failure:(Failure)failure {
    NSString *urls = [NSString stringWithFormat:@"%@%@?shopkey=%@",BaseURL,url,ShopKey];

    NSLog(@"---\n url == %@\nparam = %@\n\n",urls, paramts);

  [[NetHttpTool shareInstance] POST:urls parameters:paramts progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSError *error = nil;
        succeed(responseObject);
        NSLog(@"success%@",responseObject);
    
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      
      
      NSLog(@"error=%@",error);
      failure(error);
      NSDictionary *userfo = error.userInfo;
      
      if (userfo[@"com.alamofire.serialization.response.error.data"]) {
          NSData *errorData = userfo[@"com.alamofire.serialization.response.error.data"];
          NSLog(@"%@",[[NSString alloc]initWithData:errorData encoding:NSUTF8StringEncoding]);
          
      }else{
          
          NSError *userErr = userfo[@"NSUnderlyingError"];
          NSDictionary *userinfoDic = userErr.userInfo;
          NSData *errorData = userinfoDic[@"com.alamofire.serialization.response.error.data"];
          NSLog(@"%@",[[NSString alloc]initWithData:errorData encoding:NSUTF8StringEncoding]);
      }
      
  }];
    
}

+ (void)Post:(NSString *)url bodyParamets:(NSDictionary *)paramts Succeed:(Succeed )succeed Failure:(Failure)failure {






    NSString *urls = [NSString stringWithFormat:@"%@%@",BaseURL,url];

    NSLog(@"---\n url == %@\nparam = %@\n\n",urls, paramts);

    [[NetHttpTool Manager] POST:urls parameters:paramts progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *error = nil;
        succeed(responseObject);
        
        NSLog(@"success%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error=%@",error);
        failure(error);
        NSDictionary *userfo = error.userInfo;
        NSData *errorData = userfo[@"com.alamofire.serialization.response.error.data"];
        if (errorData) {
            NSError *er = nil;
            id errors = [NSJSONSerialization JSONObjectWithData:errorData options:0 error:&er];
            if (er) {
                NSLog(@"%@",[[NSString alloc]initWithData:errorData encoding:NSUTF8StringEncoding]);
            }
            NSLog(@"%@",errors);
        }
    }];

}
@end
