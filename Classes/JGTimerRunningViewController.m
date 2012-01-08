//
//  JGRunningViewController.m
//  MeetingTimer
//
//  Created by John Gallagher on 17/12/2011.
//  Copyright 2011 Synaptic Mishap. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import "JGTimerRunningViewController.h"
#import "JGTimeFormatter.h"
#import "JGDrawingTestView.h"

@implementation JGTimerRunningViewController

-(void)viewDidAppear:(BOOL)animated {
    [(JGDrawingTestView *)[self view] animateCountdown];
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
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Did load");
//    // Get the main bundle for the app
//    CFBundleRef mainBundle = CFBundleGetMainBundle ();
//
//    // Get the URL to the sound file to play. The file in this case
//    // is "tap.aif"
//    soundFileURLRef  = CFBundleCopyResourceURL (
//        mainBundle,
//        CFSTR ("tap"),
//        CFSTR ("aif"),
//        NULL
//    );
//
//    // Create a system sound object representing the sound file
//    AudioServicesCreateSystemSoundID (
//        soundFileURLRef,
//        &soundFileObject
//    );

}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


-(void)showRedCard {
    [[self view] setBackgroundColor:[UIColor redColor]];
    AudioServicesPlaySystemSound (soundFileObject);
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
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

- (void)dealloc {
    CFRelease(soundFileURLRef);
    AudioServicesDisposeSystemSoundID(soundFileObject);
    [timeLabel release];
    [super dealloc];
}

@end
