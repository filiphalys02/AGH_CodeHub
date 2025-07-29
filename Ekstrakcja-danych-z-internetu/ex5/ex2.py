from selenium.webdriver import Firefox, Chrome, Edge
from selenium.webdriver import FirefoxOptions, ChromeOptions, EdgeOptions

driverFF = Firefox()

driverFF.get('https://web-scraping.dev/product/13')

driverFF.find('https://web-scraping.dev/product/13')

driverFF.current_url

driverFF.page_source

driverFF.save_screenshot('ss.png')

driverFF.save_full_page_screenshot('ss.png')
