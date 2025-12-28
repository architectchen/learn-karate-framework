package helper;

import com.github.javafaker.Faker;

import net.minidev.json.JSONObject;

public class GenerateDataHelper {

    public static String getRandomEmail() {
        Faker faker = new Faker();
        return faker.name().firstName().toLowerCase() + faker.random().nextInt(0, 100) + "@qq.com";
    }

    public static String getRandomUsername() {
        Faker faker = new Faker();
        return faker.name().username();
    }

    public String getRandomPassword() {
        Faker faker = new Faker();
        return faker.internet().password();
    }

    public static JSONObject getRandomArticle() {
        Faker faker = new Faker();
        String title = faker.gameOfThrones().character();
        String description = faker.gameOfThrones().city();
        String body = faker.gameOfThrones().quote();
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("title", title);
        jsonObject.put("description", description);
        jsonObject.put("body", body);
        return jsonObject;
    }
}
