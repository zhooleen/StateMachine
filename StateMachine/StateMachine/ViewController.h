//
//  ViewController.h
//  StateMachine
//
//  Created by lzhu on 7/4/16.
//  Copyright © 2016 redeight. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *label;

@property (weak, nonatomic) IBOutlet UIView *colorView;

- (IBAction)triggerEvent1:(id)sender;

- (IBAction)triggerEvent2:(id)sender;

- (IBAction)triggerEvent3:(id)sender;

@end

