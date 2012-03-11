#import "JGTimerConfigurationViewController.h"
#import "JGTimerRunningViewController.h"
#import "JGModalAlertViewController.h"
#import "JGTimerDefaults.h"
#import "JGAlert.h"
#import "JGAlertNotificationScheduler.h"

@interface JGTimerConfigurationViewController ()

-(void)startTimerWithDuration:(NSUInteger)durationOfTimer;


-(NSUInteger)timerDurationFromPickerRowSelected:(NSInteger)selectedRow;

-(NSInteger)selectedDurationPickerRow;

-(BOOL)noDurationPickerRowSelected;

-(void)startTimer;

-(BOOL)timerIsRunning;

-(void)restoreAlertFromDefaults;

-(void)continueTimer;


@end

@implementation JGTimerConfigurationViewController

@synthesize pickerDurations;
@synthesize managedObjectContext = managedObjectContext_;
@synthesize currentAlertName;
@synthesize currentAlert = _currentAlert;

#pragma mark View lifecycle

-(void)viewDidLoad {
    [super viewDidLoad];
    // Hack to work around not being able to justify numbers to the left within the spinner
    [self setPickerDurations:[NSArray arrayWithObjects:@"1            ", @"2            ", @"3            ", @"4            ", @"5            ", @"6            ", @"7            ", @"8            ", @"9            ", @"10            ", @"15            ", @"20            ", @"25            ", @"30            ", nil]];
    [self restoreAlertFromDefaults];
}

#pragma mark Public
-(IBAction)startTimer:(id)sender {
    if ([self noDurationPickerRowSelected])
        return;

    [self startTimer];
}

#pragma mark Private
-(void)pushRunningViewControllerWithCurrentAlert {
    JGTimerRunningViewController *runningViewController = [JGTimerRunningViewController viewControllerWithAlert:_currentAlert];
    [[self navigationController] pushViewController:runningViewController animated:YES];
}

-(void)startTimerWithDuration:(NSUInteger)durationOfTimer {
    _currentAlert = [[JGAlert alertStartingNowWithDuration:durationOfTimer name:[_currentAlert name]] retain];
    [_currentAlert saveToTimerDefaults];

    [self pushRunningViewControllerWithCurrentAlert];
    [JGAlertNotificationScheduler scheduleNotification]; // So that if the app isn't frontmost the user will get a notifcation
}


-(NSUInteger)timerDurationFromPickerRowSelected:(NSInteger)selectedRow {
    return (NSUInteger)[[pickerDurations objectAtIndex:(NSUInteger)selectedRow] intValue] * 60;
}

-(NSInteger)selectedDurationPickerRow {
    return [timerDurationPickerView selectedRowInComponent:0];
}

-(BOOL)noDurationPickerRowSelected {
    return [self selectedDurationPickerRow] < 0;
}

-(void)startTimer {
    NSUInteger timerDurationFromPickerRowSelected = [self timerDurationFromPickerRowSelected:[self selectedDurationPickerRow]];
    [self startTimerWithDuration:timerDurationFromPickerRowSelected];
}

#pragma mark -
#pragma mark Restoring from NSUserDefaults

-(BOOL)timerIsRunning {
    return [[JGTimerDefaults sharedInstance] timerIsRunning];
}

-(void)restoreAlertFromDefaults {
    _currentAlert = [[[JGTimerDefaults sharedInstance] alert] retain];
}

-(void)continueTimer {
    [self pushRunningViewControllerWithCurrentAlert];
}

-(void)updateCurrentAlertNameIndicator {
    UITableViewCell *cell = [currentAlertTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [[cell detailTextLabel] setText:[_currentAlert name]];
}

-(void)hideModalAlertSelector {
    [self dismissModalViewControllerAnimated:YES];
}

-(NSString *)currentAlertName {
    return currentAlertName;
}

// TODO: Change JGRingingSettingDelegate and current alert name and alert modal to all be consistent naming
#pragma mark -
#pragma mark Modal Alert View Controller
-(void)pushAlertNameViewController {
    JGModalAlertViewController *modalAlertViewController = [[JGModalAlertViewController alloc] initWithNibName:@"JGRingingSettingViewController" bundle:nil];
    [modalAlertViewController setDelegate:self];

    NSString *currentAlertName_ = [_currentAlert name];
    [modalAlertViewController setCurrentAlertName:currentAlertName_];
    [self presentModalViewController:modalAlertViewController animated:YES];
    [modalAlertViewController release];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO animated:YES];

    [self pushAlertNameViewController];
}

#pragma mark Modal Alert View Delegate
-(void)currentAlertNameDidChangeTo:(NSString *)alertName_ {
    [[JGTimerDefaults sharedInstance] setCurrentAlertName:alertName_];
    [_currentAlert updateNameFromDefaults];

    [self updateCurrentAlertNameIndicator];
    [self hideModalAlertSelector];
}

-(void)changeAlertDidCancel {
    [self hideModalAlertSelector];
}

#pragma mark -
#pragma mark Duration Picker Data Source and Delegate methods

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 14;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *pickerLabel = (UILabel *)view;

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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    [tableView setBackgroundColor:[UIColor clearColor]];
    [[cell textLabel] setText:@"Alarm"];
    [[cell detailTextLabel] setText:[_currentAlert name]];
    return cell;
}


-(void)dealloc {
    [managedObjectContext_ release];
    [pickerDurations release];
    [currentAlertName release];
    [_currentAlert release];
    [super dealloc];
}

@end

