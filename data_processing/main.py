import math

import numpy as np
import pandas as pd


def calculate_distance(cood1, cood2):
    ra1, dec1, parallax1 = cood1
    ra2, dec2, parallax2 = cood2

    x1, y1, z1 = ra_dec_parallax_to_xyz(ra1, dec1, parallax1)
    x2, y2, z2 = ra_dec_parallax_to_xyz(ra2, dec2, parallax2)

    return math.sqrt(
        (x1 - x2) * (x1 - x2) +
        (y1 - y2) * (y1 - y2) +
        (z1 - z2) * (z1 - z2)
    )


def ra_dec_parallax_to_xyz(ra, dec, parallax):
    # Convert ra and dec to radians
    ra_rad = np.radians(ra)
    dec_rad = np.radians(dec)

    # Calculate the distance in parsecs
    distance_pc = 1000 / parallax  # parallax in mas

    # Calculate the Cartesian coordinates
    x = distance_pc * np.cos(dec_rad) * np.cos(ra_rad)
    y = distance_pc * np.cos(dec_rad) * np.sin(ra_rad)
    z = distance_pc * np.sin(dec_rad)

    return x, y, z


def calculate_apparent_magnitude(distance, grvs_mag):
    return grvs_mag - 5 + (5 * math.log10(distance))


def calculate_absolute_magnitude(distance, grvs_mag):
    return grvs_mag + 5 - (5 * math.log10(distance))


if __name__ == '__main__':
    dataframe = pd.read_csv('GaiaSource_filtered.csv', low_memory=False)
    filtered_df = dataframe.query('grvs_mag > 0')

    results = {'distance': [], 'apparent_magnitude': [], 'ra': [], 'dec': [], 'parallax': [], 'x':  [], 'y': [], 'z': []}
    for index, row in filtered_df.iterrows():
        ra1 = row['ra']
        dec1 = row['dec']
        parallax_1 = row['parallax']
        apparent_magnitude = row['grvs_mag']
        grvs_mag_M_1 = calculate_absolute_magnitude(1000 / parallax_1, apparent_magnitude)

        coord1 = [ra1, dec1, parallax_1]

        coord2 = [185.1787793, 17.7932516, 10.7104000]
        distance = calculate_distance(coord1, coord2)

        x, y, z = ra_dec_parallax_to_xyz(ra1, dec1, parallax_1)

        mag = calculate_apparent_magnitude(distance, grvs_mag_M_1)
        results['distance'].append(distance)
        results['apparent_magnitude'].append(mag)
        results['ra'].append(ra1)
        results['dec'].append(dec1)
        results['parallax'].append(parallax_1)
        results['x'].append(x)
        results['y'].append(y)
        results['z'].append(z)
        pd.DataFrame(results).to_json('results.json', index=False, orient='records')
