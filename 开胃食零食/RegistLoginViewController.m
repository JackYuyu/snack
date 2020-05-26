//
//  RegistLoginViewController.m
//  开胃食
//
//  Created by haoshi on 2020/4/23.
//  Copyright © 2020 haoshi. All rights reserved.
//

#import "RegistLoginViewController.h"

@interface RegistLoginViewController ()
@property (strong, nonatomic)  UITextField *accTF;
@property (strong, nonatomic)  UITextField *pasTF;
@end

@implementation RegistLoginViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSNumber *ID = [[NSUserDefaults standardUserDefaults] valueForKey:@"id"];
    if (ID.integerValue >0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    [self.accTF becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
    self.view.backgroundColor = DYWhite;
}


- (void)setUI {
    
    UIButton *skipBtn = [UIButton new];
    [skipBtn setTitle:@" 跳过 " forState:UIControlStateNormal];
    [skipBtn setTitleColor:DYWhite forState:UIControlStateNormal];
    skipBtn.backgroundColor = [UIColor lightGrayColor];
    skipBtn.titleLabel.font = DYFont(15);
    [self.view addSubview:skipBtn];
    [skipBtn sizeToFit];
    [skipBtn addTarget:self action:@selector(skip:) forControlEvents:UIControlEventTouchUpInside];
    [skipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.top.mas_equalTo(self.view.mas_top).offset(84);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(80);
    }];
    
    skipBtn.layer.masksToBounds = YES;
    skipBtn.layer.cornerRadius = 15;
    
    self.accTF = [UITextField new];
    self.accTF.placeholder = @"请输入账号";
    self.accTF.autocapitalizationType =  UITextAutocapitalizationTypeNone;
    self.accTF.borderStyle = UITextBorderStyleRoundedRect;
    self.accTF.font = DYFont(17);
    self.accTF.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.accTF];
    [self.accTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(skipBtn.mas_bottom).offset(140);
        make.left.mas_equalTo(self.view.mas_left).offset(40);
        make.right.mas_equalTo(self.view.mas_right).offset(-40);
        make.height.mas_equalTo(40);
    }];
    
    self.pasTF = [UITextField new];
    self.pasTF.secureTextEntry = YES;
    self.pasTF.placeholder = @"请输入密码";
    self.pasTF.borderStyle = UITextBorderStyleRoundedRect;
    self.pasTF.font = DYFont(17);
    self.pasTF.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.pasTF];
    [self.pasTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.accTF.mas_bottom).offset(40);
        make.left.mas_equalTo(self.view.mas_left).offset(40);
        make.right.mas_equalTo(self.view.mas_right).offset(-40);
        make.height.mas_equalTo(40);
    }];
    
    UIButton *loginBtn = [UIButton new];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:DYWhite forState:UIControlStateNormal];
    loginBtn.titleLabel.font = DYFont(18);
    loginBtn.backgroundColor = DYStyleColor;
    [loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(60);
        make.right.mas_equalTo(self.view.mas_right).offset(-60);
        make.top.mas_equalTo(self.pasTF.mas_bottom).offset(80);
        make.height.mas_equalTo(40);
    }];
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.cornerRadius = 20;
    
    UIButton *registBtn = [UIButton new];
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registBtn setTitleColor:DYWhite forState:UIControlStateNormal];
    registBtn.titleLabel.font = DYFont(18);
    registBtn.backgroundColor = DYStyleColor;
    [registBtn addTarget:self action:@selector(regist:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registBtn];
    [registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(60);
        make.right.mas_equalTo(self.view.mas_right).offset(-60);
        make.top.mas_equalTo(loginBtn.mas_bottom).offset(30);
        make.height.mas_equalTo(40);
    }];
    
    registBtn.layer.masksToBounds = YES;
    registBtn.layer.cornerRadius = 20;
}

- (void)skip:(UIButton *)btn {
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    self.tabBarController.selectedIndex = 0 ;
}


- (void)login:(UIButton *)btn {
    if (self.accTF.text.length >0 && self.pasTF.text.length > 0) {
        
    }else {
        [MBProgressHUD showError:@"请输入正确的账号密码"];
        return;
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.pasTF.text forKey:@"upsw"];
    [dic setValue:self.accTF.text forKey:@"acc"];
    [dic setValue:ShopKey forKey:@"shopKey"];
    
    [NetHttpTool Post:UserLogin bodyParamets:dic Succeed:^(NSDictionary * _Nonnull returnData) {
        
        NSDictionary *data= returnData[@"data"];
        NSDictionary *member = data[@"member"];
        [Userdefaults setObject:self.pasTF.text forKey:@"upsw"];
        [Userdefaults setObject:self.accTF.text forKey:@"acc"];
        [Userdefaults setObject:member[@"id"] forKey:@"id"];
        
        if (member[@"id"]) {
            [MBProgressHUD showSuccess:@"登录成功"];
            
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showError:@"帐号或密码错误"];
        }
        
    } Failure:^(NSError * _Nonnull error) {
        
        [MBProgressHUD showError:@"网络错误"];
    }];
    
}

- (void)regist:(UIButton *)btn {
    if (self.accTF.text.length >0 && self.pasTF.text.length > 0) {
        
    }else {
        [MBProgressHUD showError:@"请输入正确的账号密码"];
        return;
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:ShopKey forKey:@"shopKey"];
    [dic setValue:self.accTF.text forKey:@"account"];
    [dic setValue:self.pasTF.text forKey:@"password"];
    [NetHttpTool Post:UserAdd paramets:dic Succeed:^(NSDictionary * _Nonnull returnData) {
        NSDictionary *data= returnData[@"data"];
        NSString *apiResult = [NSString stringWithFormat:@"%@",data[@"apiResult"]];
        if ([apiResult isEqualToString:@"2"]) {
            [MBProgressHUD showSuccess:@"已注册，请登录"];
            
        }else {
            
            [MBProgressHUD showSuccess:@"注册成功"];
            self.accTF.text = nil;
            self.pasTF.text = nil;
            [self.pasTF resignFirstResponder];
            [self.accTF becomeFirstResponder];
        }
        
    } Failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showError:@"网络错误"];
    }];
}

@end
