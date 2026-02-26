impot configparser

config = cingparser.ConfigParser()
config.read('config.ini')

freq = config.get('TestParameters', 'frequency')
power = config.get ('TestParametrs', 'power')

printf(f"Running test at {Freq} MHz with {power} dBm power.. ") 