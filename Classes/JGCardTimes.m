#import "JGCardTimes.h"


@implementation JGCardTimes

@synthesize greenCardTime;
@synthesize yellowCardTime;
@synthesize redCardTime;

+(JGCardTimes *)cardTimesWithTimeIntervalSinceNowGreen:(NSTimeInterval)g yellow:(NSTimeInterval)y red:(NSTimeInterval)r {
    return [self cardTimesWithGreenTime:[NSDate dateWithTimeIntervalSinceNow:g]
                                    yellowTime:[NSDate dateWithTimeIntervalSinceNow:y]
                                       redTime:[NSDate dateWithTimeIntervalSinceNow:r]];
}

+(JGCardTimes *)cardTimesWithGreenTime:(NSDate *)greenCardTime_ yellowTime:(NSDate *)yellowCardTime_ redTime:(NSDate *)redCardTime_ {
    return [[[JGCardTimes alloc] initWithGreenTime:greenCardTime_ yellowTime:yellowCardTime_ redTime:redCardTime_] autorelease];
}

-(JGCardTimes *)initWithGreenTime:(NSDate *)greenCardTime_ yellowTime:(NSDate *)yellowCardTime_ redTime:(NSDate *)redCardTime_ {
    self = [super init];
    if (self) {
        greenCardTime = [greenCardTime_ retain];
        yellowCardTime = [yellowCardTime_ retain];
        redCardTime = [redCardTime_ retain];
    }

    return self;
}

-(BOOL)isEqual:(id)object {
    if (![object isKindOfClass:[JGCardTimes class]])
        return [super isEqual:object];

    JGCardTimes *cardTimings = object;
    return (round([greenCardTime timeIntervalSinceDate:[cardTimings greenCardTime]]) == 0) &&
           (round([yellowCardTime timeIntervalSinceDate:[cardTimings yellowCardTime]]) == 0) &&
           (round([redCardTime timeIntervalSinceDate:[cardTimings redCardTime]]) == 0);
}

-(NSString *)description {
    return [NSString stringWithFormat:@"\nG %@\nY %@\nR %@\n", [self greenCardTime], [self yellowCardTime], [self redCardTime]];
}


-(void)dealloc {
    [greenCardTime release];
    [yellowCardTime release];
    [redCardTime release];
    [super dealloc];
}

@end