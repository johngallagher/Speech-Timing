//
//  Created by John on 09/01/2012.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@protocol JGRingingSettingDelegate
-(void)currentAlertNameDidChangeTo:(NSString *)alertName_;

-(void)changeAlertDidCancel;

-(NSString *)currentAlertName;
@end