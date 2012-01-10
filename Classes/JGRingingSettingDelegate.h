//
//  Created by John on 09/01/2012.
//
// To change the template use AppCode | Preferences | File Templates.
//


@protocol JGRingingSettingDelegate
-(void)ringToneDidChangeTo:(NSString *)alertName_;

-(void)ringToneChangeCancelled;
@end