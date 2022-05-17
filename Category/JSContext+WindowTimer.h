//
//  JSContext+WindowTimer.h
//  JSDemo
//
//  Created by henry on 2022/5/17.
//

#import <JavaScriptCore/JavaScriptCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSContext (WindowTimer)

/// JSContext支持定时器
- (void)enableWindowTimer;

@end

NS_ASSUME_NONNULL_END
