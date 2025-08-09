package com.example.ceptebuldemo.mapper;

import com.example.ceptebuldemo.dto.request.CreateUserRequest;
import com.example.ceptebuldemo.dto.request.UpdateUserRequest;
import com.example.ceptebuldemo.dto.response.UserResponse;
import com.example.ceptebuldemo.model.User;
import org.mapstruct.BeanMapping;
import org.mapstruct.Mapper;
import org.mapstruct.MappingTarget;
import org.mapstruct.NullValuePropertyMappingStrategy;

@Mapper(componentModel = "spring")
public interface UserMapper {
    User toUser(CreateUserRequest dto);
    UserResponse toUserResponse(User user);

    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    void updateUserFromDto(UpdateUserRequest dto, @MappingTarget User user);
}
