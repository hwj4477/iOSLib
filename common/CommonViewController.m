//
//  CommonViewController.m
//
//  Created by hwj4477 on 2014. 1. 15..
//

#import "CommonViewController.h"

#define FOURINCH_RETINA_FILE_SUFFIX @"-568h"
#define IPAD_FILE_SUFFIX @"-iPad"
//#define IS_FOURINCH_RETINA ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_FOURINCH (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0f)


@interface CommonViewController ()

@end

@implementation CommonViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSMutableString* nibName = [NSMutableString stringWithString:nibNameOrNil];
    
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
    
    self = [super initWithNibName:nibName bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
        [self setButtonExclusiveOnView:self.view];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - helper
- (void)setButtonExclusiveOnView:(UIView *)view
{
    for(UIView* v in view.subviews)
    {
        if([v isKindOfClass:[UIButton class]])
        {
            UIButton* btn = (UIButton*)v;
            [btn setExclusiveTouch:YES];
        }
        
        if([v isKindOfClass:[UIView class]])
        {
            [self setButtonExclusiveOnView:v];
        }
    }
}

#pragma mark - UIViewController Orientations functions.
-(BOOL)shouldAutorotate
{
    return NO;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
