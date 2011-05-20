//
//  TapToAddViewViewController.m
//  TapToAddView
//
//  Created by Michael Smith on 3/16/11.
//  Copyright 2011 PikLips LLC. MIT Open Source License, see license.txt for details.
//

#import "TapToAddViewViewController.h"
#import "TTAView.h"  // PikLips: we need the custom class to add views

@implementation TapToAddViewViewController

// PikLips: code begins
@synthesize tTATapGesture; // PikLips: demo instance 
// PikLips: code begins

- (void)dealloc
{
    // PikLips: code begins
    [tTATapGesture release]; // PikLips: memory management
    // PikLips: code begins
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// PikLips: code begins

/* PikLips: Make A Subview
 * This creates a subview for our example that includes the view properties needed
 * to demonstrate the shuffle --
 * - backgroundColor
 * - frame size and position
 * 
 * Since this application merely demonstrates three subviews being shuffled, each
 * new subview created here needs to have a proper origin to be seen and a distictive
 * color to set it off from the other two views.  In order to illustrate this, we
 * create a view with the correct properties by keeping track of what the other two look like.
 * 
 */
- (TTAView *) makeSubview: (TTAView *) parent  atX: (CGFloat) x atY: (CGFloat) y withHeight: (CGFloat) height withWidth: (CGFloat) width withColor: (UIColor *) myBGColor
{
    
    TTAView *newView = [[TTAView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    newView.backgroundColor = myBGColor;
    return [newView autorelease];
}
- (void) tapOutNewSubview
{
    /* PikLips:
     * This will create a subviews under self.view.  It will does so with a simple transition and
     * creates them randomly to illustrate an unknown state of views.  Since
     * views are added instead of removed, They will add forever without clearing memory, BEWARE!
     */
    CGFloat xSide = (random() % (int) self.view.window.frame.size.width);
    CGFloat ySide = (random() % (int) self.view.window.frame.size.height);
    CGFloat height = (random() % (int) self.view.window.frame.size.height) - ySide;
    CGFloat width = (random() % (int) self.view.window.frame.size.width) - xSide;
    [TTAView transitionWithView:self.view
                       duration: 0.0 
                        options: UIViewAnimationTransitionNone // PikLips: try UIViewAnimationOptionTransitionFlipFromRight
                     animations:^{[self.view.window addSubview:[self makeSubview: (TTAView *) self.view 
                            atX: xSide 
                            atY: ySide 
                     withHeight: height 
                      withWidth: width 
                      withColor: [UIColor colorWithRed: (CGFloat) ((CGFloat) 1.0 / (random() % 11)) 
                                                 green: (CGFloat) ((CGFloat) 1.0 / (random() % 13)) 
                                                  blue: (CGFloat) ((CGFloat) 1.0 / (random() % 9)) 
                                                 alpha: 0.5]]];
                     } 
                     completion:nil];
}

// PikLips: add gesture recognizer --
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    /* PikLips
     * Create a tap gesture recognizer for the subview.
     */
    UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] 
                                       initWithTarget:self 
                                       action:@selector(handleTapGesture:)]; // PikLips: assign our method
    [self.view addGestureRecognizer:tapGesture]; // PikLips: add to view
    self.tTATapGesture = (UITapGestureRecognizer *)tapGesture; // PikLips: make public
    tapGesture.delegate = self; // PikLips: amke this class be the delegate 
    [tapGesture release]; // PikLips: then release it

    [super viewDidLoad];
}
// PikLips: added gesture recognizer

/* PikLips:
 * This shuffles the subviews using various UIView methods.
 */
int i = 0; // PikLips; a simple way to change the backgroundColor
- (IBAction) handleTapGesture:(UITapGestureRecognizer *)sender {
    
    [self tapOutNewSubview];
    
}
/* PikLips:
 * This demonstrates the method that handles changes to the view.
 */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    NSLog(@"View, %@, Did Appear.", self.view.description);
}
// PikLips: code ends

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
