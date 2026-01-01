package performance;

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._

import conduitapi.performance.token.GenerateToken

class PerfTest extends Simulation {
  GenerateToken.generateToken()

  val protocol = karateProtocol(
    "/api/articles/{slug}" -> Nil
  )

  protocol.nameResolver = (req, ctx) => req.getHeader("karate-name")

  val csvFeeder = csv("articles.csv").circular
  val tokenFeeder = Iterator.continually(Map("token" -> GenerateToken.getToken))

  val createArticle = scenario("Create and delete article").feed(csvFeeder).feed(tokenFeeder).exec(karateFeature("classpath:conduitapi/performance/CreateArticle.feature"))

  setUp(
    createArticle.inject(
      atOnceUsers(1),
      nothingFor(4 seconds),
      constantUsersPerSec(1) during (10 seconds),
      constantUsersPerSec(2) during (10 seconds),
      rampUsersPerSec(2) to 10 during (20 seconds),
      nothingFor(5 seconds),
      constantUsersPerSec(1) during (5 seconds)
    ).protocols(protocol)
  )
}