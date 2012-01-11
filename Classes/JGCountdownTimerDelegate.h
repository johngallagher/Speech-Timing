//
//  JGCountdownTimerDelegate.h
//  SpeechTimer
//
//  Created by John Gallagher on 03/01/2012.
//  Copyright 2012 Synaptic Mishap. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol JGCountdownTimerDelegate <NSObject>

-(void)timeRemainingDidChangeTo:(NSTimeInterval)time_;


@end
