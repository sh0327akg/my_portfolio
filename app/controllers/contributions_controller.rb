class ContributionsController < ApplicationController
  before_action :result, only: [:index]

  Query = MyPortfolio::Client.parse <<-'GRAPHQL'
            query($userName: String!) {
              user(login: $userName) {
                contributionsCollection {
                  contributionCalendar {
                    totalContributions
                  }
                }
              }
            }
          GRAPHQL

  def index; end

  def new; end

  private

  def result(variables = {})
    reaponse = MyPortfolio::Client.query(Query, variables: variables)
  end
end
