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

-(void)setUp {
    [super setUp];
}

-(void)tearDown {
    [super tearDown];
}

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

-(void)testGivenThreeSecondDurationAtOneSecondDelegateShouldBeToldToShowGreenCard {
    id mockDelegate = [OCMockObject mockForProtocol:@protocol(JGTimerControllerDelegate)];
    [[mockDelegate expect] showGreenCard];
    
    JGTimerController *timer = [JGTimerController timerWithDurationValue:3 delegate:mockDelegate];
    [timer startTimer];
    
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.1]];
    
    [mockDelegate verify];
}



-(void)testWhenTimerStopsShouldCallDelegate {
    id mockDelegate = [OCMockObject mockForProtocol:@protocol(JGTimerControllerDelegate)];
    [[mockDelegate expect] showRedCard];
    
    JGTimerController *timer = [JGTimerController timerWithDurationValue:1 delegate:mockDelegate];
    [timer startTimer];
    
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:2]];

    [mockDelegate verify];
}

// We have no expectations - we know we've checked for confirmity with protocol if this doesn't crash.
-(void)testIfDelegateDoesntRespondToProtocolShouldNotCrash {
    id mockDelegate = [[NSObject alloc] init];
    JGTimerController *timer = [JGTimerController timerWithDurationValue:1 delegate:mockDelegate];
    [timer startTimer];
    
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:2]];
    
    [timer release];
    
}

-(void)testGivenDelegateRespondsToProtocolShouldCallshowRedCardOnStop {
    id mockDelegate = [OCMockObject mockForProtocol:@protocol(JGTimerControllerDelegate)];
    [[mockDelegate expect] showRedCard];
    
    JGTimerController *timer = [JGTimerController timerWithDurationValue:1 delegate:mockDelegate];
    [timer startTimer];
    
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:2]];
    
    [mockDelegate verify];
}

-(void)testGivenZeroDurationShouldImmediatelyCallshowRedCard {
    id mockDelegate = [OCMockObject mockForProtocol:@protocol(JGTimerControllerDelegate)];
    [[mockDelegate expect] showRedCard];
    
    JGTimerController *timer = [JGTimerController timerWithDurationValue:0 delegate:mockDelegate];
    [timer startTimer];
    
    [mockDelegate verify];
    STAssertNil ([timer valueForKey:@"timer"], nil); // Ensure the timer wasn't started
}


@end
