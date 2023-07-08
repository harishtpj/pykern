from selenium import webdriver
from selenium.webdriver.firefox.service import Service as FirefoxService
from webdriver_manager.firefox import GeckoDriverManager
from selenium.webdriver.common.by import By

browser = webdriver.Firefox(service=FirefoxService(GeckoDriverManager().install()))

browser.get("http://copy.sh/v86/")
browser.maximize_window()

upload_iso = browser.find_element(By.XPATH, "/html/body/div[1]/div[1]/table[2]/tbody/tr[1]/td[2]/input")
upload_iso.send_keys("\\\\wsl$\\Ubuntu\\home\\harish\\projects\\pykern\\os.iso")

browser.find_element(By.XPATH, "/html/body/div[1]/div[1]/button").click()

while not browser.current_url == "http://copy.sh/v86/":
    continue

browser.quit()