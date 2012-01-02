
#import "JGTimerDurationCalculator.h"


@implementation JGTimerDurationCalculator

-(void)calculateGreenAndYellowCardTimesFromDuration:(NSUInteger)duration_ {
    NSLog(@"**Duration is %d", duration_);
    
    BOOL durationImpliesQuarterIncrements    = (duration_ >= 3    && duration_ < 240);
    BOOL durationImpliesOneMinuteIncrements  = (duration_ >= 240  && duration_ < 600);
    BOOL durationImpliesTwoMinuteIncrements  = (duration_ >= 600  && duration_ < 1800);
    BOOL durationImpliesFiveMinuteIncrements = (duration_ >= 1800);
    
    if (durationImpliesQuarterIncrements) {
        greenCardTime   = 0.5   * duration_;
        yellowCardTime  = 0.75  * duration_;
    } else if (durationImpliesOneMinuteIncrements) {
        greenCardTime   = duration_ - 120;
        yellowCardTime  = duration_ - 60;
    } else if (durationImpliesTwoMinuteIncrements) {
        greenCardTime   = duration_ - 240;
        yellowCardTime  = duration_ - 120;
    } else if (durationImpliesFiveMinuteIncrements) {
        greenCardTime   = duration_ - 600;
        yellowCardTime  = duration_ - 300;
    }
}

-(void)initTimesFromDuration:(NSUInteger)duration_ {
    NSLog(@"Duration is less than 3 %d", (BOOL)(duration_ < 3));
    if (duration_ < 3) {
        greenCardTime   = 0;
        yellowCardTime  = 0;
        redCardTime     = 0;
        return;
    }
    
    [self calculateGreenAndYellowCardTimesFromDuration:duration_];
    
    redCardTime     = duration_;
    NSLog(@"Green Card time is %f", greenCardTime);
    NSLog(@"Yellow Card time is %f", yellowCardTime);
    NSLog(@"Red Card time is %f", redCardTime);
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
