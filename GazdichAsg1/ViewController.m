//
//  ViewController.m
//  GazdichAsg1
//
//  Created by Mike_Gazdich_rMBP on 9/9/13.
//  Copyright (c) 2013 Mike Gazdich. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// No private variables to be declared here.

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 This method is used to house all of the logic is checking for errors in input and showing alerts, calculating the user's BMI,
 and then displaying them to the user.
 */
- (IBAction)compute:(UIButton *)sender {
    
    UIAlertView *alert;
    
    //Formatter used to convert the String in the UITextView to the number.
    NSNumberFormatter *format = [[NSNumberFormatter alloc] init];
    [format setNumberStyle: NSNumberFormatterNoStyle];
    
    NSNumber *feet, *inch, *meter;
    feet = [format numberFromString:self.feet.text];
    inch = [format numberFromString:self.inch.text];
    
    [format setNumberStyle:NSNumberFormatterDecimalStyle];
    
    meter = [format numberFromString:self.meter.text];

    /*
     Checks to see if there are no values in the UITextViews. If not, we bring it to the users attention to enter some form of height. The reason we are checking against an empty string instead of nil is because the NSNumber could be nil if it is empty, OR if there is a non-numeric value in there (a letter) so we check specifically for the empty string here.
     */
    if([self.meter.text  isEqual: @""] && [self.inch.text isEqual: @""] && [self.feet.text isEqual: @""]){
        // Create the Alert View
        alert = [[UIAlertView alloc] initWithTitle:@"Your height is missing!"
                                                        message:@"Please enter in your height either in feet and inches or in meters."
                                                       delegate:self
                                              cancelButtonTitle:@"Okay"
                                              otherButtonTitles:nil];
    }
    /*
     Checks to see if both imperial and metric heights are used.
     */
    else if ((meter != nil && feet != nil && inch != nil) || (meter != nil && feet != nil) || (meter != nil && inch != nil)){
        // Create the Alert View
        alert = [[UIAlertView alloc] initWithTitle:@"Unit Conflict!"
                                                        message:@"Both feet/inches and meters are entered. Please use only one unit."
                                                       delegate:self
                                              cancelButtonTitle:@"Okay"
                                              otherButtonTitles:nil];
    }
    /*
     This check is for if a letter is input as the height. We check to see that the NSNumber is nil and that the text field is not empty.
    */
    else if((feet == nil && ![self.feet.text isEqual:@""]) ||
            (inch == nil && ![self.inch.text isEqual:@""]) ||
            (meter == nil && ![self.meter.text isEqual:@""])){
        // Create the Alert View
        alert = [[UIAlertView alloc] initWithTitle:@"Not a Number!"
                                                        message:@"Please enter only numbers for your height."
                                                       delegate:self
                                              cancelButtonTitle:@"Okay"
                                              otherButtonTitles:nil];
    }
    /*
     Checks to see if there is a weight option selected.
     */
    else if (self.weightController.selectedSegmentIndex == -1){
        // Create the Alert View
        alert = [[UIAlertView alloc] initWithTitle:@"No Weight Unit Selected!"
                                                        message:@"Please select Pounds or Kilograms weight unit."
                                                       delegate:self
                                              cancelButtonTitle:@"Okay"
                                              otherButtonTitles:nil];
    }
    /*
     Checks the constraints on the height to make sure it is not over the max.
     */
    else if (((feet.intValue > 7) && (inch.intValue >= 12)) || ([self.meter.text doubleValue] > 2.2)){
        // Create the Alert View
        alert = [[UIAlertView alloc] initWithTitle:@"Height is Too High!"
                                                        message:@"Please enter an exceptable height."
                                                       delegate:self
                                              cancelButtonTitle:@"Okay"
                                              otherButtonTitles:nil];
    }
    /*
     Now calculate the BMI and display it to the user.
     */
    else {
        double bmi, weight, height;
        if (meter == nil) {
            height = (((feet.intValue * 12) + inch.intValue)/ 39.37);
        }
        else {
            height = meter.doubleValue;
        }
        if(self.weightController.selectedSegmentIndex == 0){
            weight = (self.weightSlider.value / 2.2046);
        }
        else {
            weight = self.weightSlider.value;
        }
        
        bmi = (weight / (height * height));
        
        //Using a mutable string here to concatenate on the end to compile the message for the user's BMI.
        NSMutableString *display = [[NSMutableString alloc] initWithCapacity:40];
        
        [display appendString: @"You are "];
        if(bmi < 18.5) {
            [display appendString:@"Underweight "];
        }
        else if (bmi >= 18.5 && bmi <= 24.9) {
            [display appendString:@"Normal "];
        }
        else if (bmi > 24.9 && bmi < 30){
            [display appendString:@"Overweight "];
        }
        else if (bmi >= 30){
            [display appendString:@"Obese "];
        }
        else {
            [display appendString:@"Error "];
        }
    
        NSString *BMIString = [[NSString alloc] initWithFormat:@"%1.2f", bmi];
        [display appendString: @"with BMI: "];
        [display appendString:BMIString];
        
        self.display.text = display;
        
    }
    
    // Display the Alert View
    [alert show];
}

/*
 This is here so that when the user clicked 'Done' on the keyboard, it will close the keyboard automatically.
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

/*
 Used to reset the UI to the default layout and values.
 */
- (IBAction)reset:(id)sender{
    self.meter.text = @"";
    self.feet.text = @"";
    self.inch.text = @"";
    self.display.text = @"";
    self.sliderLabel.text = @"100";
    self.weightSlider.value = 100;
    self.weightController.selectedSegmentIndex = -1;
}

/*
 Method used to, as the weight slider is changed, to take its value and set it to the Label Text View to show the value of the slider.
 */
- (IBAction)sliderChanged:(UISlider *)sender {
    NSString *newLabelText = [[NSString alloc] initWithFormat:@"%1.2f", sender.value];
    self.sliderLabel.text = newLabelText;
}

@end
