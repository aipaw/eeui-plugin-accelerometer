//
//  AppAccelerometer.m
//
//

#import "AppAccelerometer.h"
#import <CoreMotion/CoreMotion.h>
#import <UIKit/UIKit.h>

@interface AppAccelerometer ()
@property (strong, nonatomic) CMMotionManager *motionManager;

@end

@implementation AppAccelerometer

#define kGravitationalConstant -9.81

+ (AppAccelerometer *)singletonManger{
    static id manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}


- (void)get:(AppCallback)back{
    // 1. 判断是否支持加速计硬件
    //    BOOL available = [self.motionManager isAccelerometerAvailable];
    //    if (available == NO) {
    //        NSLog(@"加速计不能用");
    //        return;
    //    }
    // 获取硬件数据的更新间隙
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.accelerometerUpdateInterval = 0.5;
    if (self.motionManager.isAccelerometerActive == NO) {
        
        // 开始更新硬件数据
        [self.motionManager startAccelerometerUpdates];
    }
    
    //  Push(按照accelerometerUpdateInterval定时推送回来)
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
        
        // CMAcceleration 是表示加速计数据的结构体
        if (error) {
            back(@{@"error":@{@"code":@1,@"msg":@"ACCELEROMETER_INTERNAL_ERROR"}},nil);
        }else{
            CMAcceleration acceleration = accelerometerData.acceleration;
            [self.motionManager stopAccelerometerUpdates];
            back(nil,@{@"x":@(acceleration.x * kGravitationalConstant),@"y":@(acceleration.y * kGravitationalConstant),@"z":@(acceleration.z * kGravitationalConstant)});
        }
    }];
}

- (void)watch:(NSDictionary *)options :(AppCallback)back{
    // 获取硬件数据的更新间隙
    self.motionManager = [[CMMotionManager alloc] init];
    
    CGFloat interval = 0.1;
    if (self.motionManager.isAccelerometerActive == NO) {
        
        // 开始更新硬件数据
        [self.motionManager startAccelerometerUpdates];
    }
    if (options) {
        if (options[@"interval"] && [options[@"interval"] isKindOfClass:[NSNumber class]] && [options[@"interval"] integerValue]) {
            interval = [options[@"interval"] integerValue]/1000.0;
        }
    }
    
    self.motionManager.accelerometerUpdateInterval = interval;
    //  Push(按照accelerometerUpdateInterval定时推送回来)
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
        if (error) {
            back(@{@"error":@{@"code":@1,@"msg":@"ACCELEROMETER_INTERNAL_ERROR"}},nil);
        }else{
            CMAcceleration acceleration = accelerometerData.acceleration;
            back(nil,@{@"x":@(acceleration.x * kGravitationalConstant),@"y":@(acceleration.y * kGravitationalConstant),@"z":@(acceleration.z * kGravitationalConstant)});
            
        }
        
    }];
    
}

- (void)clearWatch:(AppCallback)back{
    if (self.motionManager.isAccelerometerActive == YES) {
        // 结束更新硬件数据
        [self.motionManager stopAccelerometerUpdates];
        back(nil,nil);
    }
    
}
- (void)close{
    if (self.motionManager.isAccelerometerActive == YES) {
        // 结束更新硬件数据
        [self.motionManager stopAccelerometerUpdates];
    }
}
@end
