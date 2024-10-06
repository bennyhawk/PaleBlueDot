import numpy as np
import pandas as pd


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


if __name__ == '__main__':
    dataframe = pd.read_csv('exo_planet_2.csv', low_memory=False)
    final_df = pd.DataFrame()
    for index, row in dataframe.iterrows():
        ra = row['ra']
        dec = row['dec']
        parallax = row['sy_plx']
        x, y, z = ra_dec_parallax_to_xyz(ra, dec, parallax)
        final_df.at[index, 'x'] = x
        final_df.at[index, 'y'] = y
        final_df.at[index, 'z'] = z
        final_df.at[index, 'ra'] = ra
        final_df.at[index, 'dec'] = dec
        final_df.at[index, 'parallax'] = parallax
        final_df.at[index, 'name'] = row['pl_name']
        print(f"Processed {index + 1} out of {len(dataframe.index)} rows.")

    final_df.to_json('exo_planet_final.json', index=False, orient='records')