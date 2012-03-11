//
//  JGCountdownTimer.m
//  SpeechTimer
//
//  Created by John Gallagher on 03/01/2012.
//  Copyright 2012 Synaptic Mishap. All rights reserved.
//

#import "JGCountdownTimer.h"

@interface JGCountdownTimer ()

-(void)initDelegate:(id <JGCountdownTimerDelegate>)delegate_;

-(NSTimeInterval)timeRemaining;

-(void)sendTimeRemainingToDelegate;


-(void)timerDidCountDownByOneSecond:(NSTimer *)timer_;


@end

@implementation JGCountdownTimer

@synthesize timerEndDate = _timerEndDate;

+(JGCountdownTimer *)timerStartingNowWithTimeInterval:(NSTimeInterval)i delegate:(id)o {
    return [[[JGCountdownTimer alloc] initStartingAt:[NSDate date] withFireTime:[NSDate dateWithTimeIntervalSinceNow:i] delegate:o] autorelease];
}

+(JGCountdownTimer *)timerStartingAt:(NSDate *)startTime_ withFireTime:(NSDate *)fireTime_ delegate:(id <JGCountdownTimerDelegate>)delegate_ {
    return [[[JGCountdownTimer alloc] initStartingAt:startTime_ withFireTime:fireTime_ delegate:delegate_] autorelease];
}

-(JGCountdownTimer *)initStartingAt:(NSDate *)startTime_ withFireTime:(NSDate *)fireTime_ delegate:(id <JGCountdownTimerDelegate>)delegate_ {
    self = [super init];

    [self initDelegate:delegate_];
    [self setTimerEndDate:fireTime_];

    return self;
}

-(void)startTimer {
    _countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerDidCountDownByOneSecond:) userInfo:nil repeats:YES];
    [self sendTimeRemainingToDelegate];
}

-(void)stopTimer {
    [_countdownTimer invalidate];
}

#pragma mark Private
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

#pragma mark Overrides
-(void)dealloc {
    [_timerEndDate release];
    [super dealloc];
}


@end
