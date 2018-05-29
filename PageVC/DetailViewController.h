//
//  DetailViewController.h
//  PageVC
//
//  Created by Lina on 16/4/28.
//  Copyright © 2016年 Lina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageVC-Swift.h"
@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

