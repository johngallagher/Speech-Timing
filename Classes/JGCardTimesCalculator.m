#import "JGCardTimesCalculator.h"
#import "JGCardTimes.h"


@implementation JGCardTimesCalculator

@synthesize startTime;

-(void)calculateCardTimesFromDuration:(NSTimeInterval)duration_ {
    BOOL durationImpliesQuarterIncrements    = (duration_ >= 3 && duration_ < 240);
    BOOL durationImpliesOneMinuteIncrements  = (duration_ >= 240 && duration_ < 600);
    BOOL durationImpliesTwoMinuteIncrements  = (duration_ >= 600 && duration_ < 1800);
    BOOL durationImpliesFiveMinuteIncrements = (duration_ >= 1800);

    if (durationImpliesQuarterIncrements) {
        greenCardTimeInterval = 0.5 * duration_;
        yellowCardTimeInterval = 0.75 * duration_;
    } else
        if (durationImpliesOneMinuteIncrements) {
            greenCardTimeInterval = duration_ - 120;
            yellowCardTimeInterval = duration_ - 60;
        } else
            if (durationImpliesTwoMinuteIncrements) {
                greenCardTimeInterval = duration_ - 240;
                yellowCardTimeInterval = duration_ - 120;
            } else
                if (durationImpliesFiveMinuteIncrements) {
                    greenCardTimeInterval = duration_ - 600;
                    yellowCardTimeInterval = duration_ - 300;
                }
    redCardTimeInterval = duration_;
}

-(void)initTimesFromDuration:(NSTimeInterval)duration_ {
    if (duration_ == 0) {
        greenCardTimeInterval = 0;
        yellowCardTimeInterval = 0;
        redCardTimeInterval = 0;
        return;
    }

    [self calculateCardTimesFromDuration:duration_];
}

+(JGCardTimesCalculator *)calculatorWithStartTime:(NSDate *)startTime_ andFireTime:(NSDate *)fireTime_ {
    JGCardTimesCalculator *instance = [[[JGCardTimesCalculator alloc] initWithStartTime:startTime_ andFireTime:fireTime_] autorelease];
    return instance;
}

-(JGCardTimesCalculator *)initWithStartTime:(NSDate *)startTime_ andFireTime:(NSDate *)fireTime_ {
    self = [super init];
    [self setStartTime:startTime_];
    [self initTimesFromDuration:[fireTime_ timeIntervalSinceDate:startTime_]];
    return self;
}

-(NSDate *)greenCardTime {
    return [[self startTime] dateByAddingTimeInterval:greenCardTimeInterval];
}

-(NSDate *)yellowCardTime {
    return [[self startTime] dateByAddingTimeInterval:yellowCardTimeInterval];
}

-(NSDate *)redCardTime {
    return [[self startTime] dateByAddingTimeInterval:redCardTimeInterval];
}

-(void)dealloc {
    [startTime release];
    [super dealloc];
}

-(JGCardTimes *)cardTimings {
    return [JGCardTimes cardTimesWithGreenTime:[self greenCardTime] yellowTime:[self yellowCardTime] redTime:[self redCardTime]];
}

@end
