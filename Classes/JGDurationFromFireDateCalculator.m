#import "JGDurationFromFireDateCalculator.h"

@implementation JGDurationFromFireTimeCalculator
+(NSUInteger)positiveDurationFromFireTime:(NSDate *)date_ {
    if ([date_ timeIntervalSinceNow] < 0)
        return 0;

    return (NSUInteger)round([date_ timeIntervalSinceDate:[NSDate date]]);
}
@end