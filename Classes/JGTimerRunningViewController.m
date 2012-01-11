#import "JGTimerRunningViewController.h"
#import "JGTimeFormatter.h"
#import "JGDrawingTestView.h"
#import "JGTimerController.h"
#import "JGCountdownTimer.h"

@interface JGTimerRunningViewController ()
-(void)initViewControllerWithFireDate:(NSDate *)fireDate;

-(void)setTimeRemainingTo:(NSTimeInterval)time_;

@end

@implementation JGTimerRunningViewController

@synthesize countdownTimer;
@synthesize timerController;


+(JGTimerRunningViewController *)viewControllerWithFireDate:(NSDate *)fireDate {
    JGTimerRunningViewController *runningViewController = [[[JGTimerRunningViewController alloc] initWithNibName:@"JGTimerRunningViewController" bundle:nil] autorelease];
    [runningViewController initViewControllerWithFireDate:fireDate];
    return runningViewController;
}

-(void)initViewControllerWithFireDate:(NSDate *)fireDate {
    
    [(JGDrawingTestView *) [self view] setAnimationDuration:durationOfTimer];
    [self loadAlertSoundWithFilename:[self currentAlertFilename]];

    [self setTimerController:[JGTimerController timerWithDurationValue:durationOfTimer delegate:self]];
    [[self timerController] startTimer];

    [self setCountdownTimer:[JGCountdownTimer timerWithDurationValue:durationOfTimer delegate:self]];
    [[self countdownTimer] startTimer];
}

-(void)loadAlertSoundWithFilename:(NSString *)alertSoundFilename_ {
    // Get the main bundle for the app
    NSError *error              = nil;
    NSURL   *alertSoundFilename = [[NSBundle mainBundle] URLForResource:alertSoundFilename_ withExtension:@"aif"];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:alertSoundFilename error:&error];
    [audioPlayer prepareToPlay];
}

-(void)viewDidAppear:(BOOL)animated {
    [(JGDrawingTestView *) [self view] animateCountdown];
}

-(void)viewDidDisappear:(BOOL)animated {

}

-(IBAction)stopTimer:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
-(void)viewDidLoad {
    [super viewDidLoad];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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

-(IBAction)playSound:(id)sender {
    [audioPlayer play];
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

-(void)showRedCard {
    [[self view] setBackgroundColor:[UIColor redColor]];
    [self playSound:self];
}

-(void)showYellowCard {
    [[self view] setBackgroundColor:[UIColor yellowColor]];
}

-(void)showGreenCard {
    [[self view] setBackgroundColor:[UIColor greenColor]];
}

-(void)timeRemainingDidChangeTo:(NSTimeInterval)time_ {
    [self setTimeRemainingTo:time_];
}

-(void)setTimeRemainingTo:(NSTimeInterval)time_ {
    NSString *timeText = [[JGTimeFormatter defaultFormatterBehavior] stringForObjectValue:[NSNumber numberWithDouble:time_]];
    [timeLabel setText:timeText];
}

-(void)dealloc {
    [audioPlayer stop];
    [audioPlayer release];
    [timeLabel release];
    [countdownTimer release];
    [timerController release];
    [super dealloc];
}

@end
