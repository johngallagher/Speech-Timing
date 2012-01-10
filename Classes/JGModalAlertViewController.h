#import <UIKit/UIKit.h>
#import "JGRingingSettingDelegate.h"

@interface JGModalAlertViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UINavigationItem *_customNavigationItem;
    NSArray                   *alertNames;
    id <JGRingingSettingDelegate, NSObject> _delegate;
    NSString *currentAlertName;
}

@property(nonatomic, retain) NSArray  *alertNames;
@property(nonatomic, retain) NSString *currentAlertName;
@property(nonatomic, retain) id delegate;

@end

