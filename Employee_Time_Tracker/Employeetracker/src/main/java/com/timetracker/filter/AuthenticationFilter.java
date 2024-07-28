package com.timetracker.filter;

import com.timetracker.model.Employee;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class AuthenticationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        HttpSession session = httpRequest.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("employee") != null);
        String loginURI = httpRequest.getContextPath() + "/login";
        boolean isLoginRequest = httpRequest.getRequestURI().equals(loginURI);
        boolean isLoginPage = httpRequest.getRequestURI().endsWith("login.jsp");

        if (isLoggedIn && (isLoginRequest || isLoginPage)) {
            // User is already logged in and trying to access login page, redirect to dashboard
            httpResponse.sendRedirect("dashboard.jsp");
        } else if (isLoggedIn || isLoginRequest || isLoginPage) {
            // User is logged in or requesting login page, continue
            chain.doFilter(request, response);
        } else {
            // User is not logged in, redirect to login page
            httpResponse.sendRedirect(loginURI);
        }
    }

    @Override
    public void destroy() {}
}