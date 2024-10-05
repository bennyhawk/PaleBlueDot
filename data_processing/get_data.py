import requests
from bs4 import BeautifulSoup
import os
import gzip
import pandas as pd
import shutil
from datetime import datetime

# URL of the directory to download files from
url = 'https://cdn.gea.esac.esa.int/Gaia/gdr3/gaia_source/'
csv_file_path = 'GaiaSource_filtered.csv'

# Directory to save the downloaded files
download_dir = 'gaia_files'
os.makedirs(download_dir, exist_ok=True)

# Get the content of the directory page
response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')

# Find all links to files in the directory
links = soup.find_all('a')
file_links = [link.get('href') for link in links if link.get('href').endswith('.gz')]

print(f'Total Files : {len(file_links)}')


# Function to process the downloaded file (stub function, replace with your actual processing)
def process_file(file_path):
    print(f'Processing {file_path}...')
    unzipped_file_path = file_path.replace('.gz', '')
    print(f'Unzipping {file_path} to {unzipped_file_path}...')

    with gzip.open(file_path, 'rb') as f_in:
        with open(unzipped_file_path, 'wb') as f_out:
            shutil.copyfileobj(f_in, f_out)

    # Now process the unzipped file
    print(f'Processing {unzipped_file_path}...')
    # Add your file processing code here
    # ...
    remove_comments(unzipped_file_path)
    dataframe = pd.read_csv(unzipped_file_path, low_memory=False)
    filtered_df = dataframe.query('parallax > 0').query('phot_g_mean_mag >= -30').query('phot_g_mean_mag <= 6')
    print(f'Filtered Data : {len(filtered_df.index)}')
    if not os.path.exists(csv_file_path):
        filtered_df.to_csv(csv_file_path, index=False, mode='w',
                           header=True)  # Write with header if the file does not exist
    else:
        filtered_df.to_csv(csv_file_path, index=False, mode='a',
                           header=False)  # Append without header if the file exists
    # Delete the unzipped file after processing
    os.remove(unzipped_file_path)
    print(f'Deleted {unzipped_file_path} after processing.')


def remove_comments(file_path):
    with open(file_path, 'r') as file:
        lines = file.readlines()

    # Filter out lines that start with '#'
    uncommented_lines = [line for line in lines if not line.strip().startswith('#')]

    # Write the uncommented lines to a new file
    with open(file_path, 'w') as file:
        file.writelines(uncommented_lines)
    return file_path


# Download each file
for file_link in file_links[:20]:
    start_time = datetime.now()
    file_url = url + file_link
    file_path = os.path.join(download_dir, file_link)

    print(f'Downloading {file_link}')

    # Download the file
    with requests.get(file_url, stream=True) as r:
        r.raise_for_status()
        with open(file_path, 'wb') as f:
            for chunk in r.iter_content(chunk_size=8192):
                f.write(chunk)
    # Process the downloaded file
    process_file(file_path)

    # Delete the file after processing
    os.remove(file_path)
    print(f'Deleted {file_path} after processing.')
    print(f'File Processed in : {datetime.now() - start_time}')

print('All files downloaded successfully.')