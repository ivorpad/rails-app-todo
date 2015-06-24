require 'spec_helper'

describe "Creating todo lists" do
def create_todo_list(options={})
    options[:title] ||= "My todo list" #If we do not send in title, it's going to default be My todo list
    options[:description] ||= "This is my todo list."

    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New Todo List")

    fill_in "Title", with: options[:title]
    fill_in "Description", with: options[:description]
    click_button "Create Todo list"
  end

it "redirects to the todo list index page on success" do
    create_todo_list #you may not have gotten to the point of refactoring this part
    expect(page).to have_content("My todo list")
  end
it "displays an error when todo list has no title" do
    expect(TodoList.count).to eq(0)
    create_todo_list title: ""
    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit '/todo_lists'
    expect(page).to_not have_content("This is my todo list.")
  end
end