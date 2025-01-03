mysql格式

```mysql
-- 创建图书表
CREATE TABLE books (
    book_id CHAR(4) PRIMARY KEY,           -- 图书编号,4位字符
    book_name VARCHAR(20) NOT NULL,        -- 图书名称,最大20个字符
    author VARCHAR(10),                    -- 作者,最大10个字符
    publisher VARCHAR(20),                 -- 出版社,最大20个字符
    stock_count DECIMAL(9,0) DEFAULT 0     -- 馆藏数,9位数字,无小数位
);

-- 创建借阅表
CREATE TABLE borrow_records (
    borrow_time DATETIME NOT NULL,         -- 借阅时间
    book_id CHAR(4) NOT NULL,             -- 图书编号,4位字符
    reader_name VARCHAR(10) NOT NULL,      -- 读者姓名,最大10个字符
    borrow_count DECIMAL(9,0) DEFAULT 1,   -- 借阅数量,9位数字,无小数位
    PRIMARY KEY (borrow_time, book_id),    -- 复合主键
    FOREIGN KEY (book_id) REFERENCES books(book_id)  -- 外键约束
);

-- 创建归还记录表
CREATE TABLE return_records (
    record_id CHAR(36) NOT NULL,			-- 借阅编号
    return_count DECIMAL(9,0) DEFAULT 1,     -- 归还数量,9位数字,无小数位
    return_time DATETIME NOT NULL,			-- 归还时间
    remark VARCHAR(20),						-- 备注信息,最大20个字符
    PRIMARY KEY (return_time, record_id) 	-- 复合主键
);

```



创建视图前端展示

```mysql
-- 创建借阅记录综合视图
CREATE VIEW v_borrow_records AS
SELECT
    CONCAT('R', DATE_FORMAT(br.borrow_time, '%Y%m%d%H%i%s'), br.book_id) as record_id,  -- 借阅编号(基于借阅时间生成)
    br.book_id,                                                            -- 图书编号
    b.book_name,                                                          -- 图书名称
    br.reader_name,                                                       -- 读者姓名
    br.borrow_time,                                                       -- 借阅时间
    COALESCE(r.return_time, NULL) as return_time,                        -- 归还时间
    br.borrow_count,                                                      -- 借阅数量
    CASE
        WHEN r.return_time IS NULL THEN '借阅中'
        ELSE CONCAT('归还',
            COALESCE(
                (SELECT SUM(return_count)
                FROM return_records
                WHERE record_id = CONCAT('R', DATE_FORMAT(br.borrow_time, '%Y%m%d%H%i%s'), br.book_id)
                ), 0
            ),
            '/',
            br.borrow_count
        )
    END as status,                                                         -- 借阅状态

    r.return_count

FROM borrow_records br
LEFT JOIN books b ON br.book_id = b.book_id                              -- 关联图书表获取图书名称
LEFT JOIN return_records r ON CONCAT('R', DATE_FORMAT(br.borrow_time, '%Y%m%d%H%i%s'), br.book_id) = r.record_id                     -- 关联归还表获取归还信息
    AND r.return_time > br.borrow_time                                   -- 确保归还时间在借阅时间之后
ORDER BY br.borrow_time DESC;                                            -- 按借阅时间降序排序
```



触发器

```mysql
create trigger borrow_trigger
    after insert on borrow_records for each row
    begin
        update books set stock_count = stock_count - new.borrow_count where book_id = new.book_id;
    end;
create trigger return_trigger
    after insert on return_records for each row
    begin
            -- 声明变量存储book_id
            DECLARE extracted_book_id VARCHAR(4);
            -- 获取book_id
            SET extracted_book_id = RIGHT(NEW.record_id, 4);
        update books set stock_count = stock_count + new.return_count where book_id = extracted_book_id;
    end;
    
-- 修改触发器
create trigger change_trigger
    after update on return_records for each row
    begin
        DECLARE extracted_book_id VARCHAR(4);
        SET extracted_book_id = RIGHT(old.record_id, 4);
        update books set stock_count = stock_count - old.return_count where book_id = extracted_book_id;
        update books set stock_count = stock_count + new.return_count where book_id = extracted_book_id;
    end;
    
-- 删除触发器
create trigger delete_trigger
    after delete on return_records for each row
    begin
        DECLARE extracted_book_id VARCHAR(4);
        SET extracted_book_id = RIGHT(old.record_id, 4);
        update books set stock_count = stock_count - old.return_count where book_id = extracted_book_id;
    end;
```



数据

