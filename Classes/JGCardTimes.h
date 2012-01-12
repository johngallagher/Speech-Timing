#import <Foundation/Foundation.h>


@interface JGCardTimes : NSObject {
    NSDate *greenCardTime;
    NSDate *yellowCardTime;
    NSDate *redCardTime;
}
@property(nonatomic, readonly, retain) NSDate *greenCardTime;
@property(nonatomic, readonly, retain) NSDate *yellowCardTime;
@property(nonatomic, readonly, retain) NSDate *redCardTime;


+(JGCardTimes *)cardTimesWithTimeIntervalSinceNowGreen:(NSTimeInterval)g yellow:(NSTimeInterval)y red:(NSTimeInterval)r;

+(JGCardTimes *)cardTimesWithGreenTime:(NSDate *)greenCardTime_ yellowTime:(NSDate *)yellowCardTime_ redTime:(NSDate *)redCardTime_;

-(JGCardTimes *)initWithGreenTime:(NSDate *)greenCardTime_ yellowTime:(NSDate *)yellowCardTime_ redTime:(NSDate *)redCardTime_;


@end