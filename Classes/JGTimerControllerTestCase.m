//
//  JGTimerControllerTestCase.m
//  MeetingTimer
//
//  Created by John Gallagher on 18/12/2011.
//  Copyright 2011 Synaptic Mishap. All rights reserved.
//

#import "JGTimerControllerTestCase.h"
#import "JGTimerController.h"

@implementation JGTimerControllerTestCase


-(void)testTimerShouldBeOneSecondDownAfterOneSecond {
    [[JGTimerController sharedInstance] setDurationValue:15];
    STAssertEquals  ([[JGTimerController sharedInstance] durationValue], (NSUInteger)15, nil);
    [[JGTimerController sharedInstance] startTimer];
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    STAssertEquals  ([[JGTimerController sharedInstance] durationValue], (NSUInteger)14, nil);
}


@end
