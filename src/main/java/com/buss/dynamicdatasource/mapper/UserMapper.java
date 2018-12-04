package com.buss.dynamicdatasource.mapper;

import com.buss.dynamicdatasource.entity.User;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Component;

import java.util.List;

//@DS("slave")这里可以使用但不建议，不要和service同时使用
@Component
public interface UserMapper {

    @Insert("INSERT INTO user (name,age) values (#{name},#{age})")
    boolean addUser(@Param("name") String name, @Param("age") Integer age);

    @Select("SELECT * FROM user")
    List<User> selectUsers();
}
