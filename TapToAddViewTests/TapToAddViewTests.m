//
//  TapToAddViewTests.m
//  TapToAddViewTests
//
//  Created by Michael Smith on 3/16/11.
//  Copyright 2011 PikLips LLC. MIT Open Source License, see license.txt for details.
//

#import "TapToAddViewTests.h"


@implementation TapToAddViewTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    /* PikLips: code begins here
     * It is here that you initialize the instances of the classes, app delegate & view controller(s), that
     * will have their properties and methods tested.  This makes the tests completely separate from the 
     * application.  As such, they will not interfere with the application when it runs.
     */
    // PikLips: change the delegate class to match the header --
    testAppDelegate = (TapToAddViewAppDelegate *)[[UIApplication sharedApplication] delegate];  //PikLips: creates a separate instance for testing of the same Class as AppDelegate
    testViewController = testAppDelegate.viewController;  //PikLips: creates a separate instance for testing
    // PikLips: code ends 

}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}


/* PiLips: these recursive methods are used to traverse the tree of suvbiews in a window or a view
 *         in tests below.
 */
-(void) spanTheTree: (UIView *) subview
{
    // PikLips: deal with the view, then report on the view hierarchy --
    STAssertNil(subview, @"This view %@ is the #%i subview, tag %i, of %@ with a tag of %i", subview, ([subview.superview.subviews indexOfObject: subview] + 1), subview.tag, subview.superview, subview.superview.tag);
    
    // PikLips: now dig for the subviews --
    for (UIView *eachSubview in subview.subviews)
    {
        [self spanTheTree: eachSubview];
    }
}
- (void) spanTheTree2: (id) unknwnView depth: (int) depth
{
    STAssertNil(unknwnView, @"\nView at depth %i with tag %i is %@ with %@ and label %@", depth, [unknwnView tag],[[unknwnView class] description], NSStringFromCGRect([unknwnView frame]), [unknwnView accessibilityLabel]);
    for (UIView *subview in [unknwnView subviews]) 
    {
        [self spanTheTree2:subview depth:(depth + 1)];
    }
}
/* PikLips:
 * Test for the presence of the App Delegate, View Controller and other 
 * instances.  If these are missing, then MOST of the subsequent tests 
 * for that object will fail.  The interesting ones are those that do
 * not.
 */

-(void) test1_OurAppDelegate {
    STAssertNotNil(testAppDelegate, @"Cannot find the application delegate");  //PikLips: this will fail if not properly assigned
}  // PikLips:

- (void) test2_OurViewController { 
    STAssertNotNil(testViewController, @"Cannot find the view controller");  //PikLips this will fail if the viewController used to assign this instance is not really there
}  //PikLips


