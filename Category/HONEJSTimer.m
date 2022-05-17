//
//  MyView.m
//  JSDemo
//
//  Created by henry on 2022/5/17.
//

#import "HONEJSTimer.h"

static long timerIdentifier = 1;

@interface HONEJSTimer()

@property(nonatomic, strong)NSMutableDictionary *timers;

@end

@implementation HONEJSTimer
- (instancetype)init;{
    if (self = [super init]) {
        self.timers = [[NSMutableDictionary alloc]init];
    }
    return self;
}

#pragma Protocol
- (void)clearTimeout:(long)identifier {
    NSString *keyStr = [NSString stringWithFormat:@"%ld", identifier];
    NSTimer *timer = [self.timers valueForKey:keyStr];
    [timer invalidate];
    NSLog(@"[clearTimeout] keyStr =%@", keyStr);
    [self.timers removeObjectForKey:keyStr];
}

- (void)clearInterval:(long)identifier {
    [self clearTimeout:identifier];
}

- (long)setInterval:(JSValue *)callBack :(float)timeout{
    return [self createTimer:callBack ms:timeout repeats:YES];
}

- (long)setTimeout:(JSValue *)callBack :(float)timeout{
    NSLog(@"timeout =%f", timeout);
    return [self createTimer:callBack ms:timeout repeats:NO];  
}

#pragma - Private
- (long)createTimer:(JSValue *)callBack ms:(double)ms repeats:(BOOL)repeats{
    __block NSTimeInterval interval = ms / 1000.0;
    dispatch_async(dispatch_get_main_queue(), ^{
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(action:) userInfo:callBack repeats:repeats];
        NSString *keyStr = [NSString stringWithFormat:@"%ld", timerIdentifier];
        NSLog(@"[createTimer] keyStr =%@ ms=%f", keyStr, ms);
        self.timers[keyStr] = timer;
        timerIdentifier += 1;
    });
    return timerIdentifier;
}

/// 执行回调
/// @param timer 定时器
- (void)action:(NSTimer *)timer{
    JSValue *callBack = timer.userInfo;
    [callBack callWithArguments:@[]];
}

@end
