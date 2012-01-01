#import "JGTimerDurationCalculatorTestCase.h"
#import "JGTimerDurationCalculator.h"

@implementation JGTimerDurationCalculatorTestCase

-(void)testGivenDurationBelow3ShouldReturn0ForAllCards {
    JGTimerDurationCalculator *calculator = [JGTimerDurationCalculator calculatorWithDuration:2.9];

    STAssertEquals([calculator greenCardTime],  (NSTimeInterval)0, nil);
    STAssertEquals([calculator yellowCardTime], (NSTimeInterval)0, nil);
    STAssertEquals([calculator redCardTime],    (NSTimeInterval)0, nil);
}

-(void)testGivenDuration0ShouldReturn0ForAllCards {
    JGTimerDurationCalculator *calculator = [JGTimerDurationCalculator calculatorWithDuration:0];
    
    STAssertEquals([calculator greenCardTime],  (NSTimeInterval)0, nil);
    STAssertEquals([calculator yellowCardTime], (NSTimeInterval)0, nil);
    STAssertEquals([calculator redCardTime],    (NSTimeInterval)0, nil);
}

-(void)testGivenDuration3ShouldReturnIncrementsOf0Point75 {
    JGTimerDurationCalculator *calculator = [JGTimerDurationCalculator calculatorWithDuration:3];
    
    STAssertEquals([calculator greenCardTime],  (NSTimeInterval)1.5,    nil);
    STAssertEquals([calculator yellowCardTime], (NSTimeInterval)2.25,   nil);
    STAssertEquals([calculator redCardTime],    (NSTimeInterval)3,      nil);
}


@end
