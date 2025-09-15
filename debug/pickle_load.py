import pickle
import sys
import numpy
#numpy.set_printoptions(threshold=sys.maxsize)

# Specify the path to your .pkl file
file_path = sys.argv[1]  # Replace with the actual path to your file

try:
    # Open the file in binary read mode ('rb')
    with open(file_path, 'rb') as file:
        # Load the pickled data
        loaded_data = pickle.load(file)
        import pdb;pdb.set_trace()

    # Now, 'loaded_data' contains the Python object that was stored in the .pkl file
    print("Data loaded successfully:")

except FileNotFoundError:
    print(f"Error: The file '{file_path}' was not found.")
except Exception as e:
    print(f"An error occurred while loading the pickle file: {e}")

