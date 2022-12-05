package com.sbeam.bean;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;
import java.util.Objects;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class User {

    private int uId;
    private String uName;
    private String uPassword;
    private Timestamp uCreatTime;
    private String uCountry;
    private String uEmail;
    private Integer pId;
    private Integer uBalance;

    private Integer isOnline;

    private UserData userData;

    @JsonIgnore
    private Comment comment;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        User user = (User) o;
        return Objects.equals(uName, user.uName);
    }

    @Override
    public int hashCode() {
        return Objects.hash(uName);
    }
}
