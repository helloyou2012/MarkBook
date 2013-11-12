//
//  AddMarkViewController.m
//  MarkBook
//
//  Created by ZhenzhenXu on 11/10/13.
//  Copyright (c) 2013 ZhenzhenXu. All rights reserved.
//

#import "AddMarkViewController.h"
#import "UIButton+WebCache.h"
#import "AppDelegate.h"
#import "BookMarks.h"

@implementation AddMarkViewController

@synthesize mimage=_mimage;
@synthesize curPage=_curPage;
@synthesize managedObjectContext=_managedObjectContext;
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
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _managedObjectContext=[appDelegate managedObjectContext];
    
    [_curPage becomeFirstResponder];
	// Do any additional setup after loading the view.
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
//                [self presentModalViewController:imagePicker animated:YES];
            } else {
                //确定重新加载头像
            }
            
            break;
        case 1:
            if ([[actionSheet buttonTitleAtIndex:buttonIndex]isEqualToString:@"用户相册"]) {
                imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [self presentViewController:imagePicker animated:YES completion:nil];

//                [self presentModalViewController:imagePicker animated:YES];
            } else {
                //确定上传头像
            }
            //确定上传头像
            break;
        case 2:
            if ([[actionSheet buttonTitleAtIndex:buttonIndex]isEqualToString:@"取消"]) {
                
            } else {
                //确定绑定邮箱
            }
            break;
        default:
            break;
    }
}
#pragma mark    imagePicker委托方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
//    [self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];//原图
    self.img = image;
    [self.photo setImage:image];
}
- (IBAction)takePhoto:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {//支持相册和照相
        
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
    }
    else if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary])
    {
        imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        [imagePicker setAllowsEditing:YES];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
//
//        [self presentModalViewController:imagePicker animated:YES];
        //    [self.view addSubview:imagePicker.view];
    }
    else
    {
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
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _managedObjectContext=[appDelegate managedObjectContext];
    NSError *saveError = nil;
    BookMarks *mark =[NSEntityDescription insertNewObjectForEntityForName:@"BookMarks" inManagedObjectContext:_managedObjectContext];
    
    NSNumber *page = [NSNumber numberWithInt:[[self.curPage text] intValue]];
    NSDate *now = [NSDate dateWithTimeIntervalSinceNow:0];
    NSData*p = UIImagePNGRepresentation(self.img);
    [mark setDataWithLatitude:nil Longitude:nil MarkTime:now Mid:self.book.isbn Page:page Photo:p Book:self.book];
    self.book.curPage = page;
    [_managedObjectContext save:&saveError];
//    [self performSegueWithIdentifier:TO_BOOK_MARK_LIST_IDENTIFIER sender:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
