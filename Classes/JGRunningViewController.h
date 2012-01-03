//
//  JGRunningViewController.h
//  MeetingTimer
//
//  Created by John Gallagher on 17/12/2011.
//  Copyright 2011 Synaptic Mishap. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JGTimerControllerDelegate.h"

@interface JGRunningViewController : UIViewController <JGTimerControllerDelegate> {
//    IBOutlet UINavigationController *navigationController;
}

-(IBAction)stopTimer:(id)sender;



@end