-(void) test3_TheWindow
{
    NSLog(@"Tests begin for window");
    // Override point for customization after application launch.
    bool skip = NO; // PikLips: used to nest tests
    
    // UIView Class properties -
    STAssertEquals(testAppDelegate.window.alpha, ALPHA_WINDOWDEFAULT, @"Window alpha default %f, not %f", testAppDelegate.window.alpha, ALPHA_WINDOWDEFAULT);  //PikLips: default
    
    if (AUTORESIZESSUBVIEWS_WINDOWDEFAULT)
        STAssertTrue(testAppDelegate.window.autoresizesSubviews, @"Window autoresizeSubviews is not default %@", AUTORESIZESSUBVIEWS_WINDOWDEFAULT);  //PikLips: default
    else STAssertFalse(testAppDelegate.window.autoresizesSubviews, @"Window autoresizesSubviews is not default %@", AUTORESIZESSUBVIEWS_WINDOWDEFAULT);  //PikLips: default
    
    STAssertEqualObjects(testAppDelegate.window.backgroundColor, BACKGROUNDCOLOR_WINDOWDEFAULT, @"Window default backgroundColor is %@, not default %@", testAppDelegate.window.backgroundColor, BACKGROUNDCOLOR_WINDOWDEFAULT); //PikLips: default
    
    STAssertEquals(testAppDelegate.window.bounds, BOUNDS_WINDOWDEFAULT, @"Window bounds are not default."); //PikLips: default
    
    STAssertEquals(testAppDelegate.window.center, CENTER_WINDOWDEFAULT, @"Window center is %f, not default %f", testAppDelegate.window.center, CENTER_WINDOWDEFAULT); //PikLips: default
    
    if (CLEARSCONTEXTBEFOREDRAWING_WINDOWDEFAULT)
        STAssertTrue(testAppDelegate.window.clearsContextBeforeDrawing, @"Window clearsContextBeforeDrawing is NO, not default YES"); //PikLips: default
    else
        STAssertFalse(testAppDelegate.window.clearsContextBeforeDrawing, @"Window clearsContextBeforeDrawing is YES, not default NO"); //PikLips: default
    
    if (CLIPSTOBOUNDS_WINDOWDEFAULT)
        STAssertTrue(testAppDelegate.window.clipsToBounds, @"Window clipsToBounds is NO, not default YES"); //PikLips: default
    else 
        STAssertFalse(testAppDelegate.window.clipsToBounds, @"Window clipsToBounds is YES, not default NO"); //PikLips: default
    
    STAssertEquals(testAppDelegate.window.contentMode, CONTENTMODE_WINDOWDEFAULT, @"Window contentMode is %i, not default %i", testAppDelegate.window.contentMode, CONTENTMODE_WINDOWDEFAULT); //PikLips: default
    
    STAssertEquals(testAppDelegate.window.contentScaleFactor, CONTENTSCALEFACTOR_WINDOWDEFAULT, @"Window contentScaleFactor is %f, not default %f", testAppDelegate.window.contentScaleFactor, CONTENTSCALEFACTOR_WINDOWDEFAULT); //PikLips: default
    
    STAssertEquals(testAppDelegate.window.contentStretch, testAppDelegate.window.contentStretch, @"Window contentStretch is not defined.", skip = NO); //PikLips: default
    STAssertEquals(testAppDelegate.window.contentStretch, CONTENTSTRETCH_WINDOWDEFAULT, @"Window contentStretch parameters are not default."); //PikLips: default
    
    if (EXCLUSIVETOUCH_WINDOWDEFAULT)
        STAssertTrue(testAppDelegate.window.exclusiveTouch, @"Window exclusiveTouch is NO, not default YES"); //PikLips: default
    else 
        STAssertFalse(testAppDelegate.window.exclusiveTouch, @"Window exclusiveTouch is YES, not default NO"); //PikLips: default
    
    STAssertEquals(testAppDelegate.window.frame, FRAME_WINDOWDEFAULT, @"Window's frame parameters are not default."); //PikLips: default
    
    STAssertEquals(testAppDelegate.window.frame, testAppDelegate.window.bounds, @"Window frame is not the same as its bounds."); //PikLips: default
    
    STAssertNil(testAppDelegate.window.gestureRecognizers, @"Window's list of gesture recognizers for window not null, instead %@", testAppDelegate.window.gestureRecognizers, skip=NO); //PikLips: default
    if (skip) {
        skip = NO;
    }
    else
    {
        for (UIGestureRecognizer *gesture in testAppDelegate.window.gestureRecognizers)
        {
            STAssertNil(gesture, @"Window's gesture recognizer is %@", gesture.description); //PikLips: default
        }
    }
    
    if (HIDDEN_WINDOWDEFAULT)
        STAssertTrue(testAppDelegate.window.hidden, @"Window hidden is NO, not default YES"); //PikLips: default
    else 
        STAssertFalse(testAppDelegate.window.hidden, @"Window hidden is YES, not default NO"); //PikLips: default
    
    STAssertNotNil(testAppDelegate.window.layer, @"Window window layer is nil, not default"); //PikLips: default
    
    if (MULTIPLETOUCHENABLED_WINDOWDEFAULT)
        STAssertTrue(testAppDelegate.window.multipleTouchEnabled, @"Window multipleTounchEnabled is NO, not default YES"); //PikLips: default
    else 
        STAssertFalse(testAppDelegate.window.multipleTouchEnabled, @"Window multipleTounchEnabled is YES, not default "); //PikLips: default
    
    if (OPAQUE_WINDOWDEFAULT)
        STAssertTrue(testAppDelegate.window.opaque, @"Window opaque is NO, not defualt YES"); //PikLips: default
    else
        STAssertFalse(testAppDelegate.window.opaque, @"Window opaque is YES, not default NO"); //PikLips: default
    
    /* PikLips: 
     * subveiws read only -- using the DEFAULT, as we have added views
     */
    STAssertEquals(testAppDelegate.window.subviews.count, SUBVIEWSCOUNT_WINDOWDEFAULT, @"Window has %i subviews: %@", testAppDelegate.window.subviews.count, testAppDelegate.window.subviews); //PikLips: default
    
    /* PikLips: 
     * superview read only
     */
    STAssertNil(testAppDelegate.window.superview, @"Window has a superview %@", testAppDelegate.window.superview); //PikLips: default
    
    STAssertEquals(testAppDelegate.window.tag, (NSInteger) 0, @"Window's tag is not default %i has assigned tag of %i", TAG_WINDOWDEFAULT, testAppDelegate.window.tag); //PikLips: default
    
    STAssertEquals(testAppDelegate.window.transform, TRANSFORM_WINDOWDEFAULT, @"Window transform not default");  //PikLips: default
    
    if (USERINTERACTIONENABLED_WINDOWDEFAULT)
        STAssertTrue(testAppDelegate.window.userInteractionEnabled, @"Window user interaction enabled is NO, not defualt YES"); //PikLips: default
    else
        STAssertTrue(testAppDelegate.window.userInteractionEnabled, @"Window user interaction is YES, not default NO"); //PikLips: default
    
    /* PikLips: 
     * window.window read only 
     * nil if receiver has no window object
     */ 
    STAssertNil(testAppDelegate.window.window, @"Window has been added to another window %@", testAppDelegate.window.window);
    
    // UIWindow class properties
    
    if (KEYWINDOW_WINDOWDEFAULT)
        STAssertTrue(testAppDelegate.window.keyWindow, @"Window is NOT the key window for the application, which is not the default"); //PikLips: default
    else
        STAssertFalse(testAppDelegate.window.keyWindow, @"Window is the key window for the application, but not the default"); //PikLips: default
    
    STAssertNotNil(testAppDelegate.window.rootViewController, @"rootViewController default is nil.", skip=YES); //PikLips: default
    if (skip) {
        NSLog(@"Window does not have rootViewController"); //PikLips: default
        skip = NO;
    }
    else
        STAssertEqualObjects(testAppDelegate.window.rootViewController, testViewController, @"rootViewController is not assigned testViewController"); //PikLips: default
    
    STAssertEqualObjects(testAppDelegate.window.screen, [UIScreen mainScreen], @"Window is not on default main screen, instead %@", testAppDelegate.window.screen); //PikLips: default
    
    STAssertEquals(testAppDelegate.window.bounds.size, testAppDelegate.window.screen.applicationFrame.size, @"Window may not be best sized for its screen this should not be a problem but check status bar."); //PikLips: default
    
    STAssertEquals(testAppDelegate.window.windowLevel, WINDOWLEVEL_WINDOWDEFAULT, @"Window level, %f, not default %f", testAppDelegate.window.windowLevel, WINDOWLEVEL_WINDOWDEFAULT); //PikLips: default
    
    NSLog(@"Tests end for window"); //PikLips: default
}

