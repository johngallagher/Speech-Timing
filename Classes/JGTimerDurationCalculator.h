#import <Foundation/Foundation.h>


@interface JGTimerDurationCalculator : NSObject {
    NSUInteger greenCardTime;
    NSUInteger yellowCardTime;
    NSUInteger redCardTime;
}

+(JGTimerDurationCalculator *)calculatorWithDuration:(NSUInteger)durationValue;
-(JGTimerDurationCalculator *)initWithDuration:(NSUInteger)durationValue;

-(NSUInteger)greenCardTime;
-(NSUInteger)yellowCardTime;
-(NSUInteger)redCardTime;

@end
