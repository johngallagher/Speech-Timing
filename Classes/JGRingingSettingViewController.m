#import "JGRingingSettingViewController.h"

@interface JGRingingSettingViewController ()
-(void)setRingTone;

-(void)cancelModal;
@end

@implementation JGRingingSettingViewController

@synthesize ringTones;
@synthesize currentAlertName;
@synthesize delegate = _delegate;

#pragma mark -
#pragma mark View lifecycle

-(void)viewDidLoad {
    [super viewDidLoad];

    [self setRingTones:[NSArray arrayWithObjects:@"Alarm", @"Digital Alarm 1", @"Digital Alarm 2", @"Submarine", @"Two Tone Bell", nil]];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(setRingTone)];
    [[self navigationItem] setRightBarButtonItem:doneButton];
    [doneButton release];

    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelModal)];
    [[self navigationItem] setLeftBarButtonItem:cancelButton];
    [cancelButton release];
}

-(UINavigationItem *)navigationItem {
    return _customNavigationItem;
}

-(void)setRingTone {
    [_delegate ringToneDidChangeTo:[self currentAlertName]];
}

-(void)cancelModal {
    [_delegate ringToneChangeCancelled];
}

#pragma mark -
#pragma mark Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 5;
}


// Customize the appearance of table view cells.
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

    if ([indexPath row] >= 0)
        [[cell textLabel] setText:[ringTones objectAtIndex:(NSUInteger) [indexPath row]]];

    if ([indexPath row] == [ringTones indexOfObject:[self currentAlertName]]) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    } else {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    return cell;
}


#pragma mark -
#pragma mark Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    NSIndexPath *oldIndexPath = [NSIndexPath indexPathForRow:[ringTones indexOfObject:[self currentAlertName]] inSection:0];

    if ([indexPath row] >= 0)
        [self setCurrentAlertName:[ringTones objectAtIndex:(NSUInteger) [indexPath row]]];

    UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
    if (newCell.accessoryType == UITableViewCellAccessoryNone) {
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
    }

    UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:oldIndexPath];
    if (oldCell.accessoryType == UITableViewCellAccessoryCheckmark) {
        oldCell.accessoryType = UITableViewCellAccessoryNone;
    }
}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

-(void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc. that aren't in use.
}

-(void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;

}


-(void)dealloc {
    [currentAlertName release];
    [_delegate release];
    [ringTones release];
    [super dealloc];
}


@end

