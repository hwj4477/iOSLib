//
//  UIViewController+Universal.m
//
//  Created by hwj4477 on 12. 6. 18..
//

@implementation UIViewController (UIViewControllerUniversal)

#define FOURINCH_RETINA_FILE_SUFFIX @"-568h"
#define IPAD_FILE_SUFFIX @"-iPad"
//#define IS_FOURINCH_RETINA ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_FOURINCH (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0f)


- (id)initUnivNibName:(NSString*)name bundle:(NSBundle *)bundle
{
    NSMutableString* nibName = [NSMutableString stringWithString:name];
	
	if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        if(![nibName hasSuffix:IPAD_FILE_SUFFIX] && [[NSBundle mainBundle] pathForResource:[nibName stringByAppendingString:IPAD_FILE_SUFFIX] ofType:@"nib"] != nil)
        {
            [nibName appendString:IPAD_FILE_SUFFIX];
        }
    }
    else
    {
        if(IS_FOURINCH)
        {
            if(![nibName hasSuffix:FOURINCH_RETINA_FILE_SUFFIX] && [[NSBundle mainBundle] pathForResource:[nibName stringByAppendingString:FOURINCH_RETINA_FILE_SUFFIX] ofType:@"nib"] != nil)
            {
                [nibName appendString:FOURINCH_RETINA_FILE_SUFFIX];
            }
        }
    }
	
	return [self initWithNibName:nibName bundle:nil];
}

@end
