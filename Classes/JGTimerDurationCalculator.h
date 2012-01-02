#import <Foundation/Foundation.h>


@interface JGTimerDurationCalculator : NSObject {
    NSTimeInterval greenCardTime;
    NSTimeInterval yellowCardTime;
    NSTimeInterval redCardTime;
}

+(JGTimerDurationCalculator *)calculatorWithDuration:(NSUInteger)durationValue;
-(JGTimerDurationCalculator *)initWithDuration:(NSUInteger)durationValue;

-(NSTimeInterval)greenCardTime;
-(NSTimeInterval)yellowCardTime;
-(NSTimeInterval)redCardTime;

@end
