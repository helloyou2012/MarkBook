//
//  AddMarkViewController.h
//  MarkBook
//
//  Created by ZhenzhenXu on 11/10/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#define TO_BOOK_MARK_LIST_IDENTIFIER @"ToBookMarkList"

#import <UIKit/UIKit.h>
#import "Book.h"

@interface AddMarkViewController : UIViewController<UINavigationControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *mimage;
@property (weak, nonatomic) IBOutlet UITextField *curPage;

@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (nonatomic, retain) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, retain) Book *book;

@property (nonatomic,strong) UIImagePickerController *imagePicker;
- (IBAction)takePhoto:(id)sender;
@property (nonatomic,strong) UIImage *img;
- (IBAction)takeMark:(id)sender;
- (IBAction)backPressed:(id)sender;
@end
