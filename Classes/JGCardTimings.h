#import <Foundation/Foundation.h>


@interface JGCardTimings : NSObject {
    NSDate *greenCardTime;
    NSDate *yellowCardTime;
    NSDate *redCardTime;
}
@property(nonatomic, readonly, retain) NSDate *greenCardTime;
@property(nonatomic, readonly, retain) NSDate *yellowCardTime;
@property(nonatomic, readonly, retain) NSDate *redCardTime;


+(JGCardTimings *)cardTimingsWithGreenTime:(NSDate *)greenCardTime_ yellowTime:(NSDate *)yellowCardTime_ redTime:(NSDate *)redCardTime_;

-(JGCardTimings *)initWithGreenTime:(NSDate *)greenCardTime_ yellowTime:(NSDate *)yellowCardTime_ redTime:(NSDate *)redCardTime_;


@end