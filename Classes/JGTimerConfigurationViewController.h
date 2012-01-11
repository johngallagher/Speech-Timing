//
//  RootViewController.h
//  SpeechTimer
//
//  Created by John Gallagher on 17/12/2011.
//  Copyright 2011 Synaptic Mishap. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "JGRingingSettingDelegate.h"

@class JGTimerController;
@class JGCountdownTimer;

@interface JGTimerConfigurationViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, JGRingingSettingDelegate> {
    IBOutlet UIPickerView *timerDurationPickerView;
    IBOutlet UITableView  *currentAlertTableView;

    NSArray               *pickerDurations;
    JGTimerController     *timerController;
    JGCountdownTimer      *countdownTimer;
    NSString              *currentAlertName;

@private
    NSManagedObjectContext *managedObjectContext_;
}

@property(nonatomic, retain) JGCountdownTimer       *countdownTimer;
@property(nonatomic, retain) JGTimerController      *timerController;
@property(nonatomic, retain) NSArray                *pickerDurations;
@property(nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property(nonatomic, retain) NSString               *currentAlertName;


-(IBAction)startTimer:(id)sender;


@end



