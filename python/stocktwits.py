"""
Basic scraping utility for stocktwits

Requires selenium and the Chrome Web Driver
"""

from selenium import webdriver
from selenium.webdriver.chrome.options import Options

BASE_URL = "https://stocktwits.com/symbol/"

class StockTwitsScraper:
    """
    Basic scraping utility for stocktwits
    """

    def __init__(self) -> None:
        """
        Class constructor
        """
        self.driver = None

    def _set_driver(self) -> None:
        """
        Set inst var to a new driver
        """
        # make driver headless
        chrome_options = Options()  
        chrome_options.add_argument("--headless")  
        # set the inst var with the new driver
        self.driver = webdriver.Chrome(options=chrome_options) 

    def connect(self) -> None:
        """
        Start the driver with options (headless is default)
        """
        if self.driver is None:
            self._set_driver

    def disconnect(self) -> None:
        """
        Destroy driver
        """
        self.driver = None

    def search(self, symbol: str):
        """
        Get data for a symbol
        """

        ### get the source
        # navigate to the page
        self.driver.get(BASE_URL + symbol)
        # extract data
        self.driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
        html_source = self.driver.page_source
        data = html_source.encode('utf-8')

        # parse the source; return dict?

