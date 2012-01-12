//
//  JGCountdownTimer.m
//  SpeechTimer
//
//  Created by John Gallagher on 03/01/2012.
//  Copyright 2012 Synaptic Mishap. All rights reserved.
//

#import "JGCountdownTimer.h"

@interface JGCountdownTimer ()
-(JGCountdownTimer *)initStartingAt:(NSDate *)startTime_ withFireDate:(NSDate *)fireDate_ delegate:(id <JGCountdownTimerDelegate>)delegate_;

-(void)initDelegate:(id <JGCountdownTimerDelegate>)delegate_;


@end

@implementation JGCountdownTimer

@synthesize timerEndDate;

+(JGCountdownTimer *)timerStartingAt:(NSDate *)startTime_ withFireDate:(NSDate *)fireDate_ delegate:(id <JGCountdownTimerDelegate>)delegate_ {
    return [[[JGCountdownTimer alloc] initStartingAt:startTime_ withFireDate:fireDate_ delegate:delegate_] autorelease];
}

-(JGCountdownTimer *)initStartingAt:(NSDate *)startTime_ withFireDate:(NSDate *)fireDate_ delegate:(id <JGCountdownTimerDelegate>)delegate_ {
    self = [super init];

    [self initDelegate:delegate_];
    [self setTimerEndDate:fireDate_];

    return self;
}

-(void)initDelegate:(id <JGCountdownTimerDelegate>)delegate_ {
    if (![delegate_ conformsToProtocol:@protocol(JGCountdownTimerDelegate)]) {
        _delegate = nil;
        return;
    }
    _delegate = delegate_;
}

-(NSTimeInterval)timeRemaining {
    return round([[self timerEndDate] timeIntervalSinceNow]);
}

-(void)sendTimeRemainingToDelegate {
    [_delegate timeRemainingDidChangeTo:[self timeRemaining]];
}

-(void)timerDidCountDownByOneSecond:(NSTimer *)timer_ {
    [self sendTimeRemainingToDelegate];
}

-(void)dealloc {
    [timerEndDate release];
    [super dealloc];
}

-(void)startTimer {
    countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerDidCountDownByOneSecond:) userInfo:nil repeats:YES];
    [self sendTimeRemainingToDelegate];
}

-(void)stopTimer {
    [countdownTimer invalidate];
}

@end
