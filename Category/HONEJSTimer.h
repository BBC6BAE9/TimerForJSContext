//
//  MyView.h
//  JSDemo
//
//  Created by henry on 2022/5/17.
//

#import <UIKit/UIKit.h>
#include <JavaScriptCore/JavaScriptCore.h>

@protocol HONEJSTimerExport <JSExport>
- (instancetype)init;


/// 清除定时器
/// @param identifier 定时器标识符
- (void)clearTimeout:(long)identifier;

/// 清除定时器
/// @param identifier 定时器标识符
- (void)clearInterval:(long)identifier;

/// 设置Interval
/// @param callBack 回调
- (long)setInterval:(JSValue *)callBack :(float)timeout;

/// 设置Timeout
/// @param callBack 回调
- (long)setTimeout:(JSValue *)callBack :(float)timeout;

@end

@interface HONEJSTimer : NSObject <HONEJSTimerExport>

@end

