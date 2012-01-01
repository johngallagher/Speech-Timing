
#import "JGTimerDurationCalculator.h"


@implementation JGTimerDurationCalculator

-(void)initTimesFromDuration:(NSUInteger)duration_ {
    greenCardTime = 0;
    yellowCardTime = 0;
    redCardTime = 0;
}

+(JGTimerDurationCalculator *)calculatorWithDuration:(NSUInteger)durationValue {
    JGTimerDurationCalculator *instance = [[[JGTimerDurationCalculator alloc] initWithDuration:durationValue] autorelease];
    return instance;
}

-(JGTimerDurationCalculator *)initWithDuration:(NSUInteger)durationValue {
    self = [super init];
    [self initTimesFromDuration:durationValue];
    return self;
}

-(NSUInteger)greenCardTime {
    return greenCardTime;
}

-(NSUInteger)yellowCardTime {
    return yellowCardTime;
}

-(NSUInteger)redCardTime {
    return redCardTime;
}

@end
