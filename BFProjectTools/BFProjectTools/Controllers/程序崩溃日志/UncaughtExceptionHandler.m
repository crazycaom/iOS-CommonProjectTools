//
//  UncaughtExceptionHandler.m
//  UncaughtExceptions
//
//  Created by Matt Gallagher on 2010/05/25.
//  Copyright 2010 Matt Gallagher. All rights reserved.
//
//  Permission is given to use this source code file, free of charge, in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

#import "UncaughtExceptionHandler.h"
#include <libkern/OSAtomic.h>
#include <execinfo.h>
//#import "PadExceptionLogItemDto.h"
//#import "BFDataBase.h"

NSString * const UncaughtExceptionHandlerSignalExceptionName = @"UncaughtExceptionHandlerSignalExceptionName";
NSString * const UncaughtExceptionHandlerSignalKey = @"UncaughtExceptionHandlerSignalKey";
NSString * const UncaughtExceptionHandlerAddressesKey = @"UncaughtExceptionHandlerAddressesKey";

volatile int32_t UncaughtExceptionCount = 0;
const int32_t UncaughtExceptionMaximum = 10;

const NSInteger UncaughtExceptionHandlerSkipAddressCount = 4;
const NSInteger UncaughtExceptionHandlerReportAddressCount = 5;

@implementation UncaughtExceptionHandler
{
    //PadExceptionLogItemDto *_crashLog;
    NSArray *_stackArray;
}

