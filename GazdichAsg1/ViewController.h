//
//  ViewController.h
//  GazdichAsg1
//
//  Created by Mike_Gazdich_rMBP on 9/9/13.
//  Copyright (c) 2013 Mike Gazdich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

/*
 These are each of our UITextViews for inputing height.
 */
@property (strong, nonatomic) IBOutlet UITextField *feet;
@property (strong, nonatomic) IBOutlet UITextField *inch;
@property (strong, nonatomic) IBOutlet UITextField *meter;

/*
 These are out weight control UI tools.
 */
@property (strong, nonatomic) IBOutlet UISegmentedControl *weightController;
@property (strong, nonatomic) IBOutlet UISlider *weightSlider;
@property (strong, nonatomic) IBOutlet UILabel *sliderLabel;

// The display, initially storing an empty string, that will be populated do notify the user of their BMI.
@property (strong, nonatomic) IBOutlet UILabel *display;

/*
 Actions used for when the buttons are used and the slider is changed.
 */
- (IBAction)compute:(UIButton *)sender;
- (IBAction)reset:(id)sender;
- (IBAction)sliderChanged:(UISlider *)sender;

@end
