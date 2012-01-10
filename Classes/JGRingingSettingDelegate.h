//
//  Created by John on 09/01/2012.
//
// To change the template use AppCode | Preferences | File Templates.
//


@protocol JGRingingSettingDelegate
-(void)currentAlertDidChangeTo:(NSString *)alertName_;

-(void)changeAlertDidCancel;

-(NSString *)currentAlertName;
@end