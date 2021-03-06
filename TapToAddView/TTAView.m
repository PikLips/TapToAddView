//
//  TTAView.m
//  TapToAddView
//
//  Created by Michael Smith on 3/16/11.
//  Copyright 2011 PikLips LLC. MIT Open Source License, see license.txt for details.
//

#import "TTAView.h"


@implementation TTAView

NSInteger tag = 0;  // PikLips: for automated tag numbering
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.tag = ++tag;  // PikLips: automatically add a tag
        [self setAccessibilityLabel:[NSString stringWithFormat:@"SubView%i", self.tag]]; // PikLips: for UIAutonation Instrument
 // PikLips: for UIAutonation Instrument
    }
    return self;
}
// PikLips: code begins -
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        [self setAccessibilityLabel:[NSString stringWithFormat:@"SubView%i", self.tag]]; // PikLips: for UIAutonation Instrument
        self.backgroundColor = [UIColor redColor]; // PikLips: the root UIView will be red
        self.tag = ++tag;  // PikLips: automatically add a tag
    }
    return self;
}

bool firstTry = YES;
/* PikLips:
 * This tells the UIAutomation script whether the element is a container or a touchable object.  
 * In our case, just taking inventory, we want to show both the containers and their objects.
 */
- (BOOL) isAccessibilityElement
{
    if (self.tag == 1)
    {
        if (firstTry)
        {
            firstTry = NO;
            return YES;
        }
        else
        {
            firstTry = YES;
            return NO;
        }
    }
    else
    {
        return YES;
    }
}
- (BOOL) userInteractionEnabled
{
    return YES;
}
- (NSString *) accessibilityLabel
{
    NSString * label = [super accessibilityLabel];
    
    if (label == nil)
    {
        if (self.tag == 1) 
        {
            label = [NSString stringWithFormat:@"MainView"];
        }
        else
        {
            label = [NSString stringWithFormat:@"SubView%i", self.tag];
        }
    }
    return NSLocalizedString(label, @"generated by view");
    
}
/* PikLips:
 * These are instance methods for UIView that act as warnings when your view has changed.  They 
 * are here just to show you how they are triggered.
 */
-(void) didAddSubview:(UIView *)subview {
    if (subview.tag == 0) 
    {
        subview.tag = 666; // PikLips: red flag
     }
    NSLog(@"PikLips: Another subview %@, tag %i, was added to this view, %@, tag %i", [subview description], subview.tag, [subview.superview description], subview.superview.tag);
    
}
-(void) didMoveToSuperview {
    NSLog(@"PikLips: Our custom view, %@, tag %i, was moved to superview, tag %i", [self description], self.tag, self.superview.tag);
    
}
-(void) didMoveToWindow {
    NSLog(@"PikLips: Our custom view, %@, tag %i, was moved to another window, tag %i", [self description], self.tag, self.superview.window.tag);
    
}

// PikLips: code ends

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [super dealloc];
}

@end
