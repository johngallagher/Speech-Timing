//
//  RootViewController.m
//  MeetingTimer
//
//  Created by John Gallagher on 17/12/2011.
//  Copyright 2011 Synaptic Mishap. All rights reserved.
//

#import "JGTimerConfigurationViewController.h"
#import "JGTimerRunningViewController.h"
#import "JGTimerController.h"
#import "JGCountdownTimer.h"
#import "JGDrawingTestView.h"
#import "JGModalAlertViewController.h"

@implementation JGTimerConfigurationViewController

@synthesize countdownTimer;
@synthesize timerController;
@synthesize pickerDurations;
@synthesize managedObjectContext = managedObjectContext_;
@synthesize currentAlertName;

-(NSString *)currentAlertFilename {
    return [[self currentAlertName] stringByReplacingOccurrencesOfString:@" " withString:@""];
}

-(IBAction)startTimer:(id)sender {
    NSInteger selectedRow = [timerDurationPickerView selectedRowInComponent:0];
    if (selectedRow < 0)
        return;

    NSUInteger durationOfTimer = (NSUInteger) ([[pickerDurations objectAtIndex:(NSUInteger) selectedRow] intValue] *
                                               60);

    JGTimerRunningViewController *runningViewController = [[JGTimerRunningViewController alloc] initWithNibName:@"JGTimerRunningViewController" bundle:nil];
    if ([[runningViewController view] isKindOfClass:[JGDrawingTestView class]]) {
        [(JGDrawingTestView *) [runningViewController view] setAnimationDuration:durationOfTimer];
    }
    [runningViewController loadAlertSoundWithFilename:[self currentAlertFilename]];
    [[self navigationController] pushViewController:runningViewController animated:YES];

    [self setTimerController:[JGTimerController timerWithDurationValue:durationOfTimer delegate:runningViewController]];
    [[self timerController] startTimer];

    [self setCountdownTimer:[JGCountdownTimer timerWithDurationValue:durationOfTimer delegate:runningViewController]];
    [[self countdownTimer] startTimer];

    [runningViewController release];
}

#pragma mark -
#pragma mark Duration Picker Data Source and Delegate methods

// returns the number of 'columns' to display.
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 14;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *pickerLabel = (UILabel *) view;

    if (pickerLabel == nil) {
        CGRect frame = CGRectMake(0.0, 0.0, 100, 45);
        pickerLabel = [[[UILabel alloc] initWithFrame:frame] autorelease];
        [pickerLabel setTextAlignment:UITextAlignmentRight];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setTextColor:[UIColor blackColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:20]];
    }

    if (row >= 0)
        [pickerLabel setText:[[self pickerDurations] objectAtIndex:(NSUInteger)row]];

    return pickerLabel;
}



#pragma mark -
#pragma mark Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"";
}

// Customize the appearance of table view cells.
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    [[cell textLabel] setText:@"Ringing Style"];
    [[cell detailTextLabel] setText:[self currentAlertName]];
    return cell;
}

#pragma mark -
#pragma mark Audio Ringer Setting Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO animated:YES];

    // Navigation logic may go here. Create and push another view controller.
    JGModalAlertViewController *ringingSettingViewController = [[JGModalAlertViewController alloc] initWithNibName:@"JGRingingSettingViewController" bundle:nil];
    [ringingSettingViewController setDelegate:self];
    
    [self presentModalViewController:ringingSettingViewController animated:YES];

    [ringingSettingViewController release];
}

#pragma mark -
#pragma mark View lifecycle

-(void)viewDidLoad {
    [super viewDidLoad];

    [self setPickerDurations:[NSArray arrayWithObjects:@"1            ", @"2            ", @"3            ", @"4            ", @"5            ", @"6            ", @"7            ", @"8            ", @"9            ", @"10            ", @"15            ", @"20            ", @"25            ", @"30            ", nil]];
    timerController = nil;

    [self setCurrentAlertName:@"Digital Alarm 1"];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated {
    [[self timerController] stopTimer];
    [self setTimerController:nil];

    [[self countdownTimer] stopTimer];
    [self setCountdownTimer:nil];

    [super viewDidAppear:animated];
}

#pragma mark -
#pragma mark Memory management

-(void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

-(void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

-(void)dealloc {
    [managedObjectContext_ release];
    [timerController release];
    [pickerDurations release];
    [countdownTimer release];
    [currentAlertName release];
    [super dealloc];
}

#pragma mark -
#pragma mark Delegate Methods for setting timer alert
-(void)currentAlertDidChangeTo:(NSString *)alertName_ {
    [self setCurrentAlertName:alertName_];
    UITableViewCell *cell = [currentAlertTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [[cell detailTextLabel] setText:[self currentAlertName]];
    [self dismissModalViewControllerAnimated:YES];
}

-(void)changeAlertDidCancel {
    [self dismissModalViewControllerAnimated:YES];
}

@end

