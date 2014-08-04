//
//  UINavigationController+Rotation.m
//
//  Created by hwj4477 on 12. 9. 26..
//

#import "UINavigationController+Rotation.h"

@implementation UINavigationController (UINaviRotation)

- (BOOL)shouldAutorotate
{
    return [[self.viewControllers lastObject] shouldAutorotate];
}

//- (NSUInteger)supportedInterfaceOrientations
//{
//   return [[self.viewControllers lastObject] supportedInterfaceOrientations];
//}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
}

@end
