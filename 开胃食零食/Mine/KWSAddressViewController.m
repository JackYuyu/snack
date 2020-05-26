//
//  KWSAddressViewController.m
//  开胃食
//
//  Created by haoshi on 2020/4/23.
//  Copyright © 2020 haoshi. All rights reserved.
//
#import "KWSAddressViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface KWSAddressViewController ()<CLLocationManagerDelegate>

@property (nonatomic, copy) NSString *address;
@property (strong, nonatomic)  UITextField *nameTF;
@property (strong, nonatomic)  UITextField *phoneTF;
@property (strong, nonatomic)  UITextField *addressTF;
@property (nonatomic, strong) CLLocationManager *manager;
@end

@implementation KWSAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUI];
    self.view.backgroundColor = DYWhite;
    [self setNAV];
}
- (void)setNAV {
    
    weakSelf(self)
    
    
    UILabel *rightImg = [[UILabel alloc]initWithFrame:CGRectMake(0,0, 40, 45)];
    rightImg.text = @"定位";
    rightImg.textColor = DYWhite;
    [self.navigationView addRightView:rightImg clickCallback:^(UIView *view) {
        [weakself judgeUserLocationEnabled];
        
    }];
    self.navigationView.titleLabel.text = @"添加收货地址";
}


- (void)setUI {
    
    UILabel *nameLab = [UILabel new];
    nameLab.text = @"姓  名:";
    nameLab.font = DYFont(17);
    nameLab.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:nameLab];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(15);
        make.width.mas_equalTo(90);
        make.top.mas_equalTo(self.navigationView.mas_bottom).offset(60);
    }];
    
    self.nameTF = [UITextField new];
    self.nameTF.placeholder = @"请输入收货人姓名";
    self.nameTF.font = DYFont(16);

    self.nameTF.textAlignment = NSTextAlignmentLeft;
    self.nameTF.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:self.nameTF];
    [self.nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(nameLab);
        make.left.mas_equalTo(nameLab.mas_right).offset(5);
        make.right.mas_equalTo(self.view.mas_right).offset(-15);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(nameLab.mas_bottom).offset(15);
        make.height.mas_equalTo(1);
        make.left.mas_equalTo(self.nameTF.mas_left);
        make.right.mas_equalTo(self.view);
    }];
    UILabel *phoneLab = [UILabel new];
    phoneLab.text = @"联系电话:";
    phoneLab.font = DYFont(17);
    phoneLab.textAlignment = NSTextAlignmentLeft;

    [self.view addSubview:phoneLab];
    [phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(15);
        make.top.mas_equalTo(nameLab.mas_bottom).offset(30);
        make.width.mas_equalTo(90);

    }];
    
    self.phoneTF = [UITextField new];
    self.phoneTF.placeholder = @"请输入收货联系电话";
    self.phoneTF.font = DYFont(16);
    self.phoneTF.textAlignment = NSTextAlignmentLeft;
    self.phoneTF.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:self.phoneTF];
    [self.phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(phoneLab);
        make.left.mas_equalTo(phoneLab.mas_right).offset(5);
        make.right.mas_equalTo(self.view.mas_right).offset(-15);
    }];
    UIView *line1 = [UIView new];
    line1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(phoneLab.mas_bottom).offset(15);
        make.height.mas_equalTo(1);
        make.left.mas_equalTo(self.phoneTF.mas_left);
        make.right.mas_equalTo(self.view);
    }];
    
    UILabel *addressLab = [UILabel new];
    addressLab.text = @"地  址:";
    addressLab.textAlignment = NSTextAlignmentLeft;

    addressLab.font = DYFont(17);
    [self.view addSubview:addressLab];
    [addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(15);
        make.top.mas_equalTo(phoneLab.mas_bottom).offset(30);
        make.width.mas_equalTo(90);

    }];
    
    self.addressTF = [UITextField new];
    self.addressTF.placeholder = @"请输入收货地址";
    self.addressTF.font = DYFont(16);
    self.addressTF.textAlignment = NSTextAlignmentLeft;
    self.addressTF.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:self.addressTF];
    [self.addressTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(addressLab);
        make.left.mas_equalTo(addressLab.mas_right).offset(5);
        make.right.mas_equalTo(self.view.mas_right).offset(-15);
    }];
    UIView *line2 = [UIView new];
    line2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(addressLab.mas_bottom).offset(15);
        make.height.mas_equalTo(1);
        make.left.mas_equalTo(self.addressTF.mas_left);
        make.right.mas_equalTo(self.view);
    }];
    
    UIButton *saveBtn = [UIButton new];
    saveBtn.backgroundColor = DYStyleColor;
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:DYWhite forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(60);
        make.right.mas_equalTo(self.view).offset(-60);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(addressLab.mas_bottom).offset(80);
    }];
}


- (void)saveBtn:(UIButton *)btn {
    
    if (self.nameTF.text.length >0 && self.phoneTF.text.length >10 &&
           
           self.addressTF.text.length >0 ) {
           [Userdefaults setValue:self.addressTF.text forKey:@"address"];
           [Userdefaults setValue:self.nameTF.text forKey:@"name"];
           [Userdefaults setValue:self.phoneTF.text forKey:@"phone"];
           [MBProgressHUD showSuccess:@"保存成功"];
           
       }else {
           [MBProgressHUD showMessage:@"请输入正确的收货信息"];
       }
}



- (void)judgeUserLocationEnabled {
    if ([CLLocationManager locationServicesEnabled]) {
        
        self.manager = [[CLLocationManager alloc]init];
        self.manager.delegate = self;
        self.manager.desiredAccuracy = kCLLocationAccuracyBest;
        self.manager.distanceFilter = 10.0f;
        [self.manager requestWhenInUseAuthorization];
        [self.manager startUpdatingLocation];
        
    }else{
        
        [MBProgressHUD showMessage:@"无法获取位置信息。 检查您的网络信号和位置权限"];
    }
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *location = [locations lastObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        for (CLPlacemark *placemark in placemarks) {
            
            NSDictionary *address = [placemark addressDictionary];
            self.addressTF.text = [NSString stringWithFormat:@"%@%@%@",[address objectForKey:@"State"],[address objectForKey:@"City"],[address objectForKey:@"SubLocality"]];
        }
        
    }];
    
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    UIAlertController *alterVC = [UIAlertController alertControllerWithTitle:@"定位" message:@"是否启用自动定位功能" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *settingURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication]openURL:settingURL];
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alterVC addAction:okAction];
    [alterVC addAction:cancelAction];
    [self presentViewController:alterVC animated:YES completion:nil];
}

@end
