//
//  JGCountdownTimer.m
//  SpeechTimer
//
//  Created by John Gallagher on 03/01/2012.
//  Copyright 2012 Synaptic Mishap. All rights reserved.
//

#import "JGCountdownTimer.h"

@interface JGCountdownTimer ()

-(void)_initDelegate:(id <JGCountdownTimerDelegate>)delegate_;

-(NSTimeInterval)_timeRemaining;

-(void)_sendTimeRemainingToDelegate;


-(void)_timerDidCountDownByOneSecond:(NSTimer *)timer_;


@end

@implementation JGCountdownTimer

@synthesize timerEndDate;

+(JGCountdownTimer *)timerStartingNowWithTimeInterval:(NSTimeInterval)i delegate:(id)o {
    return [[[JGCountdownTimer alloc] initStartingAt:[NSDate date] withFireTime:[NSDate dateWithTimeIntervalSinceNow:i] delegate:o] autorelease];
}

+(JGCountdownTimer *)timerStartingAt:(NSDate *)startTime_ withFireTime:(NSDate *)fireTime_ delegate:(id <JGCountdownTimerDelegate>)delegate_ {
    return [[[JGCountdownTimer alloc] initStartingAt:startTime_ withFireTime:fireTime_ delegate:delegate_] autorelease];
}

-(JGCountdownTimer *)initStartingAt:(NSDate *)startTime_ withFireTime:(NSDate *)fireTime_ delegate:(id <JGCountdownTimerDelegate>)delegate_ {
    self = [super init];

    [self _initDelegate:delegate_];
    [self setTimerEndDate:fireTime_];

    return self;
}

-(void)startTimer {
    countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(_timerDidCountDownByOneSecond:) userInfo:nil repeats:YES];
    [self _sendTimeRemainingToDelegate];
}

-(void)stopTimer {
    [countdownTimer invalidate];
}

#pragma mark Private
-(void)_initDelegate:(id <JGCountdownTimerDelegate>)delegate_ {
    if (![delegate_ conformsToProtocol:@protocol(JGCountdownTimerDelegate)]) {
        _delegate = nil;
        return;
    }
    _delegate = delegate_;
}

-(NSTimeInterval)_timeRemaining {
    return round([[self timerEndDate] timeIntervalSinceNow]);
}

-(void)_sendTimeRemainingToDelegate {
    [_delegate timeRemainingDidChangeTo:[self _timeRemaining]];
}

-(void)_timerDidCountDownByOneSecond:(NSTimer *)timer_ {
    [self _sendTimeRemainingToDelegate];
}

#pragma mark Overrides
-(void)dealloc {
    [timerEndDate release];
    [super dealloc];
}


@end
