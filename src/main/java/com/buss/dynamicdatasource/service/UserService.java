package com.buss.dynamicdatasource.service;

import com.buss.dynamicdatasource.entity.User;

import java.util.List;

public interface UserService {

    void addUser(User user);

    List selectUser1();

    List selectUser2();

    List selectUser3();
}
