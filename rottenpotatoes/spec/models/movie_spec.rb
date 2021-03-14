require 'rails_helper'

RSpec.describe Movie, type: :model do
  
  describe '.find_similar_movies' do
    let!(:movie1) { FactoryGirl.create(:movie, title: 'Catch me if you can', director: 'Steven Spielberg') }
    let!(:movie2) { FactoryGirl.create(:movie, title: 'Seven', director: 'David Fincher') }
    let!(:movie3) { FactoryGirl.create(:movie, title: "Schindler's List", director: 'Steven Spielberg') }
    let!(:movie4) { FactoryGirl.create(:movie, title: "Stop") }

    context 'director exists' do
        it 'finds similar movies correctly' do
            Movie.with_director(movie1.title).should include(Movie.find_by_title('Catch me if you can'), Movie.find_by_title("Schindler's List"))
            Movie.with_director(movie1.title).should_not include(Movie.find_by_title('Seven'))
            Movie.with_director(movie2.title).should include(Movie.find_by_title('Seven'))
        end
    end

    context 'director does not exist' do
        it 'handles sad path' do
        expect(Movie.find_by_title(movie4.title).director).to eql(nil)
        end
    end
  
  end
end
