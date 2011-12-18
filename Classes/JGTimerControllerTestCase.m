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
    JGTimerController *timer = [JGTimerController timerWithDurationValue:15 delegate:nil];
    STAssertEquals  ([timer durationValue], (NSUInteger)15, nil);
    [timer startTimer];
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    STAssertEquals  ([timer durationValue], (NSUInteger)14, nil);
}

-(void)testTimerShouldStopAtZero {
    JGTimerController *timer = [JGTimerController timerWithDurationValue:1 delegate:nil];
    STAssertEquals  ([timer durationValue], (NSUInteger)1, nil);
    
    [timer startTimer];
    
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:2]];
    STAssertEquals  ([timer durationValue], (NSUInteger)0, nil);
    STAssertFalse   ([timer timerIsRunning], nil);
}

@end
