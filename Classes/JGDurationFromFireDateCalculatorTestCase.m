//
//  JGDurationFromFireDateCalculatorTestCase.m
//  SpeechTimer
//
//  Created by John Gallagher on 01/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JGDurationFromFireDateCalculatorTestCase.h"
#import "JGDurationFromFireDateCalculator.h"

#import <UIKit/UIKit.h>

@implementation JGDurationFromFireDateCalculatorTestCase

-(void)testGivenFireDateOfNowDurationShouldBeZero {
    NSUInteger actualDuration = [JGDurationFromFireDateCalculator positiveDurationFromFireDate:[NSDate date]];
    NSUInteger expectedDuration = 0;
    STAssertEquals(actualDuration, expectedDuration, nil);
}

-(void)testGivenFireDateOfOneSecondBeforeNowDurationShouldBeOne {
    NSUInteger actualDuration = [JGDurationFromFireDateCalculator positiveDurationFromFireDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    NSUInteger expectedDuration = 1;
    STAssertEquals(actualDuration, expectedDuration, nil);
}

-(void)testGivenFireDateOfOneSecondAfterNowDurationShouldBeZero {
    NSUInteger actualDuration = [JGDurationFromFireDateCalculator positiveDurationFromFireDate:[NSDate dateWithTimeIntervalSinceNow:-1]];
    NSUInteger expectedDuration = 0;
    STAssertEquals(actualDuration, expectedDuration, nil);
}

@end
