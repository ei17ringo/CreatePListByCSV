//
//  ViewController.h
//  CreatePListByCSV
//
//  Created by Eriko Ichinohe on 2014/11/28.
//  Copyright (c) 2014年 Eriko Ichinohe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *createPList;
- (IBAction)startCreatingPList:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *pathTextView;

@end

