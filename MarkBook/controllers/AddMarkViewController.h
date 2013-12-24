//
//  AddMarkViewController.h
//  MarkBook
//
//  Created by ZhenzhenXu on 11/10/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#define TO_BOOK_MARK_LIST_IDENTIFIER @"ToBookMarkList"

#import <UIKit/UIKit.h>

@class Book;
@class BookMarks;
@class CoreDataEnvir;

@interface AddMarkViewController : UIViewController<UINavigationControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong) IBOutlet UIButton *mimage;
@property (nonatomic, strong) IBOutlet UIButton *cancelButton;
@property (nonatomic, strong) IBOutlet UIButton *okButton;
@property (nonatomic, strong) IBOutlet UITextField *curPage;
@property (nonatomic, strong) IBOutlet UIImageView *photo;
@property (nonatomic, strong) UIImage *img;
@property (nonatomic, retain) Book *book;
@property (nonatomic, strong) UIImagePickerController *imagePicker;

- (IBAction)takePhoto:(id)sender;
- (IBAction)takeMark:(id)sender;
- (IBAction)backPressed:(id)sender;
- (UIImage*)imageWithImage:(UIImage*)image
             scaledToWidth:(CGFloat)newWidth;
@end
