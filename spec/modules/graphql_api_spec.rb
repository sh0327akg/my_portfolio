require 'rails_helper'

RSpec.describe GraphqlApi, type: :module do
  let(:user) { "test_user" }
  let(:client) { GraphqlApi::Client }
  let(:query_response) { double('QueryResponse', data: 'data') }

  before do
    allow(client).to receive(:query).and_return(query_response)
  end
  
  describe 'TotalContributionsQuery' do
    it '適切な引数でClient.queryを呼び出すこと' do
      expect(client).to receive(:query).with(GraphqlApi::TotalContributionsQuery, variables: { user: user })
      GraphqlApi.graphql_result(GraphqlApi::TotalContributionsQuery, { user: user })
    end
  end

  describe 'ContributionStreakQuery' do
    it '適切な引数でClient.queryを呼び出すこと' do
      expect(client).to receive(:query).with(GraphqlApi::ContributionStreakQuery, variables: { user: user })
      GraphqlApi.graphql_result(GraphqlApi::ContributionStreakQuery, { user: user })
    end
  end
end