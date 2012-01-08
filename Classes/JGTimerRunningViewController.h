//
//  JGRunningViewController.h
//  MeetingTimer
//
//  Created by John Gallagher on 17/12/2011.
//  Copyright 2011 Synaptic Mishap. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "JGTimerControllerDelegate.h"
#import "JGCountdownTimerDelegate.h"

@interface JGTimerRunningViewController : UIViewController <JGTimerControllerDelegate, JGCountdownTimerDelegate> {
    IBOutlet UILabel *timeLabel;
    CFURLRef soundFileURLRef;
    
    SystemSoundID soundFileObject;
}

-(IBAction)stopTimer:(id)sender;

-(void)setTimeRemainingTo:(NSTimeInterval)time_;




@end
