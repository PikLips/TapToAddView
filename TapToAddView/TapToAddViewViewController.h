//
//  TapToAddViewViewController.h
//  TapToAddView
//
//  Created by Michael Smith on 3/16/11.
//  Copyright 2011 PikLips LLC.  MIT Open Source License, see license.txt for details.
//

#import <UIKit/UIKit.h>

@interface TapToAddViewViewController : UIViewController /* PikLips */ <UIGestureRecognizerDelegate> /* PikLips */ 
{
    // PikLips: code begins
    UITapGestureRecognizer *tTATapGesture; // PikLips: lets the user hide the view
}
@property (nonatomic, retain) UITapGestureRecognizer *tTATapGesture; // PikLips: demo instance method
// PikLips: code ends

@end
