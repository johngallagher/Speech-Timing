#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "JGTimerControllerDelegate.h"
#import "JGCountdownTimerDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import "JGCountdownTimer.h"
#import "JGTimerController.h"

@class JGAlert;

@interface JGTimerRunningViewController : UIViewController <JGTimerControllerDelegate, JGCountdownTimerDelegate> {
    IBOutlet UILabel  *timeLabel;
    AVAudioPlayer     *audioPlayer;
    JGTimerController *timerController;
    JGCountdownTimer  *countdownTimer;
    JGAlert *_alert;
}

@property(nonatomic, retain) JGCountdownTimer  *countdownTimer;
@property(nonatomic, retain) JGTimerController *timerController;


-(void)continueCountdownAnimation;

-(void)startCountdownAnimation;


-(void)suspendCountdownAnimation;

+(JGTimerRunningViewController *)viewControllerWithFireTime:(NSDate *)fireTime;

+(JGTimerRunningViewController *)viewControllerWithAlert:(JGAlert *)alert_;


-(void)loadAlertSoundWithFilename:(NSString *)alertSoundFilename_;

-(IBAction)stopTimer:(id)sender;

-(IBAction)playSound:(id)sender;

@end
