# frozen_string_literal: true

shared_examples :graphql_request do |spec_name|
  let(:fixture_file) { File.read(File.join(RSpec.configuration.fixture_path, fixture_path)) }
  let(:parsed_fixture_file) do
    JSON.parse(respond_to?(:prepared_fixture_file) ? prepared_fixture_file : fixture_file)
  end
  let(:default_schema_context) { {} }
  let(:schema_options) { { context: respond_to?(:schema_context) ? schema_context : default_schema_context } }

  let(:response) { GraphqlSaasApiSchema.execute(query, schema_options).as_json }

  it spec_name do
    expect(response).to eql(parsed_fixture_file)
  end
end
