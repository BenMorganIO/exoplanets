describe Api::ExoplanetsController do
  describe '#index' do
    subject!(:exoplanets) { 3.times.map { create :exoplanet } }

    it 'will list all exoplanets' do
      get :index
      expect(response.body).to include Exoplanet.all.to_json
    end

    describe "page" do
      it "will list the first page of exoplanets" do
        get :index, page: 1, per_page: 2
        expect(response.body).to_not include Exoplanet.last.to_json
      end
    end

    describe "per_page" do
      it "will set the number of exoplanets listed" do
        get :index, page: 1, per_page: 2
        expect(JSON.parse(response.body)['exoplanets'].length).to eql 2
      end
    end

    describe "ids" do
      it "will list all exoplanets with given ids" do
        exoplanets.pop
        ids = exoplanets.map(&:id)
        get :index, ids: ids
        expect(response.body).to include exoplanets.to_json
      end

      it "will not list exoplanets without given ids" do
        exoplanet = exoplanets.pop
        ids = exoplanets.map(&:id)
        get :index, ids: ids
        expect(response.body).to_not include exoplanet.to_json
      end
    end
  end
end
