#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "JGTimerControllerDelegate.h"
#import "JGCountdownTimerDelegate.h"
#import <AVFoundation/AVFoundation.h>

@interface JGTimerRunningViewController : UIViewController <JGTimerControllerDelegate, JGCountdownTimerDelegate> {
    IBOutlet UILabel *timeLabel;
    AVAudioPlayer    *audioPlayer;
}

-(void)loadAlertSoundWithFilename:(NSString *)alertSoundFilename_;

-(IBAction)stopTimer:(id)sender;

-(IBAction)playSound:(id)sender;

@end
