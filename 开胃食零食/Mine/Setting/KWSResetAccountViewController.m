//
//  KWSResetAccountViewController.m
//  YanBei
//
//  Created by qq on 2020/3/31.
//  Copyright © 2020 bei. All rights reserved.
//

#import "KWSResetAccountViewController.h"
#import "KWSResetPasswordController.h"

@interface KWSResetAccountViewController ()
<TZImagePickerControllerDelegate>
@property (strong, nonatomic)  UIButton *iconBtn;

@property (strong, nonatomic)  UITextField *nickTF;
@end

@implementation KWSResetAccountViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSData *data = [[NSUserDefaults standardUserDefaults]valueForKey:@"icon"];
    if (data) {
        UIImage *img = [[UIImage alloc]initWithData:data];
        [self.iconBtn setBackgroundImage:img forState:UIControlStateNormal];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = DYWhite;
    [self setNAV];
    [self setUI];
}

- (void)setNAV {
    
    weakSelf(self)
    
    
    UILabel *rightImg = [[UILabel alloc]initWithFrame:CGRectMake(0,0, 80, 45)];
    rightImg.text = @"保存";
    rightImg.textColor = DYWhite;
    [self.navigationView addRightView:rightImg clickCallback:^(UIView *view) {
        if (weakself.nickTF.text.length>0) {
            [Userdefaults setValue:weakself.nickTF.text forKey:@"nickName"];
            [weakself.navigationController popViewControllerAnimated:YES];
        }else {
            [weakself.navigationController popViewControllerAnimated:YES];
            
        }
        
    }];
    self.navigationView.titleLabel.text = @"账号设置";
}

- (void)setUI {
    UILabel *photoLab = [UILabel new];
    photoLab.text= @"头像";
    photoLab.font = [UIFont systemFontOfSize:17 weight:1];
    [self.view addSubview:photoLab];
    [photoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(30);
        make.top.mas_equalTo(self.navigationView.mas_bottom).offset(60);
//        make.width.mas_equalTo(60);
    }];
    
    self.iconBtn = [UIButton new];
    [self.iconBtn setBackgroundImage:[UIImage imageNamed:@"touxiang"] forState:UIControlStateNormal];
    [self.view addSubview:self.iconBtn];
    [self.iconBtn addTarget:self action:@selector(addPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [self.iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.centerY.mas_equalTo(photoLab);
    }];
    self.iconBtn.layer.cornerRadius = 20;
    self.iconBtn.layer.masksToBounds = YES;
    UIView *line = [UIView new];
    line.backgroundColor =[UIColor groupTableViewBackgroundColor];
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SW, 1));
        make.left.mas_equalTo(self.view);
        make.top.mas_equalTo(photoLab.mas_bottom).offset(8);
    }];
    
    UILabel *nickLab = [UILabel new];
    nickLab.text= @"昵称：";
    nickLab.font = [UIFont systemFontOfSize:17 weight:1];
    [self.view addSubview:nickLab];
    [nickLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(30);
        make.top.mas_equalTo(photoLab.mas_bottom).offset(30);
//        make.width.mas_equalTo(60);
    }];
                                                         
        
    self.nickTF = [UITextField new];
    self.nickTF.placeholder = @"请输入昵称";
    self.nickTF.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:self.nickTF];
    [self.nickTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nickLab.mas_right).offset(10);
        make.right.mas_equalTo(self.view.mas_right).offset(-10);
        make.centerY.mas_equalTo(nickLab.mas_centerY);
        make.height.mas_equalTo(30);
    }];
    
    UIView *line1 = [UIView new];
    line1.backgroundColor =[UIColor groupTableViewBackgroundColor];
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SW, 1));
        make.left.mas_equalTo(self.view);
        make.top.mas_equalTo(nickLab.mas_bottom).offset(8);
    }];
    
    UILabel *resetLab = [UILabel new];
    resetLab.text= @"修改密码";
    resetLab.font = [UIFont systemFontOfSize:17 weight:1];
    [self.view addSubview:resetLab];
    [resetLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(30);
        make.top.mas_equalTo(nickLab.mas_bottom).offset(30);
//        make.width.mas_equalTo(60);
    }];
    
    UIButton *restBtn = [UIButton new];
   
    [restBtn addTarget:self action:@selector(reset) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:restBtn];
    [restBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(resetLab);
    }];
    
}

- (void)addPhoto:(UIButton *)btn {
    
    weakSelf(self)
    
    TZImagePickerController *pick = [[TZImagePickerController alloc]initWithMaxImagesCount:1 delegate:self];
    pick.allowCameraLocation = NO;
    pick.allowTakePicture = NO;
    pick.allowTakeVideo = NO;
    [pick setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        if (photos.lastObject) {
            NSData *data = UIImagePNGRepresentation(photos.lastObject);
            [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"icon"];
            
            [weakself.iconBtn setBackgroundImage:photos.lastObject forState:UIControlStateNormal];
        }
    }];
    [self.navigationController presentViewController:pick animated:YES completion:nil];
    
}

- (void)reset{
    
    [self.navigationController pushViewController:[KWSResetPasswordController new] animated:YES];
}

@end
