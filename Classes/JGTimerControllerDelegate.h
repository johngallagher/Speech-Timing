//
//  JGTimerControllerDelegate.h
//  SpeechTimer
//
//  Created by John Gallagher on 18/12/2011.
//  Copyright 2011 Synaptic Mishap. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol JGTimerControllerDelegate <NSObject>

-(void)showGreenCard;

-(void)showYellowCard;

-(void)showRedCard;

@end
