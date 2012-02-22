#import "JGTimerConfigurationViewController.h"
#import "JGTimerRunningViewController.h"
#import "JGModalAlertViewController.h"
#import "JGCardTimesCalculator.h"
#import "JGTimerDefaults.h"

@interface JGTimerConfigurationViewController ()
-(NSString *)_currentAlertFilename;

-(NSDate *)_fireTimeFromDuration:(NSUInteger)durationOfTimer;

-(void)_startTimerWithDuration:(NSUInteger)durationOfTimer;


-(void)_continueTimerWithStartTime:(NSDate *)date fireTime:(NSDate *)date1;

-(NSUInteger)_timerDurationFromPickerRowSelected:(NSInteger)selectedRow;

-(NSInteger)_selectedDurationPickerRow;

-(BOOL)_noDurationPickerRowSelected;

-(void)_startTimer;

@end

@implementation JGTimerConfigurationViewController

@synthesize pickerDurations;
@synthesize managedObjectContext = managedObjectContext_;
@synthesize currentAlertName;



#pragma mark Public
-(IBAction)startTimer:(id)sender {
    if ([self _noDurationPickerRowSelected])
        return;

    [self _startTimer];
}

#pragma mark Private
-(NSString *)_currentAlertFilename {
    return [[self currentAlertName] stringByReplacingOccurrencesOfString:@" " withString:@""];
}

-(NSDate *)_fireTimeFromDuration:(NSUInteger)durationOfTimer {
    return [NSDate dateWithTimeIntervalSinceNow:durationOfTimer];
}

#pragma mark Defaults
-(void)saveStartTimeToDefaults:(NSDate *)date {
    [[JGTimerDefaults sharedInstance] set_startTime:date];
}

-(void)saveFireTimeToDefaults:(NSDate *)date {
    [[JGTimerDefaults sharedInstance] set_fireTime:date];
}

-(void)saveCurrentAlertNameToDefaults {
    [[JGTimerDefaults sharedInstance] setCurrentAlertName:[self currentAlertName]];
}

-(void)_startTimerWithDuration:(NSUInteger)durationOfTimer {
    NSDate *startTime = [NSDate date];
    NSDate *fireTime  = [self _fireTimeFromDuration:durationOfTimer];

    [self saveStartTimeToDefaults:startTime];
    [self saveFireTimeToDefaults:fireTime];

    JGTimerRunningViewController *runningViewController = [JGTimerRunningViewController viewControllerWithAlert:startTime];
    [[self navigationController] pushViewController:runningViewController animated:YES];
}

-(void)_continueTimerWithStartTime:(NSDate *)startTime_ fireTime:(NSDate *)fireTime_ {
    JGTimerRunningViewController *runningViewController = [JGTimerRunningViewController viewControllerWithAlert:startTime_];
    [[self navigationController] pushViewController:runningViewController animated:YES];
}


-(NSUInteger)_timerDurationFromPickerRowSelected:(NSInteger)selectedRow {
    return (NSUInteger)[[pickerDurations objectAtIndex:(NSUInteger)selectedRow] intValue] * 60;
}

-(NSInteger)_selectedDurationPickerRow {
    return [timerDurationPickerView selectedRowInComponent:0];
}

-(BOOL)_noDurationPickerRowSelected {
    return [self _selectedDurationPickerRow] < 0;
}

-(void)_startTimer {
    NSUInteger timerDurationFromPickerRowSelected = [self _timerDurationFromPickerRowSelected:[self _selectedDurationPickerRow]];
    [self _startTimerWithDuration:timerDurationFromPickerRowSelected];
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
#pragma mark Restoring from NSUserDefaults

-(BOOL)timerIsRunning {
    return [[JGTimerDefaults sharedInstance] timerIsRunning]; // Timer is running checks default start time and fire time and if they're inconsistent, it resets them both to nil.
}

-(void)updateCurrentAlertNameFromDefaults {
    NSString *defaultAlertName = [[JGTimerDefaults sharedInstance] defaultAlertName];
    if (defaultAlertName) {
        [self setCurrentAlertName:defaultAlertName];
    } else {
        [self setCurrentAlertName:@"Digital Alarm 1"];
    }
}

-(NSDate *)startTimeFromDefaults {
    return [[JGTimerDefaults sharedInstance] defaultStartTime];
}

-(NSDate *)fireTimeFromDefaults {
    return [[JGTimerDefaults sharedInstance] defaultFireTime];
}

-(void)continueTimer {
    NSDate *startTime = [self startTimeFromDefaults];
    NSDate *fireTime  = [self fireTimeFromDefaults];
    [self _continueTimerWithStartTime:startTime fireTime:fireTime];
}

-(void)restoreViewFromUserDefaults {
    [self updateCurrentAlertNameFromDefaults];
    if ([self timerIsRunning]) {
        [self continueTimer];
    }
}
#pragma mark -
#pragma mark View lifecycle

-(void)viewDidLoad {
    [super viewDidLoad];

    [self setPickerDurations:[NSArray arrayWithObjects:@"1            ", @"2            ", @"3            ", @"4            ", @"5            ", @"6            ", @"7            ", @"8            ", @"9            ", @"10            ", @"15            ", @"20            ", @"25            ", @"30            ", nil]];
    [self restoreViewFromUserDefaults];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated {
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
    [pickerDurations release];
    [currentAlertName release];
    [super dealloc];
}

#pragma mark -
#pragma mark Delegate Methods for setting timer alert

-(void)currentAlertDidChangeTo:(NSString *)alertName_ {
    [self setCurrentAlertName:alertName_];
    [self saveCurrentAlertNameToDefaults];
    UITableViewCell *cell = [currentAlertTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [[cell detailTextLabel] setText:[self currentAlertName]];
    [self dismissModalViewControllerAnimated:YES];
}

-(void)changeAlertDidCancel {
    [self dismissModalViewControllerAnimated:YES];
}

-(NSString *)currentAlertName {
    return currentAlertName;
}


@end