/* PikLips:
 * Test the View Controller's View instance --
 */
-(void) test4_TheView
{
    NSLog(@"Tests begin for view");
    // Override point for customization after application launch.
    bool skip = NO;
    
    // UIView Class properties -
    STAssertEquals(testViewController.view.alpha, ALPHA_VIEWDEFAULT, @"View alpha default %f, not %f", testViewController.view.alpha, ALPHA_VIEWDEFAULT);
    
    if (AUTORESIZESSUBVIEWS_VIEWDEFAULT)
        STAssertTrue(testViewController.view.autoresizesSubviews, @"View autoresizeSubviews is not default YES", AUTORESIZESSUBVIEWS_VIEWDEFAULT);
    else STAssertFalse(testViewController.view.autoresizesSubviews, @"View autoresizesSubviews is not default NO", AUTORESIZESSUBVIEWS_VIEWDEFAULT);
    // PikLips: This app has a special color for the root view
    STAssertEqualObjects(testViewController.view.backgroundColor, BACKGROUNDCOLOR_DEFAULT, @"View default backgroundColor is %@, not default %@", testViewController.view.backgroundColor, BACKGROUNDCOLOR_VIEWDEFAULT);
    
    STAssertEquals(testViewController.view.bounds, BOUNDS_VIEWDEFAULT, @"View bounds are not default.");
    
    STAssertEquals(testViewController.view.center, CENTER_VIEWDEFAULT, @"View center is %f, not default %f", testViewController.view.center, CENTER_VIEWDEFAULT);
    
    if (CLEARSCONTEXTBEFOREDRAWING_VIEWDEFAULT)
        STAssertTrue(testViewController.view.clearsContextBeforeDrawing, @"View clearsContextBeforeDrawing is NO, not default YES"); //PikLips: default
    else
        STAssertFalse(testViewController.view.clearsContextBeforeDrawing, @"View clearsContextBeforeDrawing is YES, not default NO"); //PikLips: default
    
    if (CLIPSTOBOUNDS_VIEWDEFAULT)
        STAssertTrue(testViewController.view.clipsToBounds, @"View clipsToBounds is NO, not default YES"); //PikLips: default
    else 
        STAssertFalse(testViewController.view.clipsToBounds, @"View clipsToBounds is YES, not default NO"); //PikLips: default
    
    STAssertEquals(testViewController.view.contentMode, CONTENTMODE_VIEWDEFAULT, @"View contentMode is %i, not default %i", testViewController.view.contentMode, CONTENTMODE_VIEWDEFAULT); //PikLips: default
    
    STAssertEquals(testViewController.view.contentScaleFactor, CONTENTSCALEFACTOR_VIEWDEFAULT, @"View contentScalefactor is %f, not default %f", testViewController.view.contentScaleFactor, CONTENTSCALEFACTOR_VIEWDEFAULT); //PikLips: default
    
    STAssertEquals(testViewController.view.contentStretch, CONTENTSTRETCH_VIEWDEFAULT, @"View contentStretch parameters are not default.");
    
    if (EXCLUSIVETOUCH_VIEWDEFAULT)
        STAssertTrue(testViewController.view.exclusiveTouch, @"View exclusiveTouch is NO, not default YES"); //PikLips: default
    else 
        STAssertFalse(testViewController.view.exclusiveTouch, @"View exclusiveTouch is YES, not default NO"); //PikLips: default
    
    STAssertEquals(testViewController.view.frame, FRAME_VIEWDEFAULT, @"View frame parameters are not default.");
    
    STAssertNil(testViewController.view.gestureRecognizers, @"View's list of gesture recognizers for view not null, instead %@", testViewController.view.gestureRecognizers, skip=NO);
    
    if (skip) {
        skip = NO;
    }
    else
    {
        for (UIGestureRecognizer *gesture in testViewController.view.gestureRecognizers)
        {
            STAssertNil(gesture, @"Window's gesture recognizer is %@", gesture.description); //PikLips: default
        }
    }
    if (HIDDEN_VIEWDEFAULT)
        STAssertTrue(testViewController.view.hidden, @"View's hidden is NO, not default YES"); //PikLips: default
    else 
        STAssertFalse(testViewController.view.hidden, @"View's hidden is YES, not default NO"); //PikLips: default
    
    STAssertNotNil(testViewController.view.layer, @"View layer is nil, not default");
    
    if (MULTIPLETOUCHENABLED_VIEWDEFAULT)
        STAssertTrue(testViewController.view.multipleTouchEnabled, @"View multipleTounchEnabled is NO, not default YES"); //PikLips: default
    else 
        STAssertFalse(testViewController.view.multipleTouchEnabled, @"View multipleTounchEnabled is YES, not default "); //PikLips: default
    
    if (OPAQUE_VIEWDEFAULT)
        STAssertTrue(testViewController.view.opaque, @"View opaque is NO, not defualt YES"); //PikLips: default
    else
        STAssertFalse(testViewController.view.opaque, @"View opaque is YES, not default NO"); //PikLips: default
    
    /* PikLips: 
     * subveiws read only
     */
    STAssertEquals(testViewController.view.subviews.count, SUBVIEWSCOUNT_VIEWDEFAULT, @"View has %i subviews: %@", testViewController.view.subviews.count, testViewController.view.subviews, skip = NO);
    if (skip) {
        NSLog(@"View does not have subviews");
        skip = NO;
    }
    else
        NSLog(@"View's subview %@", testViewController.view.subviews.description);
    /* PikLips:
     * superview read only
     */
    STAssertNotNil(testViewController.view.superview, @"View does not have a superview."); 
    
    STAssertEquals(testViewController.view.tag, TAG_DEFAULT, @"View's tag is not default %i has assigned tag of %i", TAG_VIEWDEFAULT, testViewController.view.tag);
    
    STAssertEquals(testViewController.view.transform, TRANSFORM_VIEWDEFAULT, @"View transforn not default");  //PikLips: default
    
    if (USERINTERACTIONENABLED_VIEWDEFAULT)
        STAssertTrue(testViewController.view.userInteractionEnabled, @"View's user interaction enabled is NO, not defualt YES");
    else
        STAssertTrue(testViewController.view.userInteractionEnabled, @"View's user interaction is YES, not default NO");
    
    STAssertNotNil(testViewController.view.window, @"View has not been added to window.");
    
    /* PikLips: 
     * view.window read only 
     * nil if receiver has no window object
     */ 
    STAssertEqualObjects(testViewController.view.window, testViewController.view.superview, @"View's superview is not its window");
    
    if (KEYWINDOW_WINDOWDEFAULT)
        STAssertTrue(testViewController.view.window.keyWindow, @"View this is NOT the key window for the application, which is not the default");
    else
        STAssertFalse(testViewController.view.window.keyWindow, @"View is the key window for the application, but not the default");
    
    STAssertNotNil(testViewController.view.window.rootViewController, @"View Controller's view's window;s rootViewController is nil.", skip=YES);
    if (skip) {
        NSLog(@"View's Window does not have rootViewController");
        skip = NO;
    }
    else
        STAssertEqualObjects(testViewController.view.window.rootViewController, testViewController, @"testViewController is not the rootViewController");
    
    STAssertTrueNoThrow([testViewController.view isDescendantOfView: testAppDelegate.window], @"View %@ is not descendant of window %@.", testViewController.view, testAppDelegate.window, skip=YES);
    
    if (skip)
    {
        NSLog(@"View is not a descendant of it's Window.");
        skip = NO;        
    }
    else
        STAssertEquals(testViewController.view.frame.size, [testViewController.view sizeThatFits:testAppDelegate.window.screen.applicationFrame.size], @"Window may not be best sized for its view.  Hint: do you have a status bar?");
    
    NSInteger tagFinder = 0; // PikLips used to search for views
    while (tagFinder < NUMBER_OF_POSSIBLE_TAGS) {
        STAssertNil([testAppDelegate.window viewWithTag:tagFinder], @"Tag %i has view %@", tagFinder, [testAppDelegate.window viewWithTag: tagFinder]);
        tagFinder++;
    }
    NSLog(@"Tests end for view");
}

/* PikLips: Test view interactions
 * These test the shuffling of the two views using a number of instance and class methods.
 *
 */
- (void) test5_Views
{
    NSLog(@"Tests to inventory views begins.");
    /* PikLips:
     * This will first list all the views, including ones you may not even know
     * are in your project.  We will do this again after changing them.
     */
    [self spanTheTree2:[[UIApplication sharedApplication] keyWindow] depth:0];
    
    // PikLips: this exercises the views by adding 25 of them --
    for (int i = 0; i < 25; i++) [testViewController tapOutNewSubview];
    
    /* PikLips: these report on the order of the views, based on their tag numbers.  For these tests to work
     * you need to include links to every window in your project (usually there is only one).     
     */
    for (UIView *eachView in testAppDelegate.window.subviews)
    {
        [self spanTheTree:eachView];
    }
    /* PikLips:
     * This will finally list all the views, reflecting changes made by
     * the tests. 
     */
    [self spanTheTree2:[[UIApplication sharedApplication] keyWindow] depth:0];
    
    
    NSLog(@"Tests to exercise views ends results - %@.", testAppDelegate.window.subviews);
    
}

@end
