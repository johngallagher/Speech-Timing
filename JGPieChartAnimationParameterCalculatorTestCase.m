#import "JGPieChartAnimationParameterCalculatorTestCase.h"
#import "JGPieChartAnimationParameterCalculator.h"
#import "JGAlert.h"
#import "JGPieChartAnimationParameters.h"

#import <OCMock/OCMock.h>

@implementation JGPieChartAnimationParameterCalculatorTestCase

-(void)testGivenStartDateNowAndFireDate10SecondsAwayWhenCalculateParameterThenShouldGiveDuration10Seconds {

    JGAlert                                *alert      = [JGAlert alertStartingNowWithDuration:10 name:@""];
    JGPieChartAnimationParameterCalculator *calculator = [[JGPieChartAnimationParameterCalculator alloc] initWithAlert:alert];
    JGPieChartAnimationParameters          *parameters = [calculator calculateParameters];

    STAssertEquals([parameters fromAngle], (CGFloat)-90.0, nil);
    STAssertEquals([parameters toAngle], (CGFloat)270, nil);
    STAssertEquals([parameters duration], (NSTimeInterval)10, nil);
    [calculator release];
}

@end

