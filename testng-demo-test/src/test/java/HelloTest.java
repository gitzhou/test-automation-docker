import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.testng.Assert;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

/**
 * @author bjzquan
 */
public class HelloTest {

    private final static String TEST_URL = "https://github.com";
    private final static String PAGE_TITLE = "The world’s leading software development platform · GitHub";

    private WebDriver firefoxDriver;

    @BeforeMethod
    public void setupTest() {
        firefoxDriver = new FirefoxDriver();
        firefoxDriver.navigate().to(TEST_URL);
    }

    @Test
    public void firstTest() {
        Assert.assertEquals(firefoxDriver.getTitle(), PAGE_TITLE, "Page title assertion is failed using Firefox!");
    }

    @AfterMethod
    public void afterTest() {
        firefoxDriver.quit();
    }
}