```mysql
-- 插入图书数据
INSERT INTO books (book_id, book_name, author, publisher, stock_count) VALUES
('B001', '计算机网络', '谢希仁', '电子工业出版社', 15),
('B002', '数据结构', '严蔚敏', '清华大学出版社', 20),
('B003', 'Java核心技术', '凯S.霍斯特曼', '机械工业出版社', 8),
('B004', 'C程序设计', '谭浩强', '清华大学出版社', 25),
('B005', '算法导论', 'Thomas H.', '机械工业出版社', 10),
('B006', '深入理解计算机系统', 'Randal E.', '机械工业出版社', 12),
('B007', 'Python编程', '马克·卢茨', '人民邮电出版社', 18),
('B008', '操作系统概念', '西尔伯查茨', '高等教育出版社', 15),
('B009', '数据库系统概论', '王珊', '高等教育出版社', 22),
('B010', 'JavaScript高级程序设计', '尼古拉斯', '人民邮电出版社', 16);
INSERT INTO books (book_id, book_name, author, publisher, stock_count) VALUES
('B011', '机器学习实战', '皮特·哈林顿', '人民邮电出版社', 14),
('B012', '深度学习入门', '斋藤康毅', '人民邮电出版社', 18),
('B013', '统计学习方法', '李航', '清华大学出版社', 20),
('B016', 'MySQL技术内幕', '姜承尧', '机械工业出版社', 16),
('B020', 'Redis设计与实现', '黄健宏', '机械工业出版社', 19),
('B021', '图解HTTP', '上野宣', '人民邮电出版社', 21),
('B022', '云计算架构技术与实践', '李军', '电子工业出版社', 14),
('B023', '大数据技术原理与应用', '林子雨', '人民邮电出版社', 16),
('B027', '计算机组成原理', '唐朔飞', '高等教育出版社', 22),
('B029', '深入理解Java虚拟机', '周志明', '机械工业出版社', 19),
('B030', 'React全栈', '程墨', '电子工业出版社', 13),
('B032', '网络安全基础', '王立福', '清华大学出版社', 18),
('B033', 'Vue.js实战', '梁灏', '电子工业出版社', 20),
('B034', '人工智能数学基础', '戴新宇', '高等教育出版社', 15),
('B040', '微服务架构设计', '马丁·福勒', '机械工业出版社', 18),
('B043', 'Swift编程语言', 'Apple Inc.', '人民邮电出版社', 17),
('B044', '深度学习框架PyTorch', '陈云', '电子工业出版社', 13),
('B045', '区块链技术指南', '邹均', '机械工业出版社', 16),
('B047', '数据可视化实战', '陈为', '电子工业出版社', 14),
('B048', 'Kubernetes权威指南', '龚正', '电子工业出版社', 18),
('B049', '自然语言处理实战', '何晗', '人民邮电出版社', 15),
('B050', '图数据库Neo4j实战', '林子雨', '电子工业出版社', 17),
('B051', '前端工程化体系设计', '周俊鹏', '电子工业出版社', 16),
('B052', '深入浅出RxJS', '程墨', '人民邮电出版社', 13),
('B055', '网络爬虫开发实战', '崔庆才', '人民邮电出版社', 20),
('B056', '深入理解Nginx', '陶辉', '机械工业出版社', 14),
('B057', '推荐系统实践', '项亮', '人民邮电出版社', 17),
('B058', 'TensorFlow深度学习', '易新月', '电子工业出版社', 19),
('B059', '计算机图形学', '史蒂夫·马纳', '机械工业出版社', 16),
('B060', 'Flutter实战', '杨加康', '电子工业出版社', 15);

-- 插入借阅记录数据
INSERT INTO borrow_records (borrow_time, book_id, reader_name, borrow_count) VALUES
('2024-03-01 09:30:00', 'B001', '张三', 1),
('2024-03-01 10:15:00', 'B002', '李四', 1),
('2024-03-01 11:20:00', 'B003', '王五', 2),
('2024-03-02 09:00:00', 'B001', '赵六', 1),
('2024-03-02 14:30:00', 'B004', '钱七', 1),
('2024-03-03 10:45:00', 'B005', '孙八', 1),
('2024-03-03 15:20:00', 'B006', '周九', 2),
('2024-03-04 09:15:00', 'B007', '吴十', 1),
('2024-03-04 11:30:00', 'B008', '郑十一', 1),
('2024-03-05 10:00:00', 'B009', '王小明', 1),
('2024-03-05 14:20:00', 'B010', '李小红', 1),
('2024-03-06 09:45:00', 'B001', '张小华', 1),
('2024-03-06 16:00:00', 'B002', '刘小军', 2),
('2024-03-07 10:30:00', 'B003', '陈小梅', 1),
('2024-03-07 15:15:00', 'B004', '杨小燕', 1),
('2024-03-08 09:20:00', 'B005', '黄小芳', 1),
('2024-03-08 14:45:00', 'B006', '周小伟', 1),
('2024-03-09 11:00:00', 'B007', '吴小龙', 2),
('2024-03-09 16:30:00', 'B008', '朱小琳', 1),
('2024-03-10 10:15:00', 'B009', '徐小波', 1);

```




