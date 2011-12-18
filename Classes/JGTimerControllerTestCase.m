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

-(void)testTimerShouldStopAtZero {
    [[JGTimerController sharedInstance] setDurationValue:1];
    STAssertEquals  ([[JGTimerController sharedInstance] durationValue], (NSUInteger)1, nil);
    
    [[JGTimerController sharedInstance] startTimer];
    
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:2]];
    STAssertEquals  ([[JGTimerController sharedInstance] durationValue], (NSUInteger)0, nil);
    STAssertFalse   ([[JGTimerController sharedInstance] timerIsRunning], nil);
}

@end
