//
//  CAMViewController.m
//  ECard
//
//  Created by Chris Meehan on 4/2/14.
//  Copyright (c) 2014 Chris Meehan. All rights reserved.
//

#import "CAMViewController.h"
#import "MyCustomEmailer.h"

@interface CAMViewController ()<UITextFieldDelegate,MFMailComposeViewControllerDelegate>{
    float lastYRecorded;
    NSDate* timeSinceLastSwipe;
}

@property (weak, nonatomic) IBOutlet UIImageView *uIIView;
@property (weak, nonatomic) IBOutlet UITextField *uITField;
- (IBAction)dismissKeyboard:(id)sender;
@end

@implementation CAMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    timeSinceLastSwipe = [NSDate date];
    
    self.uITField.delegate = self;
    
    self.uIIView.layer.shadowOpacity = 0.7;
    self.uIIView.layer.shadowOffset = CGSizeMake(-17, 18);
    self.uIIView.layer.cornerRadius = 2; // if you like rounded corners
    self.uIIView.layer.shadowRadius = 7;

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];
    lastYRecorded = touchLocation.y;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    


        [UIView animateWithDuration:0.1 animations:^{
            [self.uIIView setFrame:CGRectMake(0, -40-self.view.frame.size.height, self.view.frame.size.width+1, 438)];
            
        }];
        
        [self cardWasThrown];

}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if([timeSinceLastSwipe timeIntervalSinceNow] < -0.5){

        UITouch *touch = [[event allTouches] anyObject];
        CGPoint touchLocation = [touch locationInView:self.view];
        
        float changeInY = touchLocation.y - lastYRecorded;
        CGRect theRect =  self.uIIView.frame;
        theRect.origin.y = theRect.origin.y + changeInY;
        
        [self.uIIView setFrame:theRect];
        lastYRecorded = touchLocation.y;

    }
}

-(void)unhideTheCard{
    [self.uIIView setHidden:NO];
    [self.uIIView setFrame:CGRectMake(0, 0, self.view.frame.size.width+1, 438)];
}

-(void)mailComposeController:(MFMailComposeViewController *) controller didFinishWithResult:(MFMailComposeResult) result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultCancelled:
            break;
            
        case MFMailComposeResultSaved:
            break;
            
        case MFMailComposeResultSent:
            break;
            
        case MFMailComposeResultFailed:
            break;
            
        default:
            break;
    }
    
    //Dismiss the mailViewController.
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (NSUInteger)supportedInterfaceOrientations
{
    return (UIInterfaceOrientationMaskPortrait);
}

-(void)emailTheCard{
    NSLog(@"card emailed");
    
    MyCustomEmailer* controller = [[MyCustomEmailer alloc] init];
    controller.mailComposeDelegate = self;
    [controller setToRecipients:[NSArray arrayWithObject:self.uITField.text]];
    [controller setSubject:@"Christopher Meehan - iOS,Java,C++"];
    [controller setMessageBody:@"Here is my electronic business card.\n \n Cheers!" isHTML:NO];
    
    NSData *imageData = UIImageJPEGRepresentation([UIImage imageNamed:@"ECard.jpg"], 1.0);

    [controller addAttachmentData:imageData mimeType:@"image/jpeg" fileName:[NSString stringWithFormat:@"ECard.jpg"]];
    
    [self presentViewController:controller animated:NO completion:nil];
}

- (IBAction)dismissKeyboard:(id)sender {
    [self.uITField resignFirstResponder];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    //Keyboard becomes visible
    self.uITField.frame = CGRectMake(8,
                                  224,
                                  301,
                                  30);   //resize
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    //keyboard will hide
    self.uITField.frame = CGRectMake(8,
                                     444,
                                     301,
                                     30);   //resize
}

-(void)cardWasThrown{
    //email it, and reset whatever.
    timeSinceLastSwipe = [NSDate date];
    NSLog(@"we are officially NOT moving the card");


    if(![self.uITField.text isEqualToString:@""]){
        [self emailTheCard];
    }
    self.uITField.text = @"";

    
    [NSTimer scheduledTimerWithTimeInterval:(0.5) target:self selector:@selector(unhideTheCard) userInfo:nil repeats:NO];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
