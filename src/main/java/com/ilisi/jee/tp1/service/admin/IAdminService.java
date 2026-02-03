package com.ilisi.jee.tp1.service.admin;

import com.ilisi.jee.tp1.beans.Admin;

public interface IAdminService {
        public Admin login(String username, String password) throws Exception;
        public void addAdmin(String username, String password) throws Exception;
}
