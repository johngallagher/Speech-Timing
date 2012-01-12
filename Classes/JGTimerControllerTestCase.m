//
//  JGTimerControllerTestCase.m
//  SpeechTimer
//
//  Created by John Gallagher on 18/12/2011.
//  Copyright 2011 Synaptic Mishap. All rights reserved.
//

#import "JGTimerControllerTestCase.h"
#import "JGTimerController.h"
#import "JGTimerControllerDelegate.h"

@interface JGTimerControllerTestCase ()
-(void)pauseForTimeInterval:(NSTimeInterval)timeInterval_;

-(void)startTimerWithTimeInterval:(NSTimeInterval)timeInterval_;

-(void)stopTimerAfterTimeInterval:(NSTimeInterval)timeInterval_;

@end

@implementation JGTimerControllerTestCase

-(void)setUp {
    mockDelegate = [OCMockObject mockForProtocol:@protocol(JGTimerControllerDelegate)];
}

-(void)startTimerWithTimeInterval:(NSTimeInterval)timeInterval_ {
    timer = [JGTimerController timerStartingNowWithTimeInterval:timeInterval_ delegate:mockDelegate];
    [timer startTimer];
}

-(void)stopTimerAfterTimeInterval:(NSTimeInterval)timeInterval_ {
    [self pauseForTimeInterval:timeInterval_];
    [timer stopTimer];
}

-(void)pauseForTimeInterval:(NSTimeInterval)timeInterval_ {
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:timeInterval_]];
}

#pragma mark Duration Methods
-(void)testGivenThreeSecondDurationAtHalfDurationShouldNotCallAnyCard {
    [self startTimerWithTimeInterval:3];
    [self stopTimerAfterTimeInterval:1.49];

    [mockDelegate verify];
}

-(void)testGivenThreeSecondDurationAfterHalfDurationShouldHaveCalledGreenCard {
    [[mockDelegate expect] showGreenCard];
    
    [self startTimerWithTimeInterval:3];
    [self stopTimerAfterTimeInterval:1.51];

    [mockDelegate verify];
}

-(void)testGivenThreeSecondDurationAfterThreeQuartersOfDurationShouldHaveCalledGreenThenYellowCard {
    [[mockDelegate expect] showGreenCard];
    [[mockDelegate expect] showYellowCard];

    [self startTimerWithTimeInterval:3];
    [self stopTimerAfterTimeInterval:2.26];

    [mockDelegate verify];
}

-(void)testGivenThreeSecondDurationAfterThreeSecondShouldHaveCalledGreenThenYellowThenRedCard {
    [[mockDelegate expect] showGreenCard];
    [[mockDelegate expect] showYellowCard];
    [[mockDelegate expect] showRedCard];

    [self startTimerWithTimeInterval:3];
    [self stopTimerAfterTimeInterval:3.1];

    [mockDelegate verify];
}

// We have no expectations - we know we've checked for confirmity with protocol if this doesn't crash.
-(void)testIfDelegateDoesntRespondToProtocolShouldNotCrash {
    mockDelegate = [OCMockObject mockForClass:[NSString class]];
    [[mockDelegate expect] conformsToProtocol:[OCMArg any]];

    [self startTimerWithTimeInterval:1];
    [self pauseForTimeInterval:1.1];

    [mockDelegate verify];
}

-(void)testGivenZeroDurationShouldImmediatelyCallshowRedCard {
    [[mockDelegate expect] showRedCard];

    [self startTimerWithTimeInterval:0];

    [mockDelegate verify];
}

//-(void)testGivenFireDateInThePastShouldShowRedCard {
//    [[mockDelegate expect] showRedCard];
//    [self startTimerWithTimeInterval:-2];
//    [mockDelegate verify];
//}

@end
