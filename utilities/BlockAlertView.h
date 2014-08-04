//
//  BlockAlertView.h
//
//  Created by hwj4477 on 2014. 3. 26..
//

#import <Foundation/Foundation.h>

typedef void (^clickBlock_t)(NSInteger buttonIndex);

@interface BlockAlertView : NSObject <UIAlertViewDelegate>{
    clickBlock_t clickBlock_;
}

+ (void)showAlertTitle:(NSString *)title
               message:(NSString *)message
     cancelButtonTitle:(NSString *)cancelButtonTitle
      otherButtonTitle:(NSString *)otherButtonTitle
            clickBlock:(clickBlock_t)clickBlock;

@end
