
#import "JGTimerDurationCalculator.h"


@implementation JGTimerDurationCalculator

-(void)initTimesFromDuration:(NSUInteger)duration_ {
    if (duration_ < 3) {
        greenCardTime   = 0;
        yellowCardTime  = 0;
        redCardTime     = 0;
    } else if (duration_ >= 3 && duration_ < 240 ) {
        greenCardTime   = 0.5   * duration_;
        yellowCardTime  = 0.75  * duration_;
        redCardTime     = 1     * duration_;
    }
    }

+(JGTimerDurationCalculator *)calculatorWithDurationInMinutes:(NSUInteger)durationValue {
    return [self calculatorWithDuration:(durationValue * 60)];
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

-(NSTimeInterval)greenCardTime {
    return greenCardTime;
}

-(NSTimeInterval)yellowCardTime {
    return yellowCardTime;
}

-(NSTimeInterval)redCardTime {
    return redCardTime;
}

@end
