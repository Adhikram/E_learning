require "application_system_test_case"

class EnrollsTest < ApplicationSystemTestCase
  setup do
    @enroll = enrolls(:one)
  end

  test "visiting the index" do
    visit enrolls_url
    assert_selector "h1", text: "Enrolls"
  end

  test "creating a Enroll" do
    visit enrolls_url
    click_on "New Enroll"

    fill_in "Course", with: @enroll.course_id
    fill_in "Student", with: @enroll.student_id
    click_on "Create Enroll"

    assert_text "Enroll was successfully created"
    click_on "Back"
  end

  test "updating a Enroll" do
    visit enrolls_url
    click_on "Edit", match: :first

    fill_in "Course", with: @enroll.course_id
    fill_in "Student", with: @enroll.student_id
    click_on "Update Enroll"

    assert_text "Enroll was successfully updated"
    click_on "Back"
  end

  test "destroying a Enroll" do
    visit enrolls_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Enroll was successfully destroyed"
  end
end
