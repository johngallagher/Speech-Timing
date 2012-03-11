//
//  JGDurationFromFireTimeCalculatorTestCase.m
//  SpeechTimer
//
//  Created by John Gallagher on 01/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JGDurationFromFireDateCalculatorTestCase.h"
#import "JGDurationFromFireDateCalculator.h"

@implementation JGDurationFromFireTimeCalculatorTestCase

-(void)testGivenFireTimeOfNowDurationShouldBeZero {
    NSUInteger actualDuration   = [JGDurationFromFireTimeCalculator positiveDurationFromFireTime:[NSDate date]];
    NSUInteger expectedDuration = 0;
    STAssertEquals(actualDuration, expectedDuration, nil);
}

-(void)testGivenFireTimeOfOneSecondBeforeNowDurationShouldBeOne {
    NSUInteger actualDuration   = [JGDurationFromFireTimeCalculator positiveDurationFromFireTime:[NSDate dateWithTimeIntervalSinceNow:1]];
    NSUInteger expectedDuration = 1;
    STAssertEquals(actualDuration, expectedDuration, nil);
}

-(void)testGivenFireTimeOfOneSecondAfterNowDurationShouldBeZero {
    NSUInteger actualDuration   = [JGDurationFromFireTimeCalculator positiveDurationFromFireTime:[NSDate dateWithTimeIntervalSinceNow:-1]];
    NSUInteger expectedDuration = 0;
    STAssertEquals(actualDuration, expectedDuration, nil);
}

@end
