
#import "JGTimerDurationCalculator.h"


@implementation JGTimerDurationCalculator

-(void)initTimesFromDuration:(NSUInteger)duration_ {
    if (duration_ < 3) {
        greenCardTime   = 0;
        yellowCardTime  = 0;
        redCardTime     = 0;
        return;
    }
    
    if (duration_ >= 3 && duration_ < 240) {
        greenCardTime   = 0.5   * duration_;
        yellowCardTime  = 0.75  * duration_;
    } else if (duration_ >= 240 && duration_ < 600) {
        greenCardTime   = duration_ - 120;
        yellowCardTime  = duration_ - 60;
    } else if (duration_ >= 600 && duration_ < 1800) {
        greenCardTime   = duration_ - 240;
        yellowCardTime  = duration_ - 120;
    } else if (duration_ >= 1800) {
        greenCardTime   = duration_ - 600;
        yellowCardTime  = duration_ - 300;
    }
    redCardTime     = duration_;
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
