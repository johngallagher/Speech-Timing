#import "JGTimerDurationCalculatorTestCase.h"
#import "JGCardTimesCalculator.h"

@implementation JGTimerDurationCalculatorTestCase

-(void)setUpCalculatorStartingNowWithDuration:(NSUInteger)duration {
    calculator = [JGCardTimesCalculator calculatorWithStartTime:[NSDate date] andFireTime:[NSDate dateWithTimeIntervalSinceNow:duration]];
}

-(void)setUpCalculatorStartedAt:(NSDate *)startTime withDuration:(NSUInteger)duration {
    calculator = [JGCardTimesCalculator calculatorWithStartTime:startTime andFireTime:[startTime dateByAddingTimeInterval:duration]];
}

// 0 minutes
-(void)testGivenDurationBelow3ShouldReturn0ForAllCards {
    [self setUpCalculatorStartingNowWithDuration:0];
    calculator = [JGCardTimesCalculator calculatorWithStartTime:0 andFireTime:[NSDate date]];

    STAssertEquals([calculator greenCardTime], (NSTimeInterval) 0, nil);
    STAssertEquals([calculator yellowCardTime], (NSTimeInterval) 0, nil);
    STAssertEquals([calculator redCardTime], (NSTimeInterval) 0, nil);
}

-(void)testGivenDuration0ShouldReturn0ForAllCards {
    JGCardTimesCalculator *calculator = [JGCardTimesCalculator calculatorWithStartTime:[NSDate date] andFireTime:[NSDate date]];

    STAssertEquals([calculator greenCardTime], (NSTimeInterval) 0, nil);
    STAssertEquals([calculator yellowCardTime], (NSTimeInterval) 0, nil);
    STAssertEquals([calculator redCardTime], (NSTimeInterval) 0, nil);
}

//Up to 4 minutes
-(void)testGivenDurationInRangeBelow4MinutesTimesShouldBeIncrementsOfQuarter {
    [self setUpCalculatorStartingNowWithDuration:3];

    STAssertEquals([calculator greenCardTime], (NSTimeInterval) 1.5, nil);
    STAssertEquals([calculator yellowCardTime], (NSTimeInterval) 2.25, nil);
    STAssertEquals([calculator redCardTime], (NSTimeInterval) 3, nil);
}

-(void)testGivenDurationBoundaryBelowFourMinutesTimesShouldBeIncrementsOfQuarter {
    [self setUpCalculatorStartingNowWithDuration:239];

    STAssertEquals([calculator greenCardTime], (NSTimeInterval) 119.50, nil);
    STAssertEquals([calculator yellowCardTime], (NSTimeInterval) 179.25, nil);
    STAssertEquals([calculator redCardTime], (NSTimeInterval) 239.00, nil);
}

//4 minutes-9.9 minutes
-(void)testGivenDurationBoundaryAtFourMinutesTimesShouldBeIncrementsOfOneMinute {
    [self setUpCalculatorStartingNowWithDuration:240];

    STAssertEquals([calculator greenCardTime], (NSTimeInterval) 120.00, nil);
    STAssertEquals([calculator yellowCardTime], (NSTimeInterval) 180.00, nil);
    STAssertEquals([calculator redCardTime], (NSTimeInterval) 240.00, nil);
}

-(void)testGivenDurationBoundaryBelowTenMinutesTimesShouldBeIncrementsOfOneMinute {
    [self setUpCalculatorStartingNowWithDuration:599];

    STAssertEquals([calculator greenCardTime], (NSTimeInterval) 479.00, nil);
    STAssertEquals([calculator yellowCardTime], (NSTimeInterval) 539.00, nil);
    STAssertEquals([calculator redCardTime], (NSTimeInterval) 599.00, nil);
}
// 10 minutes-29.9 minutes
-(void)testGivenDurationBoundaryAtTenMinutesTimesShouldBeIncrementsOfTwoMinutes {
    [self setUpCalculatorStartingNowWithDuration:600];

    STAssertEquals([calculator greenCardTime], (NSTimeInterval) 360.00, nil);
    STAssertEquals([calculator yellowCardTime], (NSTimeInterval) 480.00, nil);
    STAssertEquals([calculator redCardTime], (NSTimeInterval) 600.00, nil);
}

-(void)testGivenDurationBoundaryBelowThirtyMinutesTimesShouldBeIncrementsOfTwoMinutes {
    [self setUpCalculatorStartingNowWithDuration:1799];

    STAssertEquals([calculator greenCardTime], (NSTimeInterval) 1559.00, nil);
    STAssertEquals([calculator yellowCardTime], (NSTimeInterval) 1679.00, nil);
    STAssertEquals([calculator redCardTime], (NSTimeInterval) 1799.00, nil);
}

// 30 minutes+
-(void)testGivenDurationBoundaryAtThirtyMinutesTimesShouldBeIncrementsOfFiveMinutes {
    [self setUpCalculatorStartingNowWithDuration:1800];

    STAssertEquals([calculator greenCardTime], (NSTimeInterval) 1200.00, nil);
    STAssertEquals([calculator yellowCardTime], (NSTimeInterval) 1500.00, nil);
    STAssertEquals([calculator redCardTime], (NSTimeInterval) 1800.00, nil);
}

-(void)testGivenDurationBoundaryAboveThirtyMinutesTimesShouldBeIncrementsOfFiveMinutes {
    [self setUpCalculatorStartingNowWithDuration:3000];

    STAssertEquals([calculator greenCardTime], (NSTimeInterval) 2400.00, nil);
    STAssertEquals([calculator yellowCardTime], (NSTimeInterval) 2700.00, nil);
    STAssertEquals([calculator redCardTime], (NSTimeInterval) 3000.00, nil);
}

@end
