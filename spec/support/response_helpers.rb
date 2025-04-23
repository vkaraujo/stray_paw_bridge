module ResponseHelpers
  def expect_redirect_to_path(expected_path)
    actual_path = URI.parse(response.location).path
    expect(actual_path).to eq(expected_path)
  end
end
