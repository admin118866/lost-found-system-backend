# 景区失物招领系统后端

## 项目简介
景区失物招领系统后端是一个基于Spring Boot的Java后端服务，旨在解决景区内游客丢失物品的问题，提供失物登记、认领管理、数据统计等功能，帮助景区工作人员更高效地管理失物信息，提升游客体验。

## 技术栈
- **后端框架**：Spring Boot 2.7.6
- **持久层**：MyBatis Plus 3.5.3.1
- **数据库**：MySQL 8.0+
- **缓存**：Redis 5.0+
- **认证**：JWT (JSON Web Token)
- **API文档**：SpringDoc OpenAPI
- **构建工具**：Maven 3.8+

## 核心功能
1. **用户管理**：注册、登录、个人信息管理、权限控制
2. **失物管理**：发布失物信息、查询失物、更新失物状态
3. **认领管理**：提交认领申请、审核认领信息、处理认领结果
4. **感谢留言**：用户提交感谢留言、管理员管理留言
5. **数据统计**：失物类型分布、高发丢失地点、月度失物统计
6. **系统公告**：管理员发布公告、用户查看公告
7. **文件上传**：支持上传失物图片，自动处理文件存储和访问路径

## 项目结构
```
lost-found-backend/
├── src/main/java/com/lostfound/server/
│   ├── config/          # 配置类（CORS、Redis、Security等）
│   ├── controller/      # 控制器（API接口）
│   ├── dto/             # 数据传输对象
│   ├── entity/          # 实体类
│   ├── exception/       # 异常处理
│   ├── interceptor/     # 拦截器
│   ├── mapper/          # 数据访问层
│   ├── security/        # 安全相关（JWT过滤器）
│   ├── service/         # 业务逻辑层
│   ├── util/            # 工具类（JWT、文件上传等）
│   └── LostFoundApplication.java  # 启动类
├── src/main/resources/
│   ├── mapper/          # MyBatis映射文件
│   └── application.yml  # 配置文件
├── .gitignore           # Git忽略文件
├── pom.xml              # Maven依赖配置
└── README.md            # 项目说明
```

## 技术亮点
1. **JWT认证**：实现无状态认证，支持跨域访问，提升系统安全性
2. **MyBatis Plus**：使用代码生成器和条件构造器，简化数据库操作
3. **Redis缓存**：缓存热点数据（如统计信息），提升系统性能
4. **数据统计**：实现多维度数据统计，为景区管理提供决策支持
5. **异常处理**：统一异常处理机制，返回标准化错误响应
6. **文件上传**：支持图片上传，自动处理文件路径和访问URL
7. **CORS跨域**：配置跨域支持，实现前后端分离架构

## 快速开始
### 环境要求
- JDK 1.8+
- MySQL 8.0+
- Redis 5.0+
- Maven 3.8+

### 安装与运行
1. **克隆仓库**：
   ```bash
   git clone https://github.com/admin118866admin118866/lost-found-backend.git
   cd lost-found-backend
   ```

2. **配置数据库**：
   - 修改 `src/main/resources/application.yml` 中的数据库连接信息
   - 创建数据库 `lost_found_db`（或根据配置修改数据库名）

3. **构建项目**：
   ```bash
   mvn clean install
   ```

4. **运行项目**：
   ```bash
   mvn spring-boot:run
   ```

5. **访问API文档**：
   - 启动后访问：`http://localhost:8080/swagger-ui.html`

## 核心模块说明
### 1. 认证模块
- **实现方式**：基于JWT的无状态认证
- **核心文件**：
  - `JwtUtil.java`：JWT token生成与验证
  - `JwtAuthenticationFilter.java`：请求拦截与token验证
  - `AuthController.java`：登录、注册接口

### 2. 失物管理模块
- **实现方式**：基于MyBatis Plus的CRUD操作
- **核心文件**：
  - `LostItemController.java`：失物相关API
  - `LostItemServiceImpl.java`：业务逻辑实现
  - `LostItemServiceHelper.java`：辅助工具类

### 3. 数据统计模块
- **实现方式**：基于SQL查询和Redis缓存
- **核心文件**：
  - `StatisticsController.java`：统计API
  - `StatisticsServiceImpl.java`：统计逻辑实现
  - `StatisticsMapper.xml`：统计SQL查询

## 数据库设计
- **用户表** (`user`)：存储用户信息
- **失物表** (`lost_item`)：存储失物信息
- **认领记录表** (`claim_record`)：存储认领申请
- **感谢留言表** (`thank_note`)：存储感谢留言
- **公告表** (`announcement`)：存储系统公告
- **物品分类表** (`item_category`)：存储失物分类

## 总结
本项目是一个完整的Java后端服务，展示了Spring Boot、MyBatis Plus、JWT等主流后端技术的应用。通过本项目，可以了解如何构建一个具有认证授权、数据管理、统计分析等功能的后端系统，适合作为Java后端开发的学习和实践案例。

## 许可证

MIT License
