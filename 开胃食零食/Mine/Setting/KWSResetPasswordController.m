
//
//  KWSResetPasswordController.m
//  YanBei
//
//  Created by qq on 2020/3/31.
//  Copyright © 2020 bei. All rights reserved.
//

#import "KWSResetPasswordController.h"

@interface KWSResetPasswordController ()
@property (nonatomic, strong) UITextField *oldTF;
@property (nonatomic, strong) UITextField *nTF;
@property (nonatomic, strong) UITextField *againTF;
@end

@implementation KWSResetPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
    self.view.backgroundColor = DYBGColor;
    weakSelf(self)
    
    
    UILabel *rightImg = [[UILabel alloc]initWithFrame:CGRectMake(0,0, 80, 45)];
    rightImg.text = @"保存";
    rightImg.textColor = DYWhite;
    [self.navigationView addRightView:rightImg clickCallback:^(UIView *view) {
        [weakself save];
        
    }];
}

-(void)setUI {
    
    self.navigationView.titleLabel.text = @"修改密码";
    self.oldTF = [UITextField new];
    self.oldTF.backgroundColor  =DYWhite;
    self.oldTF.placeholder = @"请输入原密码";
    self.oldTF.font = DYFont(16);
    [self.view addSubview:self.oldTF];
    [self.oldTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.top.mas_equalTo(self.navigationView.mas_bottom).offset(50);
        make.height.mas_equalTo(40);
    }];
    
    
    self.nTF = [UITextField new];
    self.nTF.backgroundColor  =DYWhite;
    self.nTF.placeholder = @"请输入新密码";
    self.nTF.font = DYFont(16);
    [self.view addSubview:self.nTF];
    [self.nTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.top.mas_equalTo(self.oldTF.mas_bottom).offset(40);
        make.height.mas_equalTo(40);
    }];
    
    
    self.againTF = [UITextField new];
    self.againTF.backgroundColor  =DYWhite;
    self.againTF.placeholder = @"请再次输入新密码";
    self.againTF.font = DYFont(16);
    [self.view addSubview:self.againTF];
    [self.againTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.top.mas_equalTo(self.nTF.mas_bottom).offset(40);
        make.height.mas_equalTo(40);
    }];
    
    
    
}

- (void)save {
    
    NSString *psd = [Userdefaults valueForKey:@"upsw"];
    if (![self.oldTF.text isEqualToString:psd]) {
        [MBProgressHUD showMessage:@"原始密码不正确"];
        return;
    }
    if (self.nTF.text.length <= 0 || self.againTF.text.length <= 0) {
        [MBProgressHUD showMessage:@"密码不能为空"];
        return;
    }
    if (![self.nTF.text isEqualToString:self.againTF.text]) {
        [MBProgressHUD showMessage:@"两个新密码不一致"];
        return;
    }
    NSDictionary *paramet = @{
                                  @"oldPsw":self.oldTF.text,
                                  @"newPsw" : self.nTF.text
                                  
                                  };
        
    [NetHttpTool Post:@"/api/pub/member/changePassword" bodyParamets:paramet Succeed:^(NSDictionary * _Nonnull returnData) {
        
        if ([returnData[@"data"][@"apiResult"] intValue] == 1) {
            
            [Userdefaults setObject:self.nTF.text forKey:@"upsw"];
            [Userdefaults synchronize];

            [MBProgressHUD showSuccess:@"修改成功"];
        }else{
            [MBProgressHUD showError:@"修改失败"];
        }
        
    } Failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showError:@"网络错误，修改失败"];
    }];
    
}

@end

