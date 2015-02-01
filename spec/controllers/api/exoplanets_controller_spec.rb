describe Api::ExoplanetsController do
  describe '#index' do
    subject!(:exoplanets) { 3.times.map { create :exoplanet } }

    it 'will list all exoplanets' do
      get :index
      expect(response.body).to include Exoplanet.all.to_json
    end
  end
end
