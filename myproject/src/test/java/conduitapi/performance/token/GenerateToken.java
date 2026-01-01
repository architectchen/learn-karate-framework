package conduitapi.performance.token;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;

import com.intuit.karate.Runner;

public class GenerateToken {
    private static List<String> tokens = new ArrayList<>();

    private static AtomicInteger counter = new AtomicInteger(0);

    private static String[] emails = { "conduit@example.com" };

    public static void generateToken() {
        for (String email : emails) {
            Map<String, Object> credential = new HashMap<>();
            credential.put("email", email);
            credential.put("password", email);
            Map<String, Object> result = Runner.runFeature("classpath:helper/GenerateTokenHelper.feature", credential,
                    true);
            tokens.add((String) result.get("token"));
        }
    }

    public static String getToken() {
        return tokens.get(counter.getAndIncrement() % tokens.size());
    }
}
