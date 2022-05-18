//
//  MyView.m
//  JSDemo
//
//  Created by henry on 2022/5/17.
//

#import "HONEJSTimer.h"

static long timerIdentifier = 1;    //仅本文件可见

// 前端建议15分钟
#pragma 定时器安全设置
// 一个定时器允许存在的最长时间
static int timerSafeMaxTime = 15 * 60 * 1000;
// 同一时刻最多允许的定时器数量
static int timerSafeMaxCount = 10;

// 同一时刻最多允许的定时器数量，没有创建定时器返回的标识符
static int timerSafeMaxReachCountIdentifier = 0;

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
    if ([self.timers allKeys].count > timerSafeMaxCount) {
        return timerSafeMaxReachCountIdentifier;
    }
    long identifier =  timerIdentifier;
    timerIdentifier += 1;
    [self performSelectorOnMainThread:@selector(haha) withObject:nil waitUntilDone:NO];

    __block NSTimeInterval interval = ms / 1000.0;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(action:) userInfo:callBack repeats:repeats];
    NSString *keyStr = [NSString stringWithFormat:@"%ld", identifier];
    NSLog(@"[createTimer] keyStr =%@ ms=%f", keyStr, ms);
    self.timers[keyStr] = timer;
    // 超时保护
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timerSafeMaxTime * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
        if([[self.timers allKeys] containsObject:keyStr]){
            NSLog(@"【超时保护】发现超过安全时间的定时器：%@，自动清除", keyStr);
            [self clearTimeout:[keyStr longLongValue]];
        }else{
            NSLog(@"【超时保护】没有发现超过安全时间的定时器");
        }
    });
    
    return identifier;
}

-(void)haha{
    
}
/// 执行回调
/// @param timer 定时器
- (void)action:(NSTimer *)timer{
    JSValue *callBack = timer.userInfo;
    [callBack callWithArguments:@[]];
}

@end
