import './NavBar.css';
import { useState, useEffect, useContext } from 'react';
import { Link, useLocation, useNavigate } from 'react-router-dom';
import logo from '../../assets/pictures/logo.png';
import ShoppingBasketOutlinedIcon from '@mui/icons-material/ShoppingBasketOutlined';
import Person2OutlinedIcon from '@mui/icons-material/Person2Outlined';
import MenuIcon from '@mui/icons-material/Menu';
import CloseIcon from '@mui/icons-material/Close';
import { Snackbar, Alert } from '@mui/material';
import axios from 'axios';
import LoyaltyIcon from '@mui/icons-material/Loyalty';
import { AuthContext } from '../../context/AuthContext';

export const NavBar = ({ setShowLogin }) => {
    const [menu, setMenu] = useState("Home");
    const [isMenuOpen, setIsMenuOpen] = useState(false);
    const [isScrolled, setIsScrolled] = useState(false);
    const [snackbarOpen, setSnackbarOpen] = useState(false);
    const [snackbarMessage, setSnackbarMessage] = useState("");
    const [snackbarSeverity, setSnackbarSeverity] = useState("success");
    const location = useLocation();
    const navigate = useNavigate();

    const { user, cartId, wishlistId } = useContext(AuthContext);

    const toggleMenu = () => {
        setIsMenuOpen(!isMenuOpen);
    };

    const handleScroll = () => {
        const scrollTop = window.scrollY;
        if (scrollTop > 0) {
            setIsScrolled(true);
        } else {
            setIsScrolled(false);
        }
    };

    const handleCartClick = () => {
        if (user) {
            if (cartId) {
                navigate('/cart');
            } else {
                setSnackbarMessage("Failed to access cart. Please try again.");
                setSnackbarSeverity("error");
                setSnackbarOpen(true);
            }
        } else {
            setSnackbarMessage("Please log in to access your cart.");
            setSnackbarSeverity("error");
            setSnackbarOpen(true);
            setShowLogin(true);
        }
    };

    const handleWishlistClick = () => {
        if (user) {
            if (wishlistId) {
                navigate('/wishlist');
            } else {
                setSnackbarMessage("Failed to access wishlist. Please try again.");
                setSnackbarSeverity("error");
                setSnackbarOpen(true);
            }
        } else {
            setSnackbarMessage("Please log in to access your wishlist.");
            setSnackbarSeverity("error");
            setSnackbarOpen(true);
            setShowLogin(true);
        }
    };

    const handleSnackbarClose = () => {
        setSnackbarOpen(false);
    };

    useEffect(() => {
        window.addEventListener('scroll', handleScroll);
        return () => {
            window.removeEventListener('scroll', handleScroll);
        };
    }, []);

    useEffect(() => {
        window.scrollTo(0, 0);
    }, [location]);

    useEffect(() => {
        switch (location.pathname) {
            case '/':
                setMenu("Home");
                break;
            case '/shop':
                setMenu("Shop");
                break;
            case '/about':
                setMenu("About Us");
                break;
            case '/contact':
                setMenu("Contact");
                break;
            case '/cart':
                setMenu("");
                break;
            default:
                setMenu("");
                break;
        }
    }, [location.pathname]);

    return (
        <div className={`navbar ${isScrolled ? 'scrolled' : ''}`}>
            {!isScrolled ? (
                <Link to="/" onClick={() => setMenu("Home")}>
                    <img className='logo' src={logo} alt="Logo" />
                </Link>
            ) : (
                <Link to="/" onClick={() => setMenu("Home")}>
                    <div className="scrolled-logo">GreenGlow</div>
                </Link>
            )}
            <ul className={`navbar-menu ${isMenuOpen ? 'open' : ''}`}>
                <li className={menu === "Home" ? "active" : ""}>
                    <Link to="/" onClick={() => { setMenu("Home"); setIsMenuOpen(false); }}>Home</Link>
                </li>
                <li className={menu === "Shop" ? "active" : ""}>
                    <Link to="/shop" onClick={() => { setMenu("Shop"); setIsMenuOpen(false); }}>Shop</Link>
                </li>
                <li className={menu === "About Us" ? "active" : ""}>
                    <Link to="/about" onClick={() => { setMenu("About Us"); setIsMenuOpen(false); }}>About Us</Link>
                </li>
                <li className={menu === "Contact" ? "active" : ""}>
                    <Link to="/contact" onClick={() => { setMenu("Contact"); setIsMenuOpen(false); }}>Contact</Link>
                </li>
                {isMenuOpen && (
                    <li className="close-icon" onClick={toggleMenu}>
                        <CloseIcon />
                    </li>
                )}
            </ul>
            <div className='navbar-right'>
                <LoyaltyIcon className="navbar-icon" onClick={handleWishlistClick} />
                <div className="navbar-search-icon">
                    <ShoppingBasketOutlinedIcon className="navbar-icon" onClick={handleCartClick} />
                </div>
                <Person2OutlinedIcon className="navbar-icon" onClick={() => setShowLogin(true)} />
                {!isMenuOpen && (
                    <div className="navbar-hamburger" onClick={toggleMenu}>
                        <MenuIcon className="navbar-icon" />
                    </div>
                )}
            </div>
            <Snackbar
                open={snackbarOpen}
                autoHideDuration={6000}
                onClose={handleSnackbarClose}
            >
                <Alert onClose={handleSnackbarClose} severity={snackbarSeverity} sx={{ width: '100%' }}>
                    {snackbarMessage}
                </Alert>
            </Snackbar>
        </div>
    );
};
