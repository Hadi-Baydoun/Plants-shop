import Hero from './HeroSection/Hero';
import AboutUsHome from './AboutUsSection/AboutUsHome';
import Arrivals from './ArrivalsSection/Arrivals';
import Features from './FeaturesSection/Features';
import Reasons from './ReasonsSection/Reasons';
import Testimonials from './TestimonialsSection/Testimonials';

export default function Home() {
  return (
    <div>
      <Hero />
      <Features />
      <Arrivals />
      <AboutUsHome />
      <Reasons />
      <Testimonials />
    </div>
  );
}
