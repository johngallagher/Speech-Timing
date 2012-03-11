#import <Foundation/Foundation.h>

@class JGCardTimes;


@interface JGCardTimesCalculator : NSObject {
    NSTimeInterval _greenCardTimeInterval;
    NSTimeInterval _yellowCardTimeInterval;
    NSTimeInterval _redCardTimeInterval;
    NSDate *_startTime;
}

+(JGCardTimesCalculator *)calculatorWithStartTime:(NSDate *)startTime_ andFireTime:(NSDate *)fireTime_;

-(JGCardTimesCalculator *)initWithStartTime:(NSDate *)startTime_ andFireTime:(NSDate *)fireTime_;

-(NSDate *)greenCardTime;

-(NSDate *)yellowCardTime;

-(NSDate *)redCardTime;

-(JGCardTimes *)cardTimings;

@end
