//
//  NetManager.m
//  AFNetWorkingDemo
//
//  Created by CaoMeng on 16/8/19.
//  Copyright © 2016年 CM. All rights reserved.
//

#import "NetManager.h"

@interface NetManager ()

// 服务器IP
@property(nonatomic,strong) NSString        *httpIP;

@end

@implementation NetManager

#pragma mark - 获取单例
+ (instancetype)sharedManager{
    static dispatch_once_t once;
    static id sharedManager;
    dispatch_once(&once,^{
        sharedManager = [[self alloc]init];
    });
    
    return sharedManager;
}

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        
    }
    
    return self;
}

// get
- (NSString *)httpIP
{
    // 服务器IP
    return BFServerURL;
}

#pragma mark - 网络请求封装

// 通过对象请求服务Get
- (void)GETRequestWebWithURL:(NSString *)url
                   paramters:(NSDictionary *)paraDic
                  hudString : (NSDictionary*) hudDic
                    success : (void (^)(id responseDic)) success
                    failure : (void(^)(id errorString)) failure
{
    NSMutableString *URLString = [NSMutableString string];
    
    // URL 拼接HTTPID
    [URLString appendString:self.httpIP];
    
    // URL 请求路径 login
    [URLString appendString:url];
    
    // URL拼接参数
    NSArray *keyArray = [paraDic allKeys];
    
    for (NSString *eachKey in keyArray) {
        // 拼接参数的格式：&username=%@
        // 例如：&username=clarence.cao
        NSString *value = paraDic[eachKey];
        [URLString appendFormat:@"&%@=%@",eachKey,[NSString removeNull:value]];
    }
    
    [self sendAFRequestWithUrlString:URLString hudString:hudDic success:success failure:failure];
}


// 通过对象请求服务Post
- (void)POSTRequestWebWithURL:(NSString *)url
                    paramters:(NSDictionary *)paraDic
                   hudString : (NSDictionary*) hudDic
                     success : (void (^)(id responseDic)) success
                     failure : (void(^)(id errorString)) failure
{
    // 根据网络状态以及用户之前的提示当前网络环境
    AFNetworkReachabilityStatus status = [[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus];
    
    // 如果网络异常
    if (status == AFNetworkReachabilityStatusNotReachable) {
        //#warning Tips
        // 提示网络异常
        [BFShowBox showMessage:@"网络不可用,请检查一下网络!"];
        return;
    }
    
    // 拼接请求地址 (也可以拼接root)
    NSString *urlString = [NSString stringWithFormat:@"%@%@",self.httpIP,url];
    BFLog(@"请求地址为 : %@",urlString);
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_9_0
    urlString = [urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
#else
    urlString = urlString.stringByRemovingPercentEncoding;
#endif
    
    
    [self formAFRequestWithUrlString:urlString postParamDic:paraDic hudString:hudDic success:success failure:failure];
}

#pragma mark - AFNetwork网络请求入口

// Get
- (void) sendAFRequestWithUrlString : (NSString*) _urlString
                          hudString : (NSDictionary*) hudDic
                             success:(void (^)(id responseDic)) _success
                             failure:(void(^)(id errorString)) _failure
{
    // 判断是否请求图片
    BOOL  requestPic = [[hudDic valueForKey:kRequestPic] boolValue];
    
    // Get请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:_urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        // 这里可以获取到目前的数据请求的进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 请求成功，解析数据
        [self handleWithCompleteData:responseObject requestPic:requestPic success:^(id responseDic) {
            _success(responseDic);
        } failure:^(id errorString) {
            _failure(errorString);
        }];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        _failure([error localizedDescription]);
        
    }];
}

#pragma mark - form请求入口 

//POST
- (void) formAFRequestWithUrlString : (NSString*) paraURL
                       postParamDic : (NSDictionary*) _postParamDic
                          hudString : (NSDictionary*) hudDic
                             success:(void (^)(id responseDic)) _success
                             failure:(void(^)(id errorString)) _failure
{
    
    // 初始化Manager
    
    // text/html 格式
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // application/json 格式
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:BFResponseContentType];
    
    
    [manager POST:paraURL parameters:_postParamDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self handleWithCompleteData:responseObject requestPic:NO success:^(id responseDic) {
            _success(responseDic);
        } failure:^(id errorString) {
            _failure(errorString);
        }];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        _failure(error.userInfo);
        
    }];
}

// post和get方法共同处理返回值的方法
- (void)handleWithCompleteData:(id)responseObject
                    requestPic:(BOOL)requestPic
                       success:(void (^)(id responseDic)) _success
                       failure:(void(^)(id errorString)) _failure
{
    // 正常情况下返回json格式的Dict
    if ([responseObject isKindOfClass:[NSString class]]) {
        // notFound
        _failure(@"返回格式不对!");
        return;
    }
    
    // 请求图片部分
    NSData *data = responseObject;
    if (requestPic) {
        _success(data);
        return;
    }
    
    NSDictionary *responseDic;
    // 请求成功，解析数据
    
    // 如是是Dict格式则不用再转成Dict. 如果是非Dict格式需要进行转换成Dict.
    if (![responseObject isKindOfClass:[NSDictionary class]]) {
        responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        _success(responseDic);
        
    }else{
        
        responseDic = responseObject;
        _success(responseObject);
    }
    
    
#warning code
    // 根据responseDic返回的字典值中 取出对应的字段 根据对呀的code进行UI交互
    // eg..
    /*
     // 状态Code
     NSString *statusCode = [[responseDic objectForKey:@"statusCode"] description];
     NSInteger code = statusCode.integerValue;
     // 成功
     if ((code & kStatusCode_Succeed) == kStatusCode_Succeed) {
     NSString *key = [NSString stringWithFormat:@"%d",kStatusCode_Succeed];
     [BFHUD hideHUDWithStatus:BFHUDStatusSucceed message:messageList[key] title:nil];
     _success(responseDic);
     }
     
     // 失败
     if ((code & kStatusCode_Failed) == kStatusCode_Failed) {
     NSString *key = [NSString stringWithFormat:@"%d",kStatusCode_Failed];
     [BFHUD hideHUDWithStatus:BFHUDStatusFailed message:messageList[key] title:nil];
     _failure(messageList[key]);
     }
     */
    
}

// sessionTimeOut
-(void)dealWithSessionOut:(NSString*)msg
{
    
}

@end
