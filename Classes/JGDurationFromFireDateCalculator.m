#import "JGDurationFromFireDateCalculator.h"

@implementation JGDurationFromFireDateCalculator
+(NSUInteger)positiveDurationFromFireDate:(NSDate *)date_ {
    if ([date_ timeIntervalSinceNow] < 0)
        return 0;

    return (NSUInteger) round([date_ timeIntervalSinceDate:[NSDate date]]);
}
@end