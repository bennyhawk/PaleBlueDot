# ExoSky: Interactive Exoplanet Star Visualization Platform

## Overview
ExoSky is an interactive educational platform designed to visualize the night sky from the perspective of any of the 5500+ exoplanets cataloged in NASA’s Exoplanet Archive. It allows users to explore how stars and constellations would appear from a given exoplanet, providing a unique insight into the vastness of the universe from a completely new vantage point. The platform is built to engage users of all ages, blending scientific accuracy with a gamified exploration experience that sparks curiosity and promotes learning.

## Features
- **Interactive Star Charts**: View the night sky as it would appear from any selected exoplanet.
- **Custom Constellations**: Draw and name your own constellations based on unique star patterns.
- **3D Navigation**: Explore a virtual universe using 3D navigational tools to select exoplanets.
- **Educational Insights**: Learn about star brightness, constellations, and celestial positions.
- **High-Quality Visualizations**: Generate high-quality images for further analysis or export.

## How It Works
1. **Data Extraction**:  
   - Utilizes ESA Gaia’s DR3 dataset and NASA’s Exoplanet Archive to extract star and exoplanet information.
   - Filters star data based on parallax and magnitude to limit the visible star catalog.

2. **Coordinate Conversion**:  
   - Converts the inertial coordinates of stars into a spherical coordinate system relative to each exoplanet’s position.
   - Ensures accurate star placement using mathematical transformations based on the rotational axis and orientation of the selected exoplanet.

3. **Rendering and Visualization**:  
   - Uses GoDot Engine for real-time 3D rendering of stars and celestial objects.
   - Generates a realistic view of the sky using visual enhancements like atmospheric distortion and star trails.

## Tools and Technologies

### Languages
- **Python**  

### Libraries
- **Numpy**: For numerical operations and data processing  
- **Pandas**: Efficient data handling and manipulation  
- **Matplotlib**: Data visualization and plotting

### 3D Rendering
- **GoDot Engine**: For real-time 3D rendering of celestial objects

### Data Sources
- **ESA Gaia DR3 Star Catalog**: Provides detailed star positions and magnitudes  
- **NASA Exoplanet Archive**: Contains positional data and properties of known exoplanets

## Challenges
- **Large Dataset Handling**: Managing extensive star catalogs and translating reference frames from Earth to exoplanet perspectives.
- **Position Conversion**: Accurately transforming star positions for realistic visualization without overwhelming system resources.
- **Interface Design**: Creating a dynamic, interactive interface that balances scientific precision with visual appeal.

## Images

![Star Catalog Visualization](https://github.com/bennyhawk/PaleBlueDot/blob/main/screenshot_1.jpeg)
*Figure 1: Visualization of the star catalog data.*

![Star Catalog Visualization](https://github.com/bennyhawk/PaleBlueDot/blob/main/screenshot_2.jpeg)
*Figure 2: Visualization of the stars from spaceship.*

