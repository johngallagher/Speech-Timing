#import "JGTimerRunningViewController.h"
#import "JGTimeFormatter.h"
#import "JGTimerRunningView.h"
#import "JGAlert.h"
#import "JGTimerDefaults.h"
#import "JGPieChartAnimationParameters.h"
#import "JGPieChartAnimationParameterCalculator.h"
#import "JGAlertNotificationScheduler.h"

@interface JGTimerRunningViewController ()
-(void)initViewControllerWithStartTime:(NSDate *)startTime_ fireTime:(NSDate *)fireTime_ alarmFilename:(NSString *)an;

-(void)initViewControllerWithAlert:(JGAlert *)alert_;


-(void)setTimeRemainingTo:(NSTimeInterval)time_;

@end

@implementation JGTimerRunningViewController

@synthesize countdownTimer;
@synthesize timerController;

-(void)continueCountdownAnimation {
    [self startCountdownAnimation];
}

-(void)startCountdownAnimation {
    JGPieChartAnimationParameters *pieChartAnimation = [[JGPieChartAnimationParameterCalculator calculatorWithAlert:_alert] calculateParameters];
    [(JGTimerRunningView *)[self view] startCountdownAnimationWithParameters:pieChartAnimation];
}

-(void)viewDidAppear:(BOOL)animated {
}

-(void)invalidateTimers {
    [[self timerController] stopTimer];
    [self setTimerController:nil];

    [[self countdownTimer] stopTimer];
    [self setCountdownTimer:nil];
}

-(void)viewDidDisappear:(BOOL)animated {
    [self invalidateTimers];
}

-(void)suspendCountdownAnimation {
    [(JGTimerRunningView *)[self view] suspendCountdownAnimation];

}

+(JGTimerRunningViewController *)viewControllerWithFireTime:(NSDate *)fireTime {
    JGTimerRunningViewController *runningViewController = [[[JGTimerRunningViewController alloc] initWithNibName:@"JGTimerRunningViewController" bundle:nil] autorelease];
    [runningViewController initViewControllerWithStartTime:fireTime fireTime:nil alarmFilename:nil];
    return runningViewController;
}


+(JGTimerRunningViewController *)viewControllerWithStartTime:(NSDate *)startTime_ fireTime:(NSDate *)fireTime_ alarmFilename:(NSString *)an {
    JGTimerRunningViewController *runningViewController = [[[JGTimerRunningViewController alloc] initWithNibName:@"JGTimerRunningViewController" bundle:nil] autorelease];
    [runningViewController initViewControllerWithStartTime:startTime_ fireTime:fireTime_ alarmFilename:an];
    return runningViewController;
}

+(JGTimerRunningViewController *)viewControllerWithAlert:(JGAlert *)alert_ {
    return [self viewControllerWithStartTime:[alert_ startTime] fireTime:[alert_ fireTime] alarmFilename:[alert_ filenameWithoutExtension]];
}


-(void)initViewControllerWithStartTime:(NSDate *)startTime_ fireTime:(NSDate *)fireTime_ alarmFilename:(NSString *)an {
    [self initViewControllerWithAlert:[JGAlert alertWithStartTime:startTime_ fireTime:fireTime_ name:an]];
}

-(void)initViewControllerWithAlert:(JGAlert *)alert_ {
    _alert = [alert_ retain];

    [self startCountdownAnimation];

    [self loadAlertSoundWithFilename:[alert_ name]];

    [self setTimerController:[JGTimerController timerStartingAt:[alert_ startTime] withFireTime:[alert_ fireTime] delegate:self]];
    [[self timerController] startTimer];

    [self setCountdownTimer:[JGCountdownTimer timerStartingAt:[alert_ startTime] withFireTime:[alert_ fireTime] delegate:self]];
    [[self countdownTimer] startTimer];
}

-(void)loadAlertSoundWithFilename:(NSString *)alertSoundFilename_ {
    // Get the main bundle for the app
    NSError *error              = nil;
    NSURL   *alertSoundFilename = [[NSBundle mainBundle] URLForResource:alertSoundFilename_ withExtension:@"aif"];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:alertSoundFilename error:&error];
    [audioPlayer prepareToPlay];
}


-(IBAction)stopTimer:(id)sender {
    [JGAlertNotificationScheduler removeAllNotifications];
    [[JGTimerDefaults sharedInstance] invalidateAlert];
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
    if ([[JGTimerDefaults sharedInstance] currentTimeNearFireTime]) {
        [self playSound:self];
    }
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
    [_alert release];
    [super dealloc];
}

@end
