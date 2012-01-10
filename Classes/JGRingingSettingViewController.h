#import <UIKit/UIKit.h>
#import "JGRingingSettingDelegate.h"

@interface JGRingingSettingViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UINavigationItem *_customNavigationItem;
    NSArray                   *ringTones;
    id <JGRingingSettingDelegate, NSObject> _delegate;
    NSString *currentAlertName;
}

@property(nonatomic, retain) NSArray  *ringTones;
@property(nonatomic, retain) NSString *currentAlertName;
@property(nonatomic, retain) id delegate;

@end

