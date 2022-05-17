
//var timer = new Timer();
nativeLog("开始计时");
var intervalId = setInterval(function(){nativeLog("客户端完成计时 setInterval 任务");}, 1000);
nativeLog(intervalId);
setTimeout(function(){nativeLog("客户端完成计时任务");clearInterval(intervalId);}, 3000);
//timer.setTimeout(function(){nativeLog(1231);}, 10000)
//timer.setTimeout(10000.0, 10000.0)
