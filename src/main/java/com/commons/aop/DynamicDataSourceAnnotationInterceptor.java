/**
 * Copyright © 2018 organization baomidou
 * <pre>
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * <pre/>
 */
package com.commons.aop;

import com.commons.DynamicDataSourceClassResolver;
import com.commons.annotation.DS;
import com.commons.spel.DynamicDataSourceSpelParser;
import com.commons.spel.DynamicDataSourceSpelResolver;
import com.commons.toolkit.DynamicDataSourceContextHolder;
import lombok.Setter;
import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.springframework.core.annotation.AnnotationUtils;

import java.lang.reflect.Method;

/**
 * 动态数据源AOP核心拦截器
 *
 * @author TaoYu
 * @since 1.2.0
 */
public class DynamicDataSourceAnnotationInterceptor implements MethodInterceptor {

    @Setter
    private DynamicDataSourceSpelResolver dynamicDataSourceSpelResolver;

    @Setter
    private DynamicDataSourceSpelParser dynamicDataSourceSpelParser;

    private DynamicDataSourceClassResolver dynamicDataSourceClassResolver = new DynamicDataSourceClassResolver();

    @Override
    public Object invoke(MethodInvocation invocation) throws Throwable {
        try {
            DynamicDataSourceContextHolder.setDataSourceLookupKey(determineDatasource(invocation));
            return invocation.proceed();
        } finally {
            DynamicDataSourceContextHolder.clearDataSourceLookupKey();
        }
    }

    private String determineDatasource(MethodInvocation invocation) throws Throwable {
        Method method = invocation.getMethod();
        Class<?> declaringClass = dynamicDataSourceClassResolver.targetClass(invocation);
        DS ds = method.isAnnotationPresent(DS.class) ? method.getAnnotation(DS.class)
                : AnnotationUtils.findAnnotation(declaringClass, DS.class);
        String value = ds.value();
        if (!value.isEmpty() && value.startsWith("#")) {
            String spelValue = dynamicDataSourceSpelParser.parse(invocation, value);
            return dynamicDataSourceSpelResolver.resolve(spelValue);
        }
        return value;
    }

}