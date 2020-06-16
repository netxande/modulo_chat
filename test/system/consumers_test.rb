require "application_system_test_case"

class ConsumersTest < ApplicationSystemTestCase
  setup do
    @consumer = consumers(:one)
  end

  test "visiting the index" do
    visit consumers_url
    assert_selector "h1", text: "Consumers"
  end

  test "creating a Consumer" do
    visit consumers_url
    click_on "New Consumer"

    fill_in "Author", with: @consumer.author
    fill_in "Description", with: @consumer.description
    fill_in "Token", with: @consumer.token
    click_on "Create Consumer"

    assert_text "Consumer was successfully created"
    click_on "Back"
  end

  test "updating a Consumer" do
    visit consumers_url
    click_on "Edit", match: :first

    fill_in "Author", with: @consumer.author
    fill_in "Description", with: @consumer.description
    fill_in "Token", with: @consumer.token
    click_on "Update Consumer"

    assert_text "Consumer was successfully updated"
    click_on "Back"
  end

  test "destroying a Consumer" do
    visit consumers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Consumer was successfully destroyed"
  end
end
