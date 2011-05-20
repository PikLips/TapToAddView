//
//  TapToAddViewTests.h
//  TapToAddViewTests
//
//  Created by Michael Smith on 3/16/11.
//  Copyright 2011 PikLips LLC. MIT Open Source License, see license.txt for details.
//

#import <SenTestingKit/SenTestingKit.h>
// PikLips: added code --
/* PikLips:
 * Here is the link between the application and the test.  Add the necessary header(s) to identify 
 * the app delegate and view controller(s).  Usually, a project's app delegate header references
 * its view controller headers.
 */
#import "UIViewConstants.h" // PikLips: UIView and UIWindow default property values
#import "TapToAddViewAppDelegate.h" // PikLips: the app delegate, which includes the viewController and Subview 
#import "TapToAddViewViewController.h" // PikLips: the viewController and its view 
// PikLips: code ends


@interface TapToAddViewTests : SenTestCase {
@private
    /* PikLips: code begins --
     * Creates the test instances to be tested.
     */
    TapToAddViewAppDelegate       *testAppDelegate; // PikLips: this is our test instance of the app delegate, including the window
    TapToAddViewViewController    *testViewController; //PikLips: this is the test instance of the view, created by IB
    // PikLips: code ends
    
}

@end
