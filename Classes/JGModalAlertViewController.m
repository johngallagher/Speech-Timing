#import "JGModalAlertViewController.h"

@interface JGModalAlertViewController ()
-(void)setRingTone;

-(void)cancelModal;
@end

@implementation JGModalAlertViewController

@synthesize alertNames;
@synthesize currentAlertName;
@synthesize delegate = _delegate;

#pragma mark -
#pragma mark View lifecycle

-(void)setRightBarButtonToBeDone {
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(setRingTone)];
    [[self navigationItem] setRightBarButtonItem:doneButton];
    [doneButton release];
}

-(void)setLeftBarButtonToCancel {
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelModal)];
    [[self navigationItem] setLeftBarButtonItem:cancelButton];
    [cancelButton release];
}

-(void)loadDefaultAlerts {
    [self setAlertNames:[NSArray arrayWithObjects:@"Alarm", @"Digital Alarm 1", @"Digital Alarm 2", @"Submarine", @"Two Tone Bell", nil]];
}

-(void)viewDidLoad {
    [super viewDidLoad];

    [self loadDefaultAlerts];
    [self setCurrentAlertName:[_delegate currentAlertName]];
    [self setRightBarButtonToBeDone];
    [self setLeftBarButtonToCancel];
}

-(UINavigationItem *)navigationItem {
    return _customNavigationItem;
}

#pragma mark -
#pragma mark Data Source Helper Methods

-(void)setTextForIndexPath:(NSIndexPath *)indexPath forCell:(UITableViewCell *)cell {
    if ([indexPath row] >= 0)
        [[cell textLabel] setText:[alertNames objectAtIndex:(NSUInteger) [indexPath row]]];
}

-(void)setCheckmarkForIndexPath:(NSIndexPath *)indexPath cell:(UITableViewCell *)cell {
    if ([indexPath row] == [alertNames indexOfObject:[self currentAlertName]]) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    } else {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
}

-(UITableViewCell *)dequeueOrInitCellForTableView:(UITableView *)tableView CellIdentifier:(NSString *)CellIdentifier {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    return cell;
}

#pragma mark -
#pragma mark Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (NSInteger) [[self alertNames] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [self dequeueOrInitCellForTableView:tableView CellIdentifier:CellIdentifier];
    [self setTextForIndexPath:indexPath forCell:cell];
    [self setCheckmarkForIndexPath:indexPath cell:cell];
    return cell;
}

#pragma mark -
#pragma mark Delegate Helper Methods

-(NSIndexPath *)oldSelectedAlarmIndexPath {
    NSIndexPath *oldSelectedAlarmIndexPath = [NSIndexPath indexPathForRow:[alertNames indexOfObject:[self currentAlertName]] inSection:0];
    return oldSelectedAlarmIndexPath;
}

-(void)updateCheckmarksInTableView:(UITableView *)tableView forSelectedIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *oldSelectedAlarmIndexPath = [self oldSelectedAlarmIndexPath];
    if ([indexPath row] == [oldSelectedAlarmIndexPath row])
        return;
    
    UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
    if (newCell.accessoryType == UITableViewCellAccessoryNone) {
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
    }

    UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:oldSelectedAlarmIndexPath];
    if (oldCell.accessoryType == UITableViewCellAccessoryCheckmark) {
        oldCell.accessoryType = UITableViewCellAccessoryNone;
    }
}

-(void)updateCurrentAlertNameFromSelectedIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath row] >= 0)
        [self setCurrentAlertName:[alertNames objectAtIndex:(NSUInteger) [indexPath row]]];
}

#pragma mark -
#pragma mark Alarms Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    [self updateCheckmarksInTableView:tableView forSelectedIndexPath:indexPath];
    [self updateCurrentAlertNameFromSelectedIndexPath:indexPath];
}

#pragma mark -
#pragma mark Modal Actions

-(void)setRingTone {
    [_delegate currentAlertDidChangeTo:[self currentAlertName]];
}

-(void)cancelModal {
    [_delegate changeAlertDidCancel];
}

-(void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc. that aren't in use.
}

-(void)dealloc {
    [currentAlertName release];
    [_delegate release];
    [alertNames release];
    [super dealloc];
}


@end

