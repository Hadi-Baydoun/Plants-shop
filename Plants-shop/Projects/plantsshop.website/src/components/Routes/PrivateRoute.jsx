import React from 'react';
import { Navigate, Outlet } from 'react-router-dom';
import { useAuth } from '../../context/AuthContext';

const PrivateRoute = ({ setShowLogin }) => {
  const { user } = useAuth();

  if (!user) {
    setShowLogin(true);
    return <Navigate to="/" />;
  }

  return <Outlet />;
};

export default PrivateRoute;
