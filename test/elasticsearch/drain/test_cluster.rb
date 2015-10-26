require 'test_helper'
require 'pp'

class TestCluster < Minitest::Test
  def setup
    VCR.insert_cassette 'cluster', record: :new_episodes
    @cluster = ::Elasticsearch::Drain::Cluster.new('localhost:9250')
  end

  def teardown
    VCR.eject_cassette
  end

  def test_cluster_health_is_green
    assert @cluster.healthy?
  end

  def test_cluster_relocating_shards
    refute @cluster.relocating_shards?
  end
end
