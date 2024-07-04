import React, { Suspense, lazy } from 'react';
import AboutUsHero from './HeroSection/AboutUsHero';

// Lazy load the components
const NumbersSection = lazy(() => import('./NumbersSection/NumbersSection'));
const Goals = lazy(() => import('./GoalsSection/Goals'));
const OurJourney = lazy(() => import('./JourneySection/OurJourney'));
const OurStory = lazy(() => import('./StorySection/OurStory'));
const Reasons = lazy(() => import('../HomePage/ReasonsSection/Reasons'));

export default function AboutUs() {
    return (
        <div className="home">
            <AboutUsHero />
            <Suspense fallback={<div>Loading Numbers Section...</div>}>
                <NumbersSection />
            </Suspense>
            <Suspense fallback={<div>Loading Our Story...</div>}>
                <OurStory />
            </Suspense>
            <Suspense fallback={<div>Loading Our Journey...</div>}>
                <OurJourney />
            </Suspense>
            <Suspense fallback={<div>Loading Goals...</div>}>
                <Goals />
            </Suspense>
            <Suspense fallback={<div>Loading Reasons...</div>}>
                <Reasons />
            </Suspense>
        </div>
    );
}
