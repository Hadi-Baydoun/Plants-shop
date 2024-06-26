import AboutUsHome from "./AboutUsSection/AboutUsHome";
import Arrivals from "./ArrivalsSection/Arrivals";
import Features from "./FeaturesSection/Features";
import Hero from "./HeroSection/Hero";
import Reasons from "./ReasonsSection/Reasons";
import Testimonials from "./TestimonialsSection/Testimonials"; 

export default function Home({ loggedInUser, cartId, setCartId, wishlistId, setWishlistId }) {
  
  return (
    <div className="home">
      <Hero />
      <Features />
      <Arrivals loggedInUser={loggedInUser} cartId={cartId} setCartId={setCartId} wishlistId={wishlistId} setWishlistId={setWishlistId} />
      <AboutUsHome />
      <Reasons />
      <Testimonials />
    </div>
  );
}
