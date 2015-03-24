//
//  BlockAlertView.m
//
//  Created by hwj4477 on 2014. 3. 26..
//

#import "BlockAlertView.h"

@implementation BlockAlertView

+ (void)showAlertTitle:(NSString *)title
               message:(NSString *)message
     cancelButtonTitle:(NSString *)cancelButtonTitle
      otherButtonTitle:(NSString *)otherButtonTitle
            clickBlock:(clickBlock_t)clickBlock
{
    [[self alloc] initWithAlertTitle:title
                              message:message
                    cancelButtonTitle:cancelButtonTitle
                     otherButtonTitle:otherButtonTitle
                           clickBlock:clickBlock];
}

- (id)initWithAlertTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle clickBlock:(clickBlock_t)clickBlock
{
    if ((self=[super init]))
    {
        clickBlock_ = [clickBlock copy];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:cancelButtonTitle
                                                  otherButtonTitles:otherButtonTitle, nil];
        
        [alertView show];
    }
    
    return self;
}

- (void)alertView:(UIAlertView*)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    clickBlock_(buttonIndex);
}

@end