+ (NSArray *)backtrace
{
	 void* callstack[128];
	 int frames = backtrace(callstack, 128);
	 char **strs = backtrace_symbols(callstack, frames);
	 
	 int i;
	 NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
	 for (
	 	i = UncaughtExceptionHandlerSkipAddressCount;
	 	i < UncaughtExceptionHandlerSkipAddressCount +
			UncaughtExceptionHandlerReportAddressCount;
		i++)
	 {
	 	[backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
	 }
	 free(strs);
	 
	 return backtrace;
}

#pragma mark - 点击取消按钮
- (void)alertView:(UIAlertView *)anAlertView clickedButtonAtIndex:(NSInteger)anIndex
{
	if (anIndex == 0)
	{
		//dismissed = YES;
	}
}

- (void)validateAndSaveCriticalApplicationData
{
	
}

- (void)handleException:(NSDictionary *)dict
{
	[self validateAndSaveCriticalApplicationData];
	
    NSException *exception = [dict objectForKey:@"exception"];
    
    NSLog(@"---name%@",[exception name]);
    NSLog(@"---reason%@",[exception reason]);
    NSLog(@"---userInfo%@",[exception userInfo]);
    NSArray *stackArray = [dict objectForKey:@"stackArray"];
    NSLog(@"--stackArray = %@",stackArray);
    
    // 采取相应的保留异常崩溃信息
    // 上传服务器
    // 保留本地数据库中
    // ...
    
//    BFCrashLogModel *crashLog = [[BFCrashLogModel alloc] init];
//    
//    // 设备ID
//    NSString *currentDeviceUUID = [[UIDevice currentDevice].identifierForVendor UUIDString];
//    crashLog.deviceUUID = currentDeviceUUID;
//    
//    // 设备当前系统的版本和名称
//    NSString *currentSysVerAndName = [NSString stringWithFormat:@"%@ - %@",[UIDevice currentDevice].systemVersion,[UIDevice currentDevice].systemName];
//    NSLog(@"当前系统的版本和名称%@",currentSysVerAndName);
//    crashLog.currentSystemVerAndName = currentSysVerAndName;
//    
//    // APP当前版本
//    NSString *currentAPPVer = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
//    NSLog(@"当前APP版本%@",currentAPPVer);
//    crashLog.currentAppVer = currentAPPVer;
//    
//    // 当前操作用户
//    BFUtils *utils = [BFUtils shareUtils];
//    NSString *currentUserName = utils.loginResult.userName;
//    NSString *currentUserID = utils.loginResult.userId;
//    NSString *currentCenterID = utils.loginResult.centerId;
//    NSString *currentCenterName =utils.loginResult.centerName;
//    NSLog(@"当前操作用户:%@ - %@ - %@ - %@",currentUserID,currentUserName,currentCenterID,currentCenterName);
//    NSString *currentUserInfo = [NSString stringWithFormat:@"%@ - %@ - %@ - %@",currentUserID,currentUserName,currentCenterID,currentCenterName];
//    crashLog.userInfo = currentUserInfo;
//    
//    // 时间
//    NSDate *date = [[NSDate alloc] init];
//    crashLog.logTime = [NSString stringWithFormat:@"%@",[date stringWithDateFormatter:DateFormatterForCompleteYMDHM]];
//    
//    // 异常的堆栈信息
//    //NSArray *stackArray=[exception callStackSymbols];
//    NSLog(@"异常堆栈信息 :%@",stackArray);
//    NSString *strackArrayInfo = [NSString stringWithFormat:@"%@",stackArray];
//    // 去除掉首尾的空白字符和
//    strackArrayInfo = [strackArrayInfo stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//    // 去除换行操作
//    strackArrayInfo = [strackArrayInfo stringByReplacingOccurrencesOfString:@"\r" withString:@""];
//    strackArrayInfo = [strackArrayInfo stringByReplacingOccurrencesOfString:@"\n" withString:@"--"];
//    // 字符串中的所有空格
//    strackArrayInfo = [strackArrayInfo stringByReplacingOccurrencesOfString:@" " withString:@""];
//    //NSLog(@"截取前异常信息长度:length--%ld",(unsigned long)[strackArrayInfo length]);
//    // 如果字符串过长截取前4000
////    if([strackArrayInfo length] >= 4000){
////         strackArrayInfo = [strackArrayInfo substringToIndex:4000];
////    }
//    //NSLog(@"截取后异常信息长度:length--%ld",(unsigned long)[strackArrayInfo length]);
//    crashLog.stackArrayInfo = strackArrayInfo;
//    
//    
//    
//    // 出现异常的原因
//    NSString *reason=[exception reason];
//    NSLog(@"出现异常的原因%@",reason);
//    crashLog.reason = reason;
//    
//    // 异常名称
//    NSString *name=[exception name];
//    NSLog(@"异常名称:%@",name);
//    crashLog.crashName = name;
//    
//    // 插入本次的异常信息
//    [[BFDataBase shareDataBase]insertCrashLog:crashLog];
    
    
	CFRunLoopRef runLoop = CFRunLoopGetCurrent();
	CFArrayRef allModes = CFRunLoopCopyAllModes(runLoop);
	
    // alertView 点击退出不执行改方法  点击绩效执行该方法
	while (dismissed)
	{
		for (NSString *mode in (NSArray *)allModes)
		{
			CFRunLoopRunInMode((CFStringRef)mode, 0.001, false);
		}
	}
	
	CFRelease(allModes);

	NSSetUncaughtExceptionHandler(NULL);
	signal(SIGABRT, SIG_DFL);
	signal(SIGILL, SIG_DFL);
	signal(SIGSEGV, SIG_DFL);
	signal(SIGFPE, SIG_DFL);
	signal(SIGBUS, SIG_DFL);
	signal(SIGPIPE, SIG_DFL);
	
	if ([[exception name] isEqual:UncaughtExceptionHandlerSignalExceptionName])
	{
		kill(getpid(), [[[exception userInfo] objectForKey:UncaughtExceptionHandlerSignalKey] intValue]);
	}
	else
	{
		[exception raise];
	}
}

@end

void HandleException(NSException *exception)
{
	int32_t exceptionCount = OSAtomicIncrement32(&UncaughtExceptionCount);
	if (exceptionCount > UncaughtExceptionMaximum)
	{
		return;
	}
	
	NSArray *callStack = [UncaughtExceptionHandler backtrace];
	NSMutableDictionary *userInfo =
		[NSMutableDictionary dictionaryWithDictionary:[exception userInfo]];
	[userInfo
		setObject:callStack
		forKey:UncaughtExceptionHandlerAddressesKey];
	
    NSMutableDictionary *mDict =[NSMutableDictionary dictionary];
    [mDict setObject:[NSException
                     exceptionWithName:[exception name]
                     reason:[exception reason]
                      userInfo:userInfo] forKey:@"exception"];
    [mDict setObject:[exception callStackSymbols] forKey:@"stackArray"];
    
	[[[[UncaughtExceptionHandler alloc] init] autorelease]
		performSelectorOnMainThread:@selector(handleException:)
		withObject:mDict waitUntilDone:YES];
}

void SignalHandler(int signal)
{
	int32_t exceptionCount = OSAtomicIncrement32(&UncaughtExceptionCount);
	if (exceptionCount > UncaughtExceptionMaximum)
	{
		return;
	}
	
	NSMutableDictionary *userInfo =
		[NSMutableDictionary
			dictionaryWithObject:[NSNumber numberWithInt:signal]
			forKey:UncaughtExceptionHandlerSignalKey];

	NSArray *callStack = [UncaughtExceptionHandler backtrace];
	[userInfo
		setObject:callStack
		forKey:UncaughtExceptionHandlerAddressesKey];
	
    NSMutableDictionary *mDict = [NSMutableDictionary dictionary];
    [mDict setObject:[NSException
                     exceptionWithName:UncaughtExceptionHandlerSignalExceptionName
                     reason:
                     [NSString stringWithFormat:
                      NSLocalizedString(@"Signal %d was raised.", nil),
                      signal]
                     userInfo:
                     [NSDictionary
                      dictionaryWithObject:[NSNumber numberWithInt:signal]
                      forKey:UncaughtExceptionHandlerSignalKey]] forKey:@"exception"];
    [mDict setObject:[UncaughtExceptionHandler backtrace] forKey:@"stackArray"];
    
	[[[[UncaughtExceptionHandler alloc] init] autorelease]
		performSelectorOnMainThread:@selector(handleException:)
		withObject:mDict waitUntilDone:YES];
}

void InstallUncaughtExceptionHandler(void)
{
	NSSetUncaughtExceptionHandler(&HandleException);
	signal(SIGABRT, SignalHandler);
	signal(SIGILL, SignalHandler);
	signal(SIGSEGV, SignalHandler);
	signal(SIGFPE, SignalHandler);
	signal(SIGBUS, SignalHandler);
	signal(SIGPIPE, SignalHandler);
}

