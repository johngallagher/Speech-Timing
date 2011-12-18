//
//  JGTimerControllerTestCase.m
//  MeetingTimer
//
//  Created by John Gallagher on 18/12/2011.
//  Copyright 2011 Synaptic Mishap. All rights reserved.
//

#import "JGTimerControllerTestCase.h"
#import "JGTimerController.h"
#import <OCMock/OCMock.h>
#import "JGTimerControllerDelegate.h"

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

-(void)testWhenTimerStopsShouldCallDelegate {
    id mockDelegate = [OCMockObject mockForProtocol:@protocol(JGTimerControllerDelegate)];
    [[mockDelegate expect] timerDidStop];
    
    JGTimerController *timer = [JGTimerController timerWithDurationValue:1 delegate:mockDelegate];
    [timer startTimer];
    
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:2]];

    [mockDelegate verify];
}

-(void)testIfDelegateDoesntRespondToProtocolShouldNotCrash {
    BOOL _no = NO;
    id mockDelegate = [OCMockObject mockForClass:[NSObject class]];
    [[[mockDelegate expect] andReturnValue:OCMOCK_VALUE(_no)] conformsToProtocol:@protocol(JGTimerControllerDelegate)];
     
    JGTimerController *timer = [JGTimerController timerWithDurationValue:1 delegate:mockDelegate];
    [timer startTimer];
    
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:2]];
    
    [mockDelegate verify];
    [mockDelegate release];
    mockDelegate = nil;
}

-(void)testIfDelegateDoesRespondToProtocolTimerDidStopShouldBeCalled {
    BOOL _yes = YES;
    id mockDelegate = [OCMockObject mockForProtocol:@protocol(JGTimerControllerDelegate)];
    [[[mockDelegate expect] andReturnValue:OCMOCK_VALUE(_yes)] conformsToProtocol:@protocol(JGTimerControllerDelegate)];
    [[mockDelegate expect] timerDidStop];
    
    JGTimerController *timer = [JGTimerController timerWithDurationValue:1 delegate:mockDelegate];
    [timer startTimer];

    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:2]];
    
    [mockDelegate verify];
}

@end
