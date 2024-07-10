import { createContext, useState, useEffect, useCallback } from 'react';
import PropTypes from 'prop-types';
import axios from 'axios';
import { API_HOST } from '../assets/constants';

const AuthContext = createContext();

const AuthProvider = ({ children }) => {
  const [user, setUser] = useState(
    JSON.parse(localStorage.getItem('user')) || null
  );
  const [token, setToken] = useState(localStorage.getItem('token') || '');
  const [refreshToken, setRefreshToken] = useState(
    localStorage.getItem('refreshToken') || ''
  );
  const [tokenExpiry, setTokenExpiry] = useState(
    localStorage.getItem('tokenExpiry') || 0
  );
  const [refreshTokenExpiry, setRefreshTokenExpiry] = useState(
    Number(localStorage.getItem('refreshTokenExpiry')) || 0
  );
  const [cartId, setCartId] = useState(null);
  const [wishlistId, setWishlistId] = useState(null);
  const [cart, setCart] = useState([]);
  const [wishlist, setWishlist] = useState([]);

  const login = async (email, password) => {
    try {
      const loginResponse = await axios.post(`${API_HOST}/api/Customer/login`, {
        email,
        password,
      });
      const { token, customer, refreshToken } = loginResponse.data;
      customer.password = password;
      setUser(customer);
      setToken(token);
      setRefreshToken(refreshToken);
      const expiryTime = Date.now() + 60 * 60 * 1000;
      const refreshExpiryTime = Date.now() + 7 * 24 * 60 * 60 * 1000;
      setTokenExpiry(expiryTime);
      setRefreshTokenExpiry(refreshExpiryTime);
      localStorage.setItem('user', JSON.stringify(customer));
      localStorage.setItem('token', token);
      localStorage.setItem('refreshToken', refreshToken);
      localStorage.setItem('tokenExpiry', expiryTime);
      localStorage.setItem('refreshTokenExpiry', refreshExpiryTime);
      return { success: true };
    } catch (error) {
      return {
        success: false,
        message: 'Login failed. Please check your credentials and try again.',
      };
    }
  };

  const logout = useCallback(() => {
    setUser(null);
    setToken('');
    setTokenExpiry(0);
    setCartId(null);
    setWishlistId(null);
    setCart([]);
    setWishlist([]);
    localStorage.removeItem('user');
    localStorage.removeItem('token');
    localStorage.removeItem('tokenExpiry');
    localStorage.removeItem('refreshToken');
    localStorage.removeItem('refreshTokenExpiry');
  }, []);

  const refreshAccessToken = useCallback(async () => {
    if (Date.now() > refreshTokenExpiry) {
      logout();
      return;
    }
    try {
      const refreshResponse = await axios.post(
        `${API_HOST}/api/Customer/refresh`,
        { token, refreshToken }
      );
      const {
        token: newToken,
        refreshToken: newRefreshToken,
        refreshTokenExpiry: newRefreshTokenExpiry,
      } = refreshResponse.data;
      setToken(newToken);
      setRefreshToken(newRefreshToken);
      const expiryTime = Date.now() + 15 * 60 * 1000;
      setTokenExpiry(expiryTime);
      setRefreshTokenExpiry(newRefreshTokenExpiry);
      localStorage.setItem('token', newToken);
      localStorage.setItem('refreshToken', newRefreshToken);
      localStorage.setItem('tokenExpiry', expiryTime);
      localStorage.setItem('refreshTokenExpiry', newRefreshTokenExpiry);
    } catch (error) {
      logout();
    }
  }, [token, refreshToken, refreshTokenExpiry, logout]);

  const checkTokenExpiry = useCallback(() => {
    if (token && Date.now() > tokenExpiry) {
      refreshAccessToken();
    }
  }, [token, tokenExpiry, refreshAccessToken]);

  useEffect(() => {
    checkTokenExpiry();
    const interval = setInterval(checkTokenExpiry, 1 * 60 * 1000);
    return () => clearInterval(interval);
  }, [checkTokenExpiry]);

  useEffect(() => {
    if (user) {
      const fetchCartAndWishlist = async () => {
        try {
          const cartResponse = await axios.get(
            `${API_HOST}/api/Cart/getOrCreateCartByCustomerId/${user.id}`
          );
          setCartId(cartResponse.data.id);
          const cartItemsResponse = await axios.get(
            `${API_HOST}/api/CartItem/getByCartId/${cartResponse.data.id}`
          );
          setCart(cartItemsResponse.data);

          const wishlistResponse = await axios.get(
            `${API_HOST}/api/Wishlist/getOrCreateWishlistByCustomerId/${user.id}`
          );
          setWishlistId(wishlistResponse.data.id);
          const wishlistItemsResponse = await axios.get(
            `${API_HOST}/api/WishlistItems/getByWishlistId/${wishlistResponse.data.id}`
          );
          setWishlist(wishlistItemsResponse.data);
        } catch (error) {
          console.error('Error fetching cart and wishlist:', error);
        }
      };

      fetchCartAndWishlist();
    }
  }, [user]);

  return (
    <AuthContext.Provider
      value={{
        user,
        token,
        login,
        logout,
        cartId,
        wishlistId,
        setCartId,
        setWishlistId,
        cart,
        setCart,
        wishlist,
        setWishlist,
        refreshAccessToken,
      }}
    >
      {children}
    </AuthContext.Provider>
  );
};

AuthProvider.propTypes = {
  children: PropTypes.node.isRequired,
};

export { AuthContext, AuthProvider };
