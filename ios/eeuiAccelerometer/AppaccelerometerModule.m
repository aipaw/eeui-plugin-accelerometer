//
//  AppaccelerometerModule.m
//  Pods
//

#import "AppaccelerometerModule.h"
#import <WeexPluginLoader/WeexPluginLoader.h>
#import "AppAccelerometer.h"

@interface AppaccelerometerModule ()

@end

@implementation AppaccelerometerModule

WX_PlUGIN_EXPORT_MODULE(eeuiAccelerometer, AppaccelerometerModule)
WX_EXPORT_METHOD(@selector(get:))
WX_EXPORT_METHOD(@selector(watch::))
WX_EXPORT_METHOD(@selector(clearWatch:))

- (void)get:(WXModuleCallback)callback{
    [[AppAccelerometer singletonManger] get:^(id error,id result) {
        if (callback) {
            if (error) {
                callback(error);
            } else {
                callback(result);
            }
        }
    }];
}

- (void)watch:(NSDictionary *)options :(WXModuleKeepAliveCallback)callback{
    [[AppAccelerometer singletonManger] watch:options :^(id error,id result) {
        if (callback) {
            if (error) {
                callback(error, YES);
            } else {
                callback(result, YES);
            }
        }
    }];
}

- (void)clearWatch:(WXModuleCallback)callback{
    [[AppAccelerometer singletonManger] clearWatch:^(id error,id result) {
        if (callback) {
            if (error) {
                callback(error);
            } else {
                callback(result);
            }
        }
    }];
}

- (void)dealloc{
    [[AppAccelerometer singletonManger] close];
}

@end
