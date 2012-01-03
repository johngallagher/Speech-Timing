//
//  RootViewController.h
//  MeetingTimer
//
//  Created by John Gallagher on 17/12/2011.
//  Copyright 2011 Synaptic Mishap. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class JGTimerController;

@interface JGTimerConfigurationViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate> {
    IBOutlet    UIPickerView *timerDurationPickerView;
    NSArray     *pickerDurations;
    JGTimerController *timerController;
@private
    NSManagedObjectContext *managedObjectContext_;
}

@property (nonatomic, retain) JGTimerController *timerController;
@property (nonatomic, retain) NSArray *pickerDurations;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

-(IBAction)startTimer:(id)sender;



@end


