/*
Navicat MySQL Data Transfer

Source Server         : 我的阿里云
Source Server Version : 50722
Source Host           : 39.105.124.108:3306
Source Database       : perfume

Target Server Type    : MYSQL
Target Server Version : 50722
File Encoding         : 65001

Date: 2018-09-23 16:29:35
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for account
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(50) NOT NULL,
  `mobile` varchar(20) NOT NULL,
  `realName` varchar(255) NOT NULL,
  `createTime` bigint(20) DEFAULT NULL COMMENT '时间戳：创建时间',
  `creator` varchar(255) NOT NULL COMMENT '创建人',
  PRIMARY KEY (`id`),
  KEY `IDX_USERNAME` (`username`(50)),
  KEY `IDX_MOBILE` (`mobile`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='账户表';

-- ----------------------------
-- Table structure for account_relation_permission
-- ----------------------------
DROP TABLE IF EXISTS `account_relation_permission`;
CREATE TABLE `account_relation_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `accountId` bigint(20) NOT NULL,
  `permission` varchar(255) NOT NULL COMMENT '权限： 存储格式为: 1,2,3,4,5,6',
  `createTime` bigint(20) DEFAULT NULL COMMENT '时间戳：创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='账户权限';

-- ----------------------------
-- Table structure for advertise
-- ----------------------------
DROP TABLE IF EXISTS `advertise`;
CREATE TABLE `advertise` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '广告ID',
  `accountId` bigint(20) NOT NULL COMMENT '广告所属的用户,关联account表中的id',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '广告名称',
  `type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '广告类型:1.图片,2,视频',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '广告描述',
  `body` text COMMENT '广告内容暂时用一个大的json串来保存',
  `createTime` bigint(20) NOT NULL COMMENT '创建时间',
  `status` tinyint(4) DEFAULT '1' COMMENT '广告状态： 1：未发布，2：已发布',
  PRIMARY KEY (`id`),
  KEY `IDX_ACCOUNTID` (`accountId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='广告表';

-- ----------------------------
-- Table structure for device
-- ----------------------------
DROP TABLE IF EXISTS `device`;
CREATE TABLE `device` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '设备id',
  `name` varchar(255) NOT NULL COMMENT '设备名称',
  `SN` char(50) NOT NULL DEFAULT '' COMMENT '设备SN',
  `boxCount` int(11) DEFAULT '30' COMMENT '仓位数量',
  `createTime` bigint(20) NOT NULL COMMENT '创建时间',
  `status` tinyint(4) DEFAULT '1' COMMENT '设备状态：1：未激活，2：已激活使用中:3：已禁用',
  `province` int(11) DEFAULT NULL COMMENT '省id',
  `proviceName` varchar(255) DEFAULT '' COMMENT '省名称',
  `city` int(11) DEFAULT NULL COMMENT '城市id',
  `cityName` varchar(50) DEFAULT '' COMMENT '市名city_name称',
  `county` int(11) DEFAULT NULL COMMENT '县区id',
  `countyName` varchar(255) DEFAULT '' COMMENT '县区名称',
  `detailAddress` varchar(255) DEFAULT '' COMMENT '详细地址',
  PRIMARY KEY (`id`),
  KEY `IDX_SN` (`SN`(20)) COMMENT 'SN索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='设备表';

-- ----------------------------
-- Table structure for device_box
-- ----------------------------
DROP TABLE IF EXISTS `device_box`;
CREATE TABLE `device_box` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `deviceId` bigint(20) NOT NULL COMMENT '设备id',
  `goodsId` bigint(20) NOT NULL COMMENT '香水id',
  `store` int(11) NOT NULL COMMENT '仓位中的存量',
  PRIMARY KEY (`id`),
  KEY `IDX_DEVICEID` (`deviceId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='设备的仓位表';

-- ----------------------------
-- Table structure for device_goods_operate_history
-- ----------------------------
DROP TABLE IF EXISTS `device_goods_operate_history`;
CREATE TABLE `device_goods_operate_history` (
  `id` bigint(20) NOT NULL,
  `deviceId` bigint(20) NOT NULL COMMENT '设备id',
  `boxId` bigint(20) NOT NULL COMMENT '设备所对应的仓位id',
  `goodsId` bigint(20) NOT NULL COMMENT '香水id',
  `operator` bigint(20) NOT NULL COMMENT '设备所属的用户id',
  `operateType` tinyint(4) NOT NULL COMMENT '1添加,2修改,3清空',
  `operateNote` varchar(30) DEFAULT NULL COMMENT '操作备注',
  `operateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='向设备中添加商品的记录表';

-- ----------------------------
-- Table structure for device_relation_account
-- ----------------------------
DROP TABLE IF EXISTS `device_relation_account`;
CREATE TABLE `device_relation_account` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '设备id',
  `deviceId` bigint(20) NOT NULL COMMENT '设备id',
  `accountId` bigint(20) NOT NULL COMMENT '设备所属的用户id',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态：1：正常，2：删除',
  PRIMARY KEY (`id`),
  KEY `IDX_ACCOUNTID_STATUS` (`accountId`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='设备关联用户表';

-- ----------------------------
-- Table structure for order_goods
-- ----------------------------
DROP TABLE IF EXISTS `order_goods`;
CREATE TABLE `order_goods` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `orderId` bigint(20) NOT NULL COMMENT '订单id，关联order表中的id',
  `goodsId` bigint(20) NOT NULL COMMENT '商品id',
  `goodsPrice` double(10,3) NOT NULL COMMENT '商品单价',
  `goodsNum` int(11) NOT NULL COMMENT '商品数量',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '记录的状态：1:正常,2:作废',
  PRIMARY KEY (`id`),
  KEY `IDX_ORDERID` (`orderId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单商品表';

-- ----------------------------
-- Table structure for payment_log
-- ----------------------------
DROP TABLE IF EXISTS `payment_log`;
CREATE TABLE `payment_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `orderNumber` varchar(100) NOT NULL COMMENT '订单编号，关联order表',
  `payMoney` decimal(10,2) DEFAULT NULL COMMENT '支付金额',
  `payWay` tinyint(4) DEFAULT '1' COMMENT '支付方式：1,微信,2支付宝',
  `result` tinyint(4) DEFAULT NULL COMMENT '响应结果：1：支付成功,2：支付失败',
  `reason` varchar(50) DEFAULT NULL COMMENT '失败原因',
  `msgCode` varchar(30) DEFAULT NULL COMMENT '错误码',
  `comment` varchar(100) DEFAULT NULL COMMENT '备注',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `IDX_ORDERNUMBER` (`orderNumber`(30))
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='调用第三方支付接口的日志记录表';

-- ----------------------------
-- Table structure for perfume
-- ----------------------------
DROP TABLE IF EXISTS `perfume`;
CREATE TABLE `perfume` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '香水名称',
  `brandId` bigint(20) NOT NULL COMMENT '品牌ID关联perfume_brand表中的id',
  `brandName` varchar(255) NOT NULL COMMENT '品牌名称',
  `accountId` bigint(20) NOT NULL COMMENT '香水所属的用户,关联account表中的id',
  `coverImg` varchar(1000) DEFAULT NULL COMMENT '封面图片url',
  `publishTime` bigint(20) DEFAULT NULL COMMENT '上市时间',
  `createTime` bigint(20) DEFAULT NULL COMMENT '创建时间',
  `singlePrice` double DEFAULT NULL COMMENT '喷单次的价格',
  `expandCount` int(11) DEFAULT '30' COMMENT '一瓶香水能喷多少次',
  PRIMARY KEY (`id`),
  KEY `IDX_NAME` (`name`(50)) COMMENT '名称索引',
  KEY `IDX_BRANDID` (`brandId`) COMMENT '品牌id索引',
  KEY `IDX_BRANDNAME` (`brandName`(30)) COMMENT '品牌名称索引',
  KEY `IDX_ACCOUNTID` (`accountId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='香水表';

-- ----------------------------
-- Table structure for perfume_brand
-- ----------------------------
DROP TABLE IF EXISTS `perfume_brand`;
CREATE TABLE `perfume_brand` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '品牌id',
  `name` varchar(255) NOT NULL COMMENT '品牌名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='香水品牌表';

-- ----------------------------
-- Table structure for purchase_perfume_record
-- ----------------------------
DROP TABLE IF EXISTS `purchase_perfume_record`;
CREATE TABLE `purchase_perfume_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `perfumeId` bigint(20) NOT NULL COMMENT '香水id',
  `count` int(11) NOT NULL COMMENT '购买数量',
  `cost` double(10,3) NOT NULL COMMENT '总花费,总共10位数字,其中3是小数点之后的位数：单位是元',
  `creatTime` bigint(20) NOT NULL COMMENT '时间',
  `accountId` bigint(20) NOT NULL COMMENT '购买用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='香水采购表';

-- ----------------------------
-- Table structure for t_order
-- ----------------------------
DROP TABLE IF EXISTS `t_order`;
CREATE TABLE `t_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `orderNumber` varchar(100) NOT NULL COMMENT '订单编号',
  `deviceId` bigint(20) NOT NULL COMMENT '设备id',
  `deviceSN` char(50) NOT NULL DEFAULT '' COMMENT '设备SN',
  `boxId` bigint(20) NOT NULL COMMENT '仓位id',
  `accountId` bigint(20) NOT NULL COMMENT '设备的用户id',
  `customer` varchar(255) NOT NULL COMMENT '消费者信息',
  `payPrice` decimal(20,2) NOT NULL COMMENT '实际的支付价格',
  `isPay` tinyint(4) NOT NULL DEFAULT '1' COMMENT '是否支付：1:未支付,2:完成支付',
  `payTime` bigint(20) NOT NULL COMMENT '支付时间',
  `payment_type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '支付方式：1:微信支付,2:Alipay',
  `tradeNo` varchar(255) NOT NULL COMMENT '订单流水号',
  `createTime` bigint(20) NOT NULL COMMENT '创建时间',
  `updateTime` bigint(20) NOT NULL COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '订单状态：1:正常,2:作废',
  PRIMARY KEY (`id`),
  KEY `IDX_DEVICESN` (`deviceSN`(20)),
  KEY `IDX_ORDERNUMBER` (`orderNumber`(50))
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单表';
