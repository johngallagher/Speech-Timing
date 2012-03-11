#import "JGCardTimesCalculator.h"
#import "JGCardTimes.h"


@implementation JGCardTimesCalculator

-(void)calculateCardTimesFromDuration:(NSTimeInterval)duration_ {
    BOOL durationImpliesQuarterIncrements    = (duration_ >= 3 && duration_ < 240);
    BOOL durationImpliesOneMinuteIncrements  = (duration_ >= 240 && duration_ < 600);
    BOOL durationImpliesTwoMinuteIncrements  = (duration_ >= 600 && duration_ < 1800);
    BOOL durationImpliesFiveMinuteIncrements = (duration_ >= 1800);

    if (durationImpliesQuarterIncrements) {
        _greenCardTimeInterval = 0.5 * duration_;
        _yellowCardTimeInterval = 0.75 * duration_;
    } else
        if (durationImpliesOneMinuteIncrements) {
            _greenCardTimeInterval = duration_ - 120;
            _yellowCardTimeInterval = duration_ - 60;
        } else
            if (durationImpliesTwoMinuteIncrements) {
                _greenCardTimeInterval = duration_ - 240;
                _yellowCardTimeInterval = duration_ - 120;
            } else
                if (durationImpliesFiveMinuteIncrements) {
                    _greenCardTimeInterval = duration_ - 600;
                    _yellowCardTimeInterval = duration_ - 300;
                }
    _redCardTimeInterval = duration_;
}

-(void)initTimesFromDuration:(NSTimeInterval)duration_ {
    if (duration_ == 0) {
        _greenCardTimeInterval = 0;
        _yellowCardTimeInterval = 0;
        _redCardTimeInterval = 0;
        return;
    }

    [self calculateCardTimesFromDuration:duration_];
}

+(JGCardTimesCalculator *)calculatorWithStartTime:(NSDate *)startTime_ andFireTime:(NSDate *)fireTime_ {
    return [[[JGCardTimesCalculator alloc] initWithStartTime:startTime_ andFireTime:fireTime_] autorelease];
}

-(JGCardTimesCalculator *)initWithStartTime:(NSDate *)startTime_ andFireTime:(NSDate *)fireTime_ {
    self = [super init];
    _startTime = [startTime_ retain];
    [self initTimesFromDuration:[fireTime_ timeIntervalSinceDate:startTime_]];
    return self;
}

-(NSDate *)greenCardTime {
    return [_startTime dateByAddingTimeInterval:_greenCardTimeInterval];
}

-(NSDate *)yellowCardTime {
    return [_startTime dateByAddingTimeInterval:_yellowCardTimeInterval];
}

-(NSDate *)redCardTime {
    return [_startTime dateByAddingTimeInterval:_redCardTimeInterval];
}

-(void)dealloc {
    [_startTime release];
    [super dealloc];
}

-(JGCardTimes *)cardTimings {
    return [JGCardTimes cardTimesWithGreenTime:[self greenCardTime] yellowTime:[self yellowCardTime] redTime:[self redCardTime]];
}

@end
