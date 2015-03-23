//
//  UINavigationController+Rotation.h
//
//  Created by hwj4477 on 12. 9. 26..
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UINavigationController (UINaviRotation)

- (BOOL)shouldAutorotate;
//- (NSUInteger)supportedInterfaceOrientations;
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation;

@end
