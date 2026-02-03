package com.ilisi.jee.tp1.service.admin;

import com.ilisi.jee.tp1.beans.Admin;
import com.ilisi.jee.tp1.dao.AdminDao.IAdminDao;
import com.ilisi.jee.tp1.exception.DaoException;
import org.mindrot.jbcrypt.BCrypt;

public class AdminService implements IAdminService{
    private IAdminDao adminDao;
    public AdminService(IAdminDao _adminDao){
        adminDao = _adminDao;
    }
    private boolean checkPassword(String inputPassword, String hashedPassword){
        return BCrypt.checkpw(inputPassword, hashedPassword);
    }
    public Admin login(String username, String password)throws Exception{
        try{
            Admin a = adminDao.findByUserName(username);
            if(a == null || !checkPassword(password, a.getPassword()))
                throw new Exception("Invalid username or password");
            else{
                return a;
            }
        } catch (DaoException e) {
            throw new RuntimeException(e);
        }
    }

    public void addAdmin(String username, String password) throws Exception {
        try {
            String hashed = BCrypt.hashpw(password, BCrypt.gensalt(12));
            adminDao.createAdmin(username, hashed);
        } catch (DaoException e) {
            throw new Exception(e);
        }
    }
}
