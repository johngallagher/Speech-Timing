#import "JGTimerDurationCalculatorTestCase.h"
#import "JGTimerDurationCalculator.h"

@implementation JGTimerDurationCalculatorTestCase

-(void)testGivenDurationBelow3ShouldReturn0ForAllCards {
    JGTimerDurationCalculator *calculator = [JGTimerDurationCalculator calculatorWithDuration:2.9];

    STAssertEquals([calculator greenCardTime],  (NSUInteger)0, nil);
    STAssertEquals([calculator yellowCardTime], (NSUInteger)0, nil);
    STAssertEquals([calculator redCardTime],    (NSUInteger)0, nil);
}

-(void)testGivenDuration0ShouldReturn0ForAllCards {
    JGTimerDurationCalculator *calculator = [JGTimerDurationCalculator calculatorWithDuration:0];
    
    STAssertEquals([calculator greenCardTime],  (NSUInteger)0, nil);
    STAssertEquals([calculator yellowCardTime], (NSUInteger)0, nil);
    STAssertEquals([calculator redCardTime],    (NSUInteger)0, nil);
}

@end
