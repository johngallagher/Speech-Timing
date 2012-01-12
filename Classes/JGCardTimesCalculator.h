#import <Foundation/Foundation.h>

@class JGCardTimings;


@interface JGCardTimesCalculator : NSObject {
    NSTimeInterval greenCardTimeInterval;
    NSTimeInterval yellowCardTimeInterval;
    NSTimeInterval redCardTimeInterval;
    NSDate *startTime;
}

@property(nonatomic, retain) NSDate *startTime;

+(JGCardTimesCalculator *)calculatorWithStartTime:(NSDate *)startTime_ andFireTime:(NSDate *)fireTime_;

-(JGCardTimesCalculator *)initWithStartTime:(NSDate *)startTime_ andFireTime:(NSDate *)fireTime_;

-(NSDate *)greenCardTime;

-(NSDate *)yellowCardTime;

-(NSDate *)redCardTime;

-(JGCardTimings *)cardTimings;
@end
