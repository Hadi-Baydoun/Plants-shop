import React, { Suspense, lazy } from 'react';
import ContactHero from './HeroSection/ContactHero';

// Lazy load the components
const FAQ = lazy(() => import('./FAQSection/FAQ'));
const Form = lazy(() => import('./FormSection/Form'));

export default function Contact() {
  return (
    <div className="home">
      <ContactHero />
      <Suspense fallback={<div>Loading form...</div>}>
        <Form />
      </Suspense>
      <Suspense fallback={<div>Loading FAQ...</div>}>
        <FAQ />
      </Suspense>
    </div>
  );
}
