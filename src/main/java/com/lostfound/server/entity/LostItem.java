package com.lostfound.server.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.List;

/**
 * 失物招领实体类
 * 
 * 对应数据库表：lost_items
 * 
 * @author 系统开发团队
 * @version 1.0
 */
@Data
@TableName("lost_items")
public class LostItem {
    
    /**
     * 主键ID
     */
    private Long id;
    
    /**
     * 物品名称
     */
    @TableField("item_name")
    private String itemName;
    
    /**
     * 物品描述
     */
    private String description;
    
    /**
     * 类别ID
     */
    @TableField("category_id")
    private Long categoryId;
    
    /**
     * 丢失地点
     */
    @TableField("lost_location")
    private String lostLocation;
    
    /**
     * 丢失时间
     */
    @TableField("lost_time")
    private String lostTime;
    
    /**
     * 联系方式
     */
    @TableField("contact_info")
    private String contactInfo;
    
    /**
     * 状态：LOST-丢失中，FOUND-已找到，RETURNED-已归还
     */
    private String status;
    
    /**
     * 图片列表，以JSON字符串形式存储
     */
    @TableField("item_images")
    private String itemImages;
    
    /**
     * 创建者ID
     */
    @TableField("creator_id")
    private Long creatorId;
    
    /**
     * 创建时间
     */
    @TableField("created_time")
    private String createdTime;
    
    /**
     * 更新时间
     */
    @TableField("updated_time")
    private String updateTime;
    
    /**
     * 创建者姓名（非数据库字段）
     */
    @TableField(exist = false)
    private String creatorName;
    
    /**
     * 类别名称（非数据库字段）
     */
    @TableField(exist = false)
    private String categoryName;
    
    /**
     * 获取图片列表
     * 
     * @return 图片URL列表
     */
    public List<String> getImageList() {
        if (itemImages == null || itemImages.isEmpty()) {
            return List.of();
        }
        
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            return objectMapper.readValue(itemImages, new TypeReference<List<String>>() {});
        } catch (JsonProcessingException e) {
            return List.of();
        }
    }
    
    /**
     * 设置图片列表
     * 
     * @param imageList 图片URL列表
     */
    public void setImageList(List<String> imageList) {
        if (imageList == null || imageList.isEmpty()) {
            this.itemImages = "[]";
            return;
        }
        
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            this.itemImages = objectMapper.writeValueAsString(imageList);
        } catch (JsonProcessingException e) {
            this.itemImages = "[]";
        }
    }
}