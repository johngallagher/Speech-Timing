//
//  JGTimerControllerTestCase.m
//  SpeechTimer
//
//  Created by John Gallagher on 18/12/2011.
//  Copyright 2011 Synaptic Mishap. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "JGTimerControllerTestCase.h"
#import "JGTimerController.h"
#import "JGTimerControllerDelegate.h"
#import "OCObserverMockObject.h"

@interface JGTimerControllerTestCase ()
-(void)pauseForTimeInterval:(NSTimeInterval)timeInterval_;

-(void)startTimerWithTimeInterval:(NSTimeInterval)timeInterval_;

-(void)startTimerWithStartTimeIntervalBeforeNow:(NSTimeInterval)beforeNow_ andDuration:(NSTimeInterval)duration_;

-(void)stopTimerAfterTimeInterval:(NSTimeInterval)timeInterval_;

@end

@implementation JGTimerControllerTestCase

@synthesize mockDelegate;

-(void)setUp {
    [super setUp];
    [self setMockDelegate:[OCMockObject mockForProtocol:@protocol(JGTimerControllerDelegate)]];
}
// TODO make all durations time intervals. And rename as such so startTimerWithDuration:(nstimeinterval)duration_
-(void)startTimerWithTimeInterval:(NSTimeInterval)timeInterval_ {
    timer = [JGTimerController timerStartingNowWithTimeInterval:timeInterval_ delegate:mockDelegate];
    [timer startTimer];
}

-(void)startTimerWithStartTimeIntervalBeforeNow:(NSTimeInterval)beforeNow_ andDuration:(NSTimeInterval)duration_ {
    timer = [JGTimerController timerStartingAt:[[NSDate date] dateByAddingTimeInterval:(0 - beforeNow_)]
                                  withFireDate:[[NSDate date] dateByAddingTimeInterval:(duration_ - beforeNow_)]
                                      delegate:mockDelegate];
    [timer startTimer];
}

-(void)stopTimerAfterTimeInterval:(NSTimeInterval)timeInterval_ {
    [self pauseForTimeInterval:timeInterval_];
    [timer stopTimer];
}

-(void)pauseForTimeInterval:(NSTimeInterval)timeInterval_ {
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:timeInterval_]];
}

-(void)tearDown {
    [super tearDown];
    [timer stopTimer];
}

#pragma mark Tests
#pragma mark Duration Methods
-(void)testGivenThreeSecondDurationAtHalfDurationShouldNotCallAnyCard {
    [self startTimerWithTimeInterval:3];
    [self stopTimerAfterTimeInterval:1.49];

    [mockDelegate verify];
}

-(void)testGivenThreeSecondDurationAfterHalfDurationShouldHaveCalledGreenCard {
    [[mockDelegate expect] showGreenCard];
    
    [self startTimerWithTimeInterval:3.0];
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

-(void)testGivenInvalidTimeIntervalShouldDoNothing {
    [self startTimerWithTimeInterval:-2];
    STAssertNil(timer, nil);
    [mockDelegate verify];
}

-(void)testGivenStartTimeInPastBeforeGreenCardShouldCallAllThreeCards {
    [[mockDelegate expect] showGreenCard];
    [[mockDelegate expect] showYellowCard];
    [[mockDelegate expect] showRedCard];

    [self startTimerWithStartTimeIntervalBeforeNow:1 andDuration:3];
    [self stopTimerAfterTimeInterval:2.1];

    [mockDelegate verify];
}

-(void)testGivenStartTimeInPastAfterGreenCardShouldImmediatelyCallGreenCard {
    [[mockDelegate expect] showGreenCard];

    [self startTimerWithStartTimeIntervalBeforeNow:2 andDuration:3];
    
    [mockDelegate verify];
}

-(void)dealloc {
    [timer release];
    [mockDelegate release];
    [super dealloc];
}
@end
