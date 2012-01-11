//
//  JGCountdownTimer.m
//  SpeechTimer
//
//  Created by John Gallagher on 03/01/2012.
//  Copyright 2012 Synaptic Mishap. All rights reserved.
//

#import "JGCountdownTimer.h"

@implementation JGCountdownTimer

@synthesize timerEndDate;

-(void)initDelegate:(id <JGCountdownTimerDelegate>)delegate_ {
    if (![delegate_ conformsToProtocol:@protocol(JGCountdownTimerDelegate)]) {
        _delegate = nil;
        return;
    }
    _delegate = delegate_;
}

-(NSDate *)timerEndDateFromDuration:(NSUInteger)durationValue {
    return [NSDate dateWithTimeIntervalSinceNow:durationValue];
}

-(JGCountdownTimer *)initWithDurationValue:(NSUInteger)durationValue delegate:(id <JGCountdownTimerDelegate>)delegate_ {
    self = [super init];

    [self initDelegate:delegate_];
    [self setTimerEndDate:[self timerEndDateFromDuration:durationValue]];

    return self;
}

-(NSTimeInterval)timeRemaining {
    return round([[self timerEndDate] timeIntervalSinceNow]);
}

-(void)sendTimeRemainingToDelegate {
    [_delegate timeRemainingDidChangeTo:[self timeRemaining]];
}

+(JGCountdownTimer *)timerWithDurationValue:(NSUInteger)durationValue delegate:(id <JGCountdownTimerDelegate>)delegate_ {
    JGCountdownTimer *instance = [[[JGCountdownTimer alloc] initWithDurationValue:durationValue delegate:delegate_] autorelease];
    return instance;
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
