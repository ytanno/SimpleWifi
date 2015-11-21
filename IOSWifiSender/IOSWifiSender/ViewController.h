//
//  ViewController.h
//  IOSWifiSender
//
//  Created by tanno on 2015/11/21.
//  Copyright © 2015年 tanno. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *LedLabel;

- (IBAction)ChangeSC:(UISegmentedControl *)sender;

@end

