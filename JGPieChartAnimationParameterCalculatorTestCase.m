#import "JGPieChartAnimationParameterCalculatorTestCase.h"
#import "JGPieChartAnimationParameterCalculator.h"
#import "JGAlert.h"
#import "JGPieChartAnimationParameters.h"

@implementation JGPieChartAnimationParameterCalculatorTestCase


-(void)testGivenStartDateNowAndFireDate10SecondsAwayWhenCalculateParameterThenShouldGiveDuration10Seconds {
    CGFloat        expectedFromAngle = -90;
    CGFloat        expectedToAngle   = 270;
    NSTimeInterval expectedDuration  = 10;

    JGAlert                                *alert      = [JGAlert alertStartingNowWithDuration:10 name:@""];
    JGPieChartAnimationParameterCalculator *calculator = [[JGPieChartAnimationParameterCalculator alloc] initWithAlert:alert];
    JGPieChartAnimationParameters          *parameters = [calculator calculateParameters];

    STAssertEqualsWithAccuracy([parameters fromAngle], (CGFloat)expectedFromAngle, 0.01, nil);
    STAssertEqualsWithAccuracy([parameters toAngle], (CGFloat)expectedToAngle, 0.01, nil);
    STAssertEqualsWithAccuracy([parameters duration], (NSTimeInterval)expectedDuration, 0.01, nil);

    [calculator release];
}

-(void)testGivenStartDate5SecondsAgoAndFireDate5SecondsAwayWhenCalculateParameterThenPieChartShouldStartHalfwayRound {
    CGFloat        expectedFromAngle = 90;
    CGFloat        expectedToAngle   = 270;
    NSTimeInterval expectedDuration  = 5;

    JGAlert                                *alert      = [JGAlert alertWithStartTime:[NSDate dateWithTimeIntervalSinceNow:-5]
                                                                            fireTime:[NSDate dateWithTimeIntervalSinceNow:5]
                                                                                name:@""];
    JGPieChartAnimationParameterCalculator *calculator = [[JGPieChartAnimationParameterCalculator alloc] initWithAlert:alert];
    JGPieChartAnimationParameters          *parameters = [calculator calculateParameters];

    STAssertEqualsWithAccuracy([parameters fromAngle], (CGFloat)expectedFromAngle, 0.01, nil);
    STAssertEqualsWithAccuracy([parameters toAngle], (CGFloat)expectedToAngle, 0.01, nil);
    STAssertEqualsWithAccuracy([parameters duration], (NSTimeInterval)expectedDuration, 0.01, nil);

    [calculator release];
}
-(void)testGivenFireTimeInThePastCalculateParameterShouldReturnNilSoNoAnimationAppears {
    JGAlert                                *alert      = [JGAlert alertWithStartTime:[NSDate dateWithTimeIntervalSinceNow:-15]
                                                                            fireTime:[NSDate dateWithTimeIntervalSinceNow:-5]
                                                                                name:@""];
    JGPieChartAnimationParameterCalculator *calculator = [[JGPieChartAnimationParameterCalculator alloc] initWithAlert:alert];
    JGPieChartAnimationParameters          *parameters = [calculator calculateParameters];

    STAssertNil(parameters, nil);

    [calculator release];
}


@end

