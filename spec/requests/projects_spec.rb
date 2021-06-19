require 'rails_helper'

describe 'Projects API', type: :request do
    describe 'GET /projects' do
        before do
            FactoryBot.create(:project, title: 'courseup', description: 'timetable builder is really awesome and it works great', caption: 'school made easy')
            FactoryBot.create(:project, title: 'uvic-course-scraper', description: 'course data fetching is fun and cool and i love school', caption: 'fetch uvic course data easy')
        end

        it 'returns all projects' do
            get '/api/v1/projects'

            expect(response).to have_http_status(:success)
            expect(JSON.parse(response.body).size).to eq(2)
        end
    end

    describe 'POST /projects' do
        it 'creates a new project' do
            expect {
                post '/api/v1/projects', params: { project: { title: 'courseup', description: 'timetable builder is really awesome and it works great', caption: 'school made easy' } }, headers: { "Authorization" => "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiMSJ9.M1vu6qDej7HzuSxcfbE6KAMekNUXB3EWtxwS0pg4UGg" }
            }.to change { Project.count }.from(0).to(1)

            expect(response).to have_http_status(:created)
        end
    end

    describe 'DELETE /projects/:id' do
        let!(:project) { FactoryBot.create(:project, title: 'courseup', description: 'timetable builder is really awesome and it works great', caption: 'school made easy') }

        it 'deletes a project' do
            expect {
                delete "/api/v1/projects/#{project.id}", headers: { "Authorization" => "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiMSJ9.M1vu6qDej7HzuSxcfbE6KAMekNUXB3EWtxwS0pg4UGg" }
            }.to change { Project.count }.from(1).to(0)

            expect(response).to have_http_status(:no_content)
        end
    end
end