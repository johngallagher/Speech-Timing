#import "JGTimerDurationCalculatorTestCase.h"
#import "JGCardTimesCalculator.h"
#import "JGCardTimes.h"

@implementation JGTimerDurationCalculatorTestCase

-(void)setUpCalculatorStartingNowWithDuration:(NSUInteger)duration {
    calculator = [JGCardTimesCalculator calculatorWithStartTime:[NSDate date] andFireTime:[NSDate dateWithTimeIntervalSinceNow:duration]];
}

-(void)setUpCalculatorStartedAt:(NSDate *)startTime withDuration:(NSUInteger)duration {
    calculator = [JGCardTimesCalculator calculatorWithStartTime:startTime andFireTime:[startTime dateByAddingTimeInterval:duration]];
}

-(void)testGivenDuration0ShouldReturn0ForAllCards {
    [self setUpCalculatorStartingNowWithDuration:0];

    JGCardTimes *expectedTimings = [JGCardTimes cardTimesWithGreenTime:[NSDate date] yellowTime:[NSDate date] redTime:[NSDate date]];
    JGCardTimes *actualTimings   = [calculator cardTimings];

    STAssertEqualObjects(expectedTimings, actualTimings, @"Actual timings are %@", actualTimings);
}

-(void)testGivenDurationInRangeBelow4MinutesTimesShouldBeIncrementsOfQuarter {
    [self setUpCalculatorStartingNowWithDuration:40];

    JGCardTimes *expectedTimings = [JGCardTimes cardTimesWithTimeIntervalSinceNowGreen:20 yellow:30 red:40];
    JGCardTimes *actualTimings   = [calculator cardTimings];

    STAssertEqualObjects(actualTimings, expectedTimings, nil);
}

-(void)testGivenDurationBoundaryBelowFourMinutesTimesShouldBeIncrementsOfQuarter {
    [self setUpCalculatorStartingNowWithDuration:239];

    JGCardTimes *expectedTimings = [JGCardTimes cardTimesWithTimeIntervalSinceNowGreen:119.50 yellow:179.25 red:239.0];
    JGCardTimes *actualTimings   = [calculator cardTimings];

    STAssertEqualObjects(actualTimings, expectedTimings, nil);
}

//4 minutes-9.9 minutes
-(void)testGivenDurationBoundaryAtFourMinutesTimesShouldBeIncrementsOfOneMinute {
    [self setUpCalculatorStartingNowWithDuration:240];

    JGCardTimes *expectedTimings = [JGCardTimes cardTimesWithTimeIntervalSinceNowGreen:120 yellow:180 red:240];
    JGCardTimes *actualTimings   = [calculator cardTimings];

    STAssertEqualObjects(actualTimings, expectedTimings, nil);
}

-(void)testGivenDurationBoundaryBelowTenMinutesTimesShouldBeIncrementsOfOneMinute {
    [self setUpCalculatorStartingNowWithDuration:599];

    JGCardTimes *expectedTimings = [JGCardTimes cardTimesWithTimeIntervalSinceNowGreen:479 yellow:539 red:599];
    JGCardTimes *actualTimings   = [calculator cardTimings];

    STAssertEqualObjects(actualTimings, expectedTimings, nil);
}
// 10 minutes-29.9 minutes
-(void)testGivenDurationBoundaryAtTenMinutesTimesShouldBeIncrementsOfTwoMinutes {
    [self setUpCalculatorStartingNowWithDuration:600];

    JGCardTimes *expectedTimings = [JGCardTimes cardTimesWithTimeIntervalSinceNowGreen:360 yellow:480 red:600];
    JGCardTimes *actualTimings   = [calculator cardTimings];

    STAssertEqualObjects(actualTimings, expectedTimings, nil);
}

-(void)testGivenDurationBoundaryBelowThirtyMinutesTimesShouldBeIncrementsOfTwoMinutes {
    [self setUpCalculatorStartingNowWithDuration:1799];

    JGCardTimes *expectedTimings = [JGCardTimes cardTimesWithTimeIntervalSinceNowGreen:1559 yellow:1679 red:1799];
    JGCardTimes *actualTimings   = [calculator cardTimings];

    STAssertEqualObjects(actualTimings, expectedTimings, nil);
}

// 30 minutes+
-(void)testGivenDurationBoundaryAtThirtyMinutesTimesShouldBeIncrementsOfFiveMinutes {
    [self setUpCalculatorStartingNowWithDuration:1800];

    JGCardTimes *expectedTimings = [JGCardTimes cardTimesWithTimeIntervalSinceNowGreen:1200 yellow:1500 red:1800];
    JGCardTimes *actualTimings   = [calculator cardTimings];

    STAssertEqualObjects(actualTimings, expectedTimings, nil);
}

-(void)testGivenDurationBoundaryAboveThirtyMinutesTimesShouldBeIncrementsOfFiveMinutes {
    [self setUpCalculatorStartingNowWithDuration:3000];

    JGCardTimes *expectedTimings = [JGCardTimes cardTimesWithTimeIntervalSinceNowGreen:2400 yellow:2700 red:3000];
    JGCardTimes *actualTimings   = [calculator cardTimings];

    STAssertEqualObjects(actualTimings, expectedTimings, nil);
}

@end
