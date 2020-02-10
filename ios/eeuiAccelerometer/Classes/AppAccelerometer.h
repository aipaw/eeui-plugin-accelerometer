//
//  AppAccelerometer.h
//
//

#import <Foundation/Foundation.h>

@interface AppAccelerometer : NSObject

typedef void (^AppCallback)(id error,id result);
+ (AppAccelerometer *)singletonManger;
- (void)get:(AppCallback)back;
- (void)watch:(NSDictionary *)options :(AppCallback)back;
- (void)clearWatch:(AppCallback)back;
- (void)close;


@end
