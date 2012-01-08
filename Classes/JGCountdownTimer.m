//
//  JGCountdownTimer.m
//  MeetingTimer
//
//  Created by John Gallagher on 03/01/2012.
//  Copyright 2012 Synaptic Mishap. All rights reserved.
//

#import "JGCountdownTimer.h"

@implementation JGCountdownTimer

-(void)initDelegate:(id <JGCountdownTimerDelegate>)delegate_ {
    if (![delegate_ conformsToProtocol:@protocol(JGCountdownTimerDelegate)]) {
        _delegate = nil;
        return;
    } 
    _delegate = delegate_;
}

-(JGCountdownTimer *)initWithDurationValue:(NSUInteger)durationValue delegate:(id <JGCountdownTimerDelegate>)delegate_ {
    self = [super init];
    
    [self initDelegate:delegate_];
    timeRemaining = (NSTimeInterval)durationValue;
    
    return self;
}

-(void)sendTimeRemainingToDelegate {
    [_delegate timeRemainingDidChangeTo:timeRemaining];
}

+(JGCountdownTimer *)timerWithDurationValue:(NSUInteger)durationValue delegate:(id <JGCountdownTimerDelegate>)delegate_ {
    JGCountdownTimer *instance = [[[JGCountdownTimer alloc] initWithDurationValue:durationValue delegate:delegate_] autorelease];
    return instance;
}

-(void)startTimer {
    countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerDidCountDownByOneSecond:) userInfo:nil repeats:YES];
    [self sendTimeRemainingToDelegate];
}

-(void)stopTimer {
    [countdownTimer invalidate];
}


-(void)timerDidCountDownByOneSecond:(NSTimer *)timer_ {
    timeRemaining--; // Countdown
    [self sendTimeRemainingToDelegate];
}


@end
