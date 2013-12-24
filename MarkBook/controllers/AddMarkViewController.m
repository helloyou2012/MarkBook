//
//  AddMarkViewController.m
//  MarkBook
//
//  Created by ZhenzhenXu on 11/10/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import "AddMarkViewController.h"
#import "UIButton+WebCache.h"
#import "SVProgressHUD.h"
#import "CoreDataEnvir.h"
#import "BookMarks.h"
#import "Book.h"

@implementation AddMarkViewController

@synthesize mimage=_mimage;
@synthesize cancelButton=_cancelButton;
@synthesize okButton=_okButton;
@synthesize curPage=_curPage;
@synthesize book=_book;
@synthesize imagePicker;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    } else {
        // iOS 6
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
    self.view.backgroundColor=[UIColor colorWithWhite:0.96f alpha:1.0f];
    
    // 设置圆角半径
    _cancelButton.layer.masksToBounds = YES;
    _cancelButton.layer.cornerRadius = 14;
    //还可设置边框宽度和颜色
    _cancelButton.layer.borderWidth = 1;
    _cancelButton.layer.borderColor = [UIColor blueColor].CGColor;
    
    // 设置圆角半径
    _okButton.layer.masksToBounds = YES;
    _okButton.layer.cornerRadius = 14;
    //还可设置边框宽度和颜色
    _okButton.layer.borderWidth = 1;
    _okButton.layer.borderColor = [UIColor blueColor].CGColor;
    
    _curPage.font=[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:70];
    _curPage.textColor=[UIColor blueColor];
    
	// Do any additional setup after loading the view.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_curPage becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backPressed:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            if ([[actionSheet buttonTitleAtIndex:buttonIndex]isEqualToString:@"拍照"]) {
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:imagePicker animated:YES completion:nil];
            }
            break;
        case 1:
            if ([[actionSheet buttonTitleAtIndex:buttonIndex]isEqualToString:@"用户相册"]) {
                imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [self presentViewController:imagePicker animated:YES completion:nil];
            }
            //确定上传头像
            break;
        case 2:
            if ([[actionSheet buttonTitleAtIndex:buttonIndex]isEqualToString:@"取消"]) {
                
            }
            break;
        default:
            break;
    }
}
#pragma mark    imagePicker委托方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];//原图
    self.img=[self imageWithImage:image scaledToWidth:640.0f];
    [self.photo setImage:self.img];
}
- (IBAction)takePhoto:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        //支持相册和照相
        imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        
        [imagePicker setAllowsEditing:YES];
        UIActionSheet *photoSheet = [[UIActionSheet alloc] initWithTitle:@"请选择图片来源"
                                                                delegate:self
                                                       cancelButtonTitle:@"取消"
                                                  destructiveButtonTitle:nil
                                                       otherButtonTitles:@"拍照", @"用户相册",nil];
        
        
        photoSheet.actionSheetStyle=UIActionSheetStyleDefault;
        [photoSheet showInView:self.view];
    }else if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary]){
        imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        [imagePicker setAllowsEditing:YES];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Error accessing photo library!" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [alert show];
        
    }
    
}

- (IBAction)takeMark:(id)sender {
    NSString *page = self.curPage.text;
    if (!page || [page isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请输入当前页码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }else{
        [self storeMark];
    }
}

-(void)storeMark{
    NSNumber *page = [NSNumber numberWithInt:[[self.curPage text] intValue]];
    if ([page intValue] > [_book.pageNum intValue]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"页码超出范围" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    NSDate *now = [NSDate date];
    NSData* p = UIImagePNGRepresentation(self.img);
    
    [self.book setCurPage:page];
    BookMarks *mark =[BookMarks insertItem];
    [mark setDataWithLatitude:nil Longitude:nil MarkTime:now Mid:self.book.isbn Page:page Photo:p Book:self.book];
    [_book addMarksObject:mark];
    [[CoreDataEnvir mainInstance] saveDataBase];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage*)imageWithImage:(UIImage*)image
              scaledToWidth:(CGFloat)newWidth
{
    CGFloat newHeight=newWidth*image.size.height/image.size.width;
    UIGraphicsBeginImageContext( CGSizeMake(newWidth, newHeight) );
    [image drawInRect:CGRectMake(0,0,newWidth,newHeight)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
