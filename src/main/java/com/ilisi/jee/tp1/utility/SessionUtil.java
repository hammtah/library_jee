package com.ilisi.jee.tp1.utility;

import com.ilisi.jee.tp1.beans.Admin;
import jakarta.servlet.http.HttpServletRequest;

public class SessionUtil {
    public static void saveAdmin(HttpServletRequest req, Admin a){
        req.getSession().setAttribute("admin", a);
    }
    public static Admin getAdmin(HttpServletRequest req){
        return (Admin) req.getSession().getAttribute("admin");
    }
    public static void invalidate(HttpServletRequest req){
        req.getSession().invalidate();
    }
}
