require 'rails_helper'

RSpec.describe "Project Show Page" do
  before(:each) do
    @recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
    @furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)
    
    @news_chic = @recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
    @boardfit = @recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")
    
    @upholstery_tux = @furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")
    @lit_fit = @furniture_challenge.projects.create(name: "Litfit", material: "Lamp")
    
    @jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
    @gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
    @kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
    @erin = Contestant.create(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15)

    ContestantProject.create(contestant_id: @jay.id, project_id: @news_chic.id)
    ContestantProject.create(contestant_id: @gretchen.id, project_id: @news_chic.id)
    ContestantProject.create(contestant_id: @gretchen.id, project_id: @upholstery_tux.id)
    ContestantProject.create(contestant_id: @kentaro.id, project_id: @upholstery_tux.id)
    ContestantProject.create(contestant_id: @kentaro.id, project_id: @boardfit.id)
    ContestantProject.create(contestant_id: @erin.id, project_id: @boardfit.id)

    end

  it 'when visiting project show page, user can see project name, material, and name of theme' do
    visit "/projects/#{@lit_fit.id}"
    expect(page).to have_content(@lit_fit.name)
    expect(page).to have_content(@lit_fit.material)
    expect(page).to have_content(@lit_fit.challenge.theme)
  end

  it 'when visiting project show page, user can see the number of contestants on the project' do
    visit "/projects/#{@upholstery_tux.id}"
    expect(page).to have_content(@upholstery_tux.name)
    expect(page).to have_content(@upholstery_tux.contestants.count)
  end

  it 'when visiting project show page, user can see the average years of experience per each contestant' do
    visit "/projects/#{@upholstery_tux.id}"

    expect(page).to have_content(@upholstery_tux.avg_experience)
  end

  xit 'when visiting project show page, user can add a contestant to a project' do
    visit "/projects/#{@boardfit.id}"
    expect(page).to have_content(@boardfit.name)
    check_count = @boardfit.contestants_count
    fill_in("Contestant", with: 2)
    expect(current_path).to eq("/projects/#{@boardfit.id}")
    expect(page).to have_content((check_count+=1))
  end
end