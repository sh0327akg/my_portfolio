module GraphqlApi
  extend ActiveSupport::Concern

  included do
    AUTH_HEADER = "Bearer #{ENV['GITHUB_ACCESS_TOKEN']}"

    HTTPAdapter = GraphQL::Client::HTTP.new("https://api.github.com/graphql") do
      def headers(context)
        { "Authorization": AUTH_HEADER }
      end
    end
    Schema = GraphQL::Client.load_schema(HTTPAdapter)
    Client = GraphQL::Client.new(schema: Schema, execute: HTTPAdapter)

    TotalContributionsQuery = Client.parse <<-'GRAPHQL'
      query($user: String!) {
        user(login: $user) {
          contributionsCollection {
            contributionCalendar {
              totalContributions
            }
          }
        }
      }
    GRAPHQL
  end

  private

  def graphql_result(query, variables = {})
    Client.query(query, variables:).data
  end
end