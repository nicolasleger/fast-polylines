require "spec_helper"

describe FastPolylines::Decoder do
  describe ".decode" do
    let(:points) { [[38.5, -120.2], [40.7, -120.95], [43.252, -126.453]] }
    context "with default precision" do
      let(:polyline) { "_p~iF~ps|U_ulLnnqC_mqNvxq`@" }
      it "should decode a polyline correctly" do
        expect(described_class.decode(polyline)).to eq points
      end
    end
    context "with 1e6 precision" do
      let(:polyline) { "_izlhA~rlgdF_{geC~ywl@_kwzCn`{nI" }
      it "should decode a polyline correctly" do
        expect(described_class.decode(polyline, 1e6)).to eq points
      end
    end
    context "with points that were close together" do
      let(:points) { [[41.35222, -86.04563], [41.35222, -86.04544]] }
      it "should decode a polyline correctly" do
        expect(described_class.decode("krk{FdxdlO?e@")).to eq points
      end
    end
    context "with points that cause float overflow" do
      let(:polyline) { "ahdiHsmeMHPDN|A`FVt@" }
      let(:points) { [[48.85137, 2.32682], [48.85132, 2.32673], [48.85129, 2.32665], [48.85082, 2.32552], [48.8507, 2.32525]] }
      it "should respect precision" do
        expect(described_class.decode(polyline)).to eq points
      end
    end
  end
end
