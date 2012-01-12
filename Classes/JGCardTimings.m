#import "JGCardTimings.h"


@implementation JGCardTimings

@synthesize greenCardTime;
@synthesize yellowCardTime;
@synthesize redCardTime;


+(JGCardTimings *)cardTimingsWithGreenTime:(NSDate *)greenCardTime_ yellowTime:(NSDate *)yellowCardTime_ redTime:(NSDate *)redCardTime_ {
    return [[[JGCardTimings alloc] initWithGreenTime:greenCardTime_ yellowTime:yellowCardTime_ redTime:redCardTime_] autorelease];
}

-(JGCardTimings *)initWithGreenTime:(NSDate *)greenCardTime_ yellowTime:(NSDate *)yellowCardTime_ redTime:(NSDate *)redCardTime_ {
    self = [super init];
    if (self) {
        greenCardTime = [greenCardTime_ retain];
        yellowCardTime = [yellowCardTime_ retain];
        redCardTime = [redCardTime_ retain];
    }

    return self;
}

-(BOOL)isEqual:(id)object {
    if (![object isKindOfClass:[JGCardTimings class]])
        return [super isEqual:object];

    JGCardTimings *cardTimings = object;
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