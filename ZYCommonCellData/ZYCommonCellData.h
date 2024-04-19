//
//  ZYCommonCellData.h
//  YNFCGJ
//
//  Created by XUZY on 2022/6/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ZYCellDataCallbackKey)(NSString *key);
typedef void (^ZYCellDataCallbackKeyValue)(NSString *key, id value);
@interface ZYCellData : NSObject
@property (nonatomic, strong, nullable) NSString *identifier;
@property (nonatomic, strong, nullable) Class cellClass;
@property (nonatomic, strong, nullable) id obj;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, strong, nullable) ZYCellDataCallbackKey rValueCallback;
@property (nonatomic, strong, nullable) ZYCellDataCallbackKeyValue sValueCallback;

//快速链式操作
@property (nonatomic, strong) ZYCellData * (^sIdentifier)(NSString *identifier);
@property (nonatomic, strong) ZYCellData * (^sCellClass)(Class cellClass);
@property (nonatomic, strong) ZYCellData * (^sObj)(id obj);
@property (nonatomic, strong) ZYCellData * (^sValue)(NSString *key, id value);
@property (nonatomic, strong) ZYCellData * (^sSValueCallback)(ZYCellDataCallbackKeyValue sValueCallback); //.sSValueCallback(^void(NSString *key, id value) {});
@property (nonatomic, strong) id (^gValue)(NSString *key);
@property (nonatomic, strong) ZYCellData * (^rValue)(NSString *key);
@property (nonatomic, strong) ZYCellData * (^sRValueCallback)(ZYCellDataCallbackKey rValueCallback);//.sRValueCallback(^void(NSString *key) {});
@property (nonatomic, strong) ZYCellData * (^sSelected)(BOOL selected);
@end

@interface ZYSectionData : NSObject
@property (nonatomic, strong) NSMutableArray *rows;
@property (nonatomic, assign) BOOL isAlone; //是否单独的一个section，即section之间需不需要间距
@end

NS_ASSUME_NONNULL_END
