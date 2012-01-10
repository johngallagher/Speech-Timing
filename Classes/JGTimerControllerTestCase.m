//
//  JGTimerControllerTestCase.m
//  MeetingTimer
//
//  Created by John Gallagher on 18/12/2011.
//  Copyright 2011 Synaptic Mishap. All rights reserved.
//

#import "JGTimerControllerTestCase.h"
#import "JGTimerController.h"
//#import <OCMock/OCMock.h>
#import "JGTimerControllerDelegate.h"
#import "OCMockObject.h"
#import "OCMArg.h"

@implementation JGTimerControllerTestCase

-(void)testGivenThreeSecondDurationAtHalfDurationShouldNotCallAnyCard {
    id mockDelegate = [OCMockObject mockForProtocol:@protocol(JGTimerControllerDelegate)];

    JGTimerController *timer = [JGTimerController timerWithDurationValue:3 delegate:mockDelegate];
    [timer startTimer];

    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.49]];
    [timer stopTimer];
    [mockDelegate verify];
}

-(void)testGivenThreeSecondDurationAfterHalfDurationShouldHaveCalledGreenCard {
    id mockDelegate = [OCMockObject mockForProtocol:@protocol(JGTimerControllerDelegate)];
    [[mockDelegate expect] showGreenCard];

    JGTimerController *timer = [JGTimerController timerWithDurationValue:3 delegate:mockDelegate];
    [timer startTimer];

    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.51]];
    [timer stopTimer];
    [mockDelegate verify];
}

-(void)testGivenThreeSecondDurationAfterThreeQuartersOfDurationShouldHaveCalledGreenThenYellowCard {
    id mockDelegate = [OCMockObject mockForProtocol:@protocol(JGTimerControllerDelegate)];
    [[mockDelegate expect] showGreenCard];
    [[mockDelegate expect] showYellowCard];

    JGTimerController *timer = [JGTimerController timerWithDurationValue:3 delegate:mockDelegate];
    [timer startTimer];

    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:2.26]];
    [timer stopTimer];
    [mockDelegate verify];
}

-(void)testGivenThreeSecondDurationAfterThreeSecondShouldHaveCalledGreenThenYellowThenRedCard {
    id mockDelegate = [OCMockObject mockForProtocol:@protocol(JGTimerControllerDelegate)];
    [[mockDelegate expect] showGreenCard];
    [[mockDelegate expect] showYellowCard];
    [[mockDelegate expect] showRedCard];

    JGTimerController *timer = [JGTimerController timerWithDurationValue:3 delegate:mockDelegate];
    [timer startTimer];

    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:3.1]];
    [timer stopTimer];

    [mockDelegate verify];
}

// We have no expectations - we know we've checked for confirmity with protocol if this doesn't crash.
-(void)testIfDelegateDoesntRespondToProtocolShouldNotCrash {
    id mockDelegate = [OCMockObject mockForClass:[NSString class]];
    [[mockDelegate expect] conformsToProtocol:[OCMArg any]];

    JGTimerController *timer = [JGTimerController timerWithDurationValue:1 delegate:mockDelegate];
    [timer startTimer];

    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.1]];
    [mockDelegate verify];
}

-(void)testGivenZeroDurationShouldImmediatelyCallshowRedCard {
    id mockDelegate = [OCMockObject mockForProtocol:@protocol(JGTimerControllerDelegate)];
    [[mockDelegate expect] showRedCard];

    JGTimerController *timer = [JGTimerController timerWithDurationValue:0 delegate:mockDelegate];
    [timer startTimer];

    [mockDelegate verify];
}

@end
