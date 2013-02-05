package springmvc.demo.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import java.util.Properties;
import java.io.InputStream;

/**
 * Sample controller for going to the home page with a message 
 * updated comment
 */
@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	private final Properties buildProperties;

	public HomeController() {
		buildProperties = new Properties();
		try {
			final InputStream propInputStream = getClass().getClassLoader().getResourceAsStream("build.properties");
			if (propInputStream != null) {
				buildProperties.load(propInputStream);
			}
		} catch (Exception e) {
			logger.error("Failed to load build.properties", e);
		}
	}

	/**
	 * Selects the home page and populates the model with a message
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		logger.info("Welcome home!");

		model.addAttribute("buildNumber", "cidemo-" + buildProperties.getProperty("buildNumber", "##"));
		model.addAttribute("controllerMessage", "This is the message from the controller!");
		return "home";
	}
	

}
