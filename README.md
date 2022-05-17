# JSContext 支持window.setTimeout

参考1：https://developer.mozilla.org/en-US/docs/Web/API/setTimeout
参考2：https://developer.mozilla.org/en-US/docs/Web/API/setInterval

## JavaScript 调用参考

```javascript
nativeLog("开始计时");
var intervalId = setInterval(function(){nativeLog("客户端完成计时 setInterval 任务");}, 1000);
nativeLog(intervalId);
setTimeout(function(){nativeLog("客户端完成计时任务");clearInterval(intervalId);}, 3000);
```

## Objective - C 参考

```objective-c
JSContext *ctx = [[JSContext alloc] init];
[ctx enableWindowTimer];
NSString *filePath = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"js"];
NSString *script = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
[ctx evaluateScript:script];
```

