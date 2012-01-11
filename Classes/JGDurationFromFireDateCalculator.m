#import "JGDurationFromFireDateCalculator.h"

@implementation JGDurationFromFireDateCalculator
+(NSUInteger)durationFromFireDate:(NSDate *)date_ {
    return (NSUInteger) round([date_ timeIntervalSinceDate:[NSDate date]]);
}
@end