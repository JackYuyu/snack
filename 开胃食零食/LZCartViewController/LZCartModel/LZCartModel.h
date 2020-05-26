//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KWSGoodsModel.h"
@interface LZCartModel : NSObject
//自定义模型时,这三个属性必须有
@property (nonatomic,assign) BOOL select;
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,copy) NSString *price;
//下面的属性可根据自己的需求修改
@property (nonatomic,copy) NSString *sizeStr;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *dateStr;
@property (nonatomic,copy) NSString *url;

@property (nonatomic,retain)UIImage *image;
//
@property(nonatomic,strong) KWSGoodsModel *goods;
@property (nonatomic, copy) NSString *createTime;

@property(nonatomic,copy) NSString *ID;

@end
