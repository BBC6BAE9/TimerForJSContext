//
//  JSContext+WindowTimer.m
//  JSDemo
//
//  Created by henry on 2022/5/17.
//

#import "JSContext+WindowTimer.h"
#import "HONEJSTimer.h"

@implementation JSContext (WindowTimer)

- (void)enableWindowTimer{
    self[@"nativeLog"] = ^(NSString *msg) {
        NSLog(@"[JS log] %@", msg);
    };
    self[@"GlobalTimer"] = [[HONEJSTimer alloc] init];
    // 对 JS 注入全局方法
    [self evaluateScript:@"function setTimeout(callback,duration){return GlobalTimer.setTimeout(callback,duration)}function setInterval(callback,duration){return GlobalTimer.setInterval(callback,duration)}function clearTimeout(timerId){GlobalTimer.clearTimeout(timerId)}function clearInterval(timerId){GlobalTimer.clearInterval(timerId)}"];
}

@end
