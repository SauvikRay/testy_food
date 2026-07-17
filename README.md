# testy_food

name: Vibrant Gourmet
colors:
  surface: '#f8f9ff'
  surface-dim: '#d0dbed'
  surface-bright: '#f8f9ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#eff4ff'
  surface-container: '#e6eeff'
  surface-container-high: '#dee9fc'
  surface-container-highest: '#d9e3f6'
  on-surface: '#121c2a'
  on-surface-variant: '#5b3f46'
  inverse-surface: '#27313f'
  inverse-on-surface: '#eaf1ff'
  outline: '#8f6f76'
  outline-variant: '#e3bdc5'
  surface-tint: '#ba005c'
  primary: '#b60059'
  on-primary: '#ffffff'
  primary-container: '#e30271'
  on-primary-container: '#fffbff'
  inverse-primary: '#ffb1c5'
  secondary: '#ac2868'
  on-secondary: '#ffffff'
  secondary-container: '#fd6aa9'
  on-secondary-container: '#6d003c'
  tertiary: '#006b17'
  on-tertiary: '#ffffff'
  tertiary-container: '#00881f'
  on-tertiary-container: '#f7fff0'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#ffd9e1'
  primary-fixed-dim: '#ffb1c5'
  on-primary-fixed: '#3f001a'
  on-primary-fixed-variant: '#8f0045'
  secondary-fixed: '#ffd9e4'
  secondary-fixed-dim: '#ffb0cb'
  on-secondary-fixed: '#3e0020'
  on-secondary-fixed-variant: '#8c0550'
  tertiary-fixed: '#7cfe79'
  tertiary-fixed-dim: '#5fe060'
  on-tertiary-fixed: '#002203'
  on-tertiary-fixed-variant: '#00530f'
  background: '#f8f9ff'
  on-background: '#121c2a'
  surface-variant: '#d9e3f6'
typography:
  headline-lg:
    fontFamily: Inter
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 40px
    letterSpacing: -0.02em
  headline-lg-mobile:
    fontFamily: Inter
    fontSize: 28px
    fontWeight: '700'
    lineHeight: 36px
    letterSpacing: -0.01em
  headline-md:
    fontFamily: Inter
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
    letterSpacing: -0.01em
  headline-sm:
    fontFamily: Inter
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 28px
    letterSpacing: '0'
  body-lg:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
    letterSpacing: '0'
  body-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
    letterSpacing: '0'
  label-lg:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '600'
    lineHeight: 20px
    letterSpacing: 0.01em
  label-md:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
    letterSpacing: 0.02em
  label-sm:
    fontFamily: Inter
    fontSize: 11px
    fontWeight: '500'
    lineHeight: 16px
    letterSpacing: 0.03em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  unit: 8px
  xs: 4px
  sm: 8px
  md: 16px
  lg: 24px
  xl: 32px
  container-margin-mobile: 16px
  container-margin-desktop: 48px
  gutter: 16px
---

## Brand & Style

The design system is engineered to evoke a sense of high-energy convenience and premium reliability. Targeting urban professionals and food enthusiasts, the visual language balances the playful urgency of a delivery service with the sophisticated polish of a modern concierge app. 

The aesthetic is a hybrid of **Modern Minimalism** and **Glassmorphism**. It utilizes expansive white space and a structured 8pt grid to maintain clarity, while employing translucent layers and soft background blurs to suggest depth and modern technical craft. The interface feels "alive"—highly responsive, tactile, and appetizing.

## Colors

This design system uses a high-vibrancy primary palette to drive brand recognition and action. 

- **Primary & Secondary:** These pinks are reserved for primary calls to action, brand-heavy moments, and active states.
- **Accent:** Used sparingly for promotional badges, ratings, and "special offer" highlights to create visual pop without clashing with the primary brand color.
- **Semantic Colors:** Green (Success), Amber (Warning), and Red (Error) follow standard industry patterns but are adjusted for high legibility against the light background.
- **Surface Strategy:** The background uses a slightly cool gray (`#F8F9FB`) to allow white surface cards (`#FFFFFF`) to visually lift off the page using elevation.

## Typography

The design system relies on **Inter** to provide a clean, systematic, and highly readable experience. 

- **Headlines:** Use Bold (700) and SemiBold (600) weights with slightly negative letter spacing to create a compact, premium editorial look for restaurant names and category titles.
- **Body:** Standardized at 16px for readability, using 14px for secondary metadata (e.g., delivery times, distances).
- **Labels:** Used for buttons, category chips, and overline text. These utilize higher weights and increased letter spacing to differentiate from body text.

## Layout & Spacing

This design system adheres to a strict **8pt grid system**. All dimensions, padding, and margins should be multiples of 8 (or 4 for micro-adjustments).

- **Mobile Layout:** A fluid 4-column grid with 16px side margins and 16px gutters. Content cards typically span the full width or 2 columns for smaller tiles.
- **Desktop Layout:** A fixed 12-column grid with a max-width of 1200px. Content is centered with 24px gutters.
- **Spacing Philosophy:** Use `lg` (24px) spacing between major sections and `md` (16px) for internal component padding to maintain a feeling of airiness and luxury.

## Elevation & Depth

Hierarchy is established through **Tonal Layers** and **Ambient Shadows**, supplemented by glassmorphic overlays.

- **Level 0 (Background):** `#F8F9FB`. Flat.
- **Level 1 (Surface/Cards):** `#FFFFFF`. Used for restaurant listings and food items. Shadow: `0 4px 12px rgba(31, 41, 55, 0.05)`.
- **Level 2 (Floating/Interactive):** Active buttons or picked items. Shadow: `0 8px 24px rgba(255, 43, 133, 0.15)`.
- **Glassmorphism:** Sticky headers and bottom navigation bars utilize a white background with 80% opacity and a 20px backdrop-blur filter. This ensures the colorful food imagery scrolls elegantly beneath the UI controls.

## Shapes

The design system uses a generous corner radius to feel welcoming and "organic," echoing the soft shapes of food.

- **Default (8px):** Used for small interactive elements like checkboxes, steppers, and small tags.
- **Large (16px):** The standard radius for restaurant cards, product images, and input fields.
- **Extra Large (24px):** Used for primary container cards (e.g., "Order Summary" bottom sheets) and promotional hero banners.
- **Pill:** Reserved exclusively for category chips and primary action buttons to maximize clickability.

## Components

- **Buttons:** Primary buttons are pill-shaped, using the `#FF2B85` primary color with white text. High-elevation shadows are applied on hover/press. Secondary buttons use a primary-colored outline or a ghost style.
- **Chips:** Used for filters (e.g., "Fastest Delivery," "Top Rated"). Unselected chips have a light gray border; selected chips have a primary background or light pink tint with primary text.
- **Cards:** Restaurant cards use a 16px radius. The image occupies the top 60% with a subtle inner gradient to ensure white text overlays (like "20-30 min") remain legible.
- **Input Fields:** 16px radius with a light gray border (`#E5E7EB`). On focus, the border transitions to the primary pink with a soft 4px glow.
- **Lists:** Clean rows with 16px vertical padding. Use horizontal dividers only when content is dense; otherwise, use whitespace to separate items.
- **Search Bar:** A prominent 16px or pill-shaped bar with a glassmorphic background when scrolled, containing a subtle magnifying glass icon and "Search for food or restaurants" placeholder.