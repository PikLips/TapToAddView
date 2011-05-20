//
//  TapToAddViewAppDelegate.h
//  TapToAddView
//
//  Created by Michael Smith on 3/16/11.
//  Copyright 2011 PikLips LLC. MIT Open Source License, see license.txt for details.
//

#import <UIKit/UIKit.h>

@class TapToAddViewViewController;

@interface TapToAddViewAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet TapToAddViewViewController *viewController;

@end
