require "application_system_test_case"

class ListEntriesTest < ApplicationSystemTestCase
  setup do
    @list_entry = list_entries(:one)
  end

  test "visiting the index" do
    visit list_entries_url
    assert_selector "h1", text: "List Entries"
  end

  test "creating a List entry" do
    visit list_entries_url
    click_on "New List Entry"

    fill_in "Title", with: @list_entry.title
    fill_in "Url", with: @list_entry.url
    click_on "Create List entry"

    assert_text "List entry was successfully created"
    click_on "Back"
  end

  test "updating a List entry" do
    visit list_entries_url
    click_on "Edit", match: :first

    fill_in "Title", with: @list_entry.title
    fill_in "Url", with: @list_entry.url
    click_on "Update List entry"

    assert_text "List entry was successfully updated"
    click_on "Back"
  end

  test "destroying a List entry" do
    visit list_entries_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "List entry was successfully destroyed"
  end
end
