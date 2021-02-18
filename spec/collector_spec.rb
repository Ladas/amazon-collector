require "topological_inventory/amazon/collector/metrics"
require "aws-sdk-ec2"
require "aws-sdk-cloudformation"
require "aws-sdk-pricing"
require "aws-sdk-servicecatalog"
require_relative 'aws_stubs'

RSpec.describe TopologicalInventory::Amazon::Collector do
  include AwsStubs

  it "collects and parses vms" do
    parser = collect_and_parse(:vms)

    expect(format_hash(:vms, parser)).to(
      match_array(
        [
          {:flavor              =>
                                   {:inventory_collection_name => :flavors,
                                    :reference                 => {:source_ref => "m3.medium"},
                                    :ref                       => :manager_ref},
           :mac_addresses       => ["06:d5:e7:4e:c8:01"],
           :name                => "instance_0",
           :orchestration_stack => nil,
           :power_state         => "on",
           :guest_info          => nil,
           :source_ref          => "instance_0",
           :source_region       =>
                                   {:inventory_collection_name => :source_regions,
                                    :reference                 => {:source_ref => "us-east-1"},
                                    :ref                       => :manager_ref},
           :subscription        => nil,
           :uid_ems             => "instance_0"},
          {:flavor              =>
                                   {:inventory_collection_name => :flavors,
                                    :reference                 => {:source_ref => "m3.medium"},
                                    :ref                       => :manager_ref},
           :mac_addresses       => [],
           :name                => "instance_ec2_0",
           :orchestration_stack => nil,
           :power_state         => "on",
           :guest_info          => nil,
           :source_ref          => "instance_ec2_0",
           :source_region       =>
                                   {:inventory_collection_name => :source_regions,
                                    :reference                 => {:source_ref => "us-east-1"},
                                    :ref                       => :manager_ref},
           :subscription        => nil,
           :uid_ems             => "instance_ec2_0"},
          {:flavor              =>
                                   {:inventory_collection_name => :flavors,
                                    :reference                 => {:source_ref => "m3.medium"},
                                    :ref                       => :manager_ref},
           :mac_addresses       => ["06:d5:e7:4e:c8:01"],
           :name                => "instance_0",
           :orchestration_stack => nil,
           :power_state         => "on",
           :guest_info          => nil,
           :source_ref          => "instance_0",
           :source_region       =>
                                   {:inventory_collection_name => :source_regions,
                                    :reference                 => {:source_ref => "us-west-1"},
                                    :ref                       => :manager_ref},
           :subscription        => nil,
           :uid_ems             => "instance_0"},
          {:flavor              =>
                                   {:inventory_collection_name => :flavors,
                                    :reference                 => {:source_ref => "m3.medium"},
                                    :ref                       => :manager_ref},
           :mac_addresses       => [],
           :name                => "instance_ec2_0",
           :orchestration_stack => nil,
           :power_state         => "on",
           :guest_info          => nil,
           :source_ref          => "instance_ec2_0",
           :source_region       =>
                                   {:inventory_collection_name => :source_regions,
                                    :reference                 => {:source_ref => "us-west-1"},
                                    :ref                       => :manager_ref},
           :subscription        => nil,
           :uid_ems             => "instance_ec2_0"}
        ]
      )
    )

    expect(format_hash(:vm_tags, parser)).to(
      match_array(
        [
          {:tag =>
                   {:inventory_collection_name => :tags,
                    :reference                 =>
                                                  {:name      => "tag_01_for_instance_0",
                                                   :value     => "tag_01_value_for_instance_0",
                                                   :namespace => "amazon"},
                    :ref                       => :manager_ref},
           :vm  =>
                   {:inventory_collection_name => :vms,
                    :reference                 => {:source_ref => "instance_0"},
                    :ref                       => :manager_ref}},
          {:tag =>
                   {:inventory_collection_name => :tags,
                    :reference                 =>
                                                  {:name      => "tag_02_for_instance_0",
                                                   :value     => "tag_02_value_for_instance_0",
                                                   :namespace => "amazon"},
                    :ref                       => :manager_ref},
           :vm  =>
                   {:inventory_collection_name => :vms,
                    :reference                 => {:source_ref => "instance_0"},
                    :ref                       => :manager_ref}},
          {:tag =>
                   {:inventory_collection_name => :tags,
                    :reference                 =>
                                                  {:name      => "tag_03_for_instance_0",
                                                   :value     => "tag_03_value_for_instance_0",
                                                   :namespace => "amazon"},
                    :ref                       => :manager_ref},
           :vm  =>
                   {:inventory_collection_name => :vms,
                    :reference                 => {:source_ref => "instance_0"},
                    :ref                       => :manager_ref}},
          {:tag =>
                   {:inventory_collection_name => :tags,
                    :reference                 =>
                                                  {:name      => "tag_01_for_instance_0",
                                                   :value     => "tag_01_value_for_instance_0",
                                                   :namespace => "amazon"},
                    :ref                       => :manager_ref},
           :vm  =>
                   {:inventory_collection_name => :vms,
                    :reference                 => {:source_ref => "instance_ec2_0"},
                    :ref                       => :manager_ref}},
          {:tag =>
                   {:inventory_collection_name => :tags,
                    :reference                 =>
                                                  {:name      => "tag_02_for_instance_0",
                                                   :value     => "tag_02_value_for_instance_0",
                                                   :namespace => "amazon"},
                    :ref                       => :manager_ref},
           :vm  =>
                   {:inventory_collection_name => :vms,
                    :reference                 => {:source_ref => "instance_ec2_0"},
                    :ref                       => :manager_ref}},
          {:tag =>
                   {:inventory_collection_name => :tags,
                    :reference                 =>
                                                  {:name      => "tag_03_for_instance_0",
                                                   :value     => "tag_03_value_for_instance_0",
                                                   :namespace => "amazon"},
                    :ref                       => :manager_ref},
           :vm  =>
                   {:inventory_collection_name => :vms,
                    :reference                 => {:source_ref => "instance_ec2_0"},
                    :ref                       => :manager_ref}},
          {:tag =>
                   {:inventory_collection_name => :tags,
                    :reference                 =>
                                                  {:name      => "tag_01_for_instance_0",
                                                   :value     => "tag_01_value_for_instance_0",
                                                   :namespace => "amazon"},
                    :ref                       => :manager_ref},
           :vm  =>
                   {:inventory_collection_name => :vms,
                    :reference                 => {:source_ref => "instance_0"},
                    :ref                       => :manager_ref}},
          {:tag =>
                   {:inventory_collection_name => :tags,
                    :reference                 =>
                                                  {:name      => "tag_02_for_instance_0",
                                                   :value     => "tag_02_value_for_instance_0",
                                                   :namespace => "amazon"},
                    :ref                       => :manager_ref},
           :vm  =>
                   {:inventory_collection_name => :vms,
                    :reference                 => {:source_ref => "instance_0"},
                    :ref                       => :manager_ref}},
          {:tag =>
                   {:inventory_collection_name => :tags,
                    :reference                 =>
                                                  {:name      => "tag_03_for_instance_0",
                                                   :value     => "tag_03_value_for_instance_0",
                                                   :namespace => "amazon"},
                    :ref                       => :manager_ref},
           :vm  =>
                   {:inventory_collection_name => :vms,
                    :reference                 => {:source_ref => "instance_0"},
                    :ref                       => :manager_ref}},
          {:tag =>
                   {:inventory_collection_name => :tags,
                    :reference                 =>
                                                  {:name      => "tag_01_for_instance_0",
                                                   :value     => "tag_01_value_for_instance_0",
                                                   :namespace => "amazon"},
                    :ref                       => :manager_ref},
           :vm  =>
                   {:inventory_collection_name => :vms,
                    :reference                 => {:source_ref => "instance_ec2_0"},
                    :ref                       => :manager_ref}},
          {:tag =>
                   {:inventory_collection_name => :tags,
                    :reference                 =>
                                                  {:name      => "tag_02_for_instance_0",
                                                   :value     => "tag_02_value_for_instance_0",
                                                   :namespace => "amazon"},
                    :ref                       => :manager_ref},
           :vm  =>
                   {:inventory_collection_name => :vms,
                    :reference                 => {:source_ref => "instance_ec2_0"},
                    :ref                       => :manager_ref}},
          {:tag =>
                   {:inventory_collection_name => :tags,
                    :reference                 =>
                                                  {:name      => "tag_03_for_instance_0",
                                                   :value     => "tag_03_value_for_instance_0",
                                                   :namespace => "amazon"},
                    :ref                       => :manager_ref},
           :vm  =>
                   {:inventory_collection_name => :vms,
                    :reference                 => {:source_ref => "instance_ec2_0"},
                    :ref                       => :manager_ref}}
        ]
      )
    )

    expect(format_hash(:network_adapters, parser)).to(
      match_array(
        [
          {:device              =>
                                   {:inventory_collection_name => :vms,
                                    :reference                 => {:source_ref => "instance_0"},
                                    :ref                       => :manager_ref},
           :mac_address         => nil,
           :orchestration_stack => nil,
           :source_ref          => "instance_0",
           :source_region       =>
                                   {:inventory_collection_name => :source_regions,
                                    :reference                 => {:source_ref => "us-east-1"},
                                    :ref                       => :manager_ref},
           :subscription        => nil},
          {:device              =>
                                   {:inventory_collection_name => :vms,
                                    :reference                 => {:source_ref => "instance_ec2_0"},
                                    :ref                       => :manager_ref},
           :mac_address         => nil,
           :orchestration_stack => nil,
           :source_ref          => "instance_ec2_0",
           :source_region       =>
                                   {:inventory_collection_name => :source_regions,
                                    :reference                 => {:source_ref => "us-east-1"},
                                    :ref                       => :manager_ref},
           :subscription        => nil},
          {:device              =>
                                   {:inventory_collection_name => :vms,
                                    :reference                 => {:source_ref => "instance_0"},
                                    :ref                       => :manager_ref},
           :mac_address         => nil,
           :orchestration_stack => nil,
           :extra               =>
                                   {:association       => nil,
                                    :attachment        => {:instance_id => "instance_0"},
                                    :ipv_6_addresses   => [],
                                    :groups            => [],
                                    :availability_zone => nil,
                                    :description       => nil,
                                    :interface_type    => nil,
                                    :private_dns_name  => nil,
                                    :status            => nil,
                                    :requester_id      => nil,
                                    :requester_managed => nil,
                                    :source_dest_check => nil},
           :source_ref          => "network_interface_0",
           :source_region       =>
                                   {:inventory_collection_name => :source_regions,
                                    :reference                 => {:source_ref => "us-east-1"},
                                    :ref                       => :manager_ref},
           :subscription        => nil},
          {:device              =>
                                   {:inventory_collection_name => :vms,
                                    :reference                 => {:source_ref => "instance_0"},
                                    :ref                       => :manager_ref},
           :mac_address         => nil,
           :orchestration_stack => nil,
           :source_ref          => "instance_0",
           :source_region       =>
                                   {:inventory_collection_name => :source_regions,
                                    :reference                 => {:source_ref => "us-west-1"},
                                    :ref                       => :manager_ref},
           :subscription        => nil},
          {:device              =>
                                   {:inventory_collection_name => :vms,
                                    :reference                 => {:source_ref => "instance_ec2_0"},
                                    :ref                       => :manager_ref},
           :mac_address         => nil,
           :orchestration_stack => nil,
           :source_ref          => "instance_ec2_0",
           :source_region       =>
                                   {:inventory_collection_name => :source_regions,
                                    :reference                 => {:source_ref => "us-west-1"},
                                    :ref                       => :manager_ref},
           :subscription        => nil},
          {:device              =>
                                   {:inventory_collection_name => :vms,
                                    :reference                 => {:source_ref => "instance_0"},
                                    :ref                       => :manager_ref},
           :mac_address         => nil,
           :orchestration_stack => nil,
           :extra               =>
                                   {:association       => nil,
                                    :attachment        => {:instance_id => "instance_0"},
                                    :ipv_6_addresses   => [],
                                    :groups            => [],
                                    :availability_zone => nil,
                                    :description       => nil,
                                    :interface_type    => nil,
                                    :private_dns_name  => nil,
                                    :status            => nil,
                                    :requester_id      => nil,
                                    :requester_managed => nil,
                                    :source_dest_check => nil},
           :source_ref          => "network_interface_0",
           :source_region       =>
                                   {:inventory_collection_name => :source_regions,
                                    :reference                 => {:source_ref => "us-west-1"},
                                    :ref                       => :manager_ref},
           :subscription        => nil}
        ]
      )
    )

    expect(format_hash(:network_adapter_tags, parser)).to(
      match_array([])
    )

    # items sometimes have nil values, sometimes not
    # it's caused by several definitions in floating_ip/network_adapter/vm
    # - nil is present if hash <key> => nil is present (nullable openapi's property)
    expect(format_hash(:ipaddresses, parser)).to(
      match_array(
        [
          {:extra           => {:primary => true, :private_dns_name => nil},
           :ipaddress       => "10.0.0.0",
           :kind            => "private",
           :network_adapter =>
                               {:inventory_collection_name => :network_adapters,
                                :reference                 => {:source_ref => "instance_0"},
                                :ref                       => :manager_ref},
           :source_ref      => "instance_0______10.0.0.0",
           :source_region   =>
                               {:inventory_collection_name => :source_regions,
                                :reference                 => {:source_ref => "us-east-1"},
                                :ref                       => :manager_ref},
           :subnet          => nil},
          {:extra           => {:private_ip_address => "10.0.0.0"},
           :ipaddress       => "40.0.0.0",
           :kind            => "public",
           :network_adapter =>
                               {:inventory_collection_name => :network_adapters,
                                :reference                 => {:source_ref => "instance_0"},
                                :ref                       => :manager_ref},
           :source_ref      => "40.0.0.0",
           :source_region   =>
                               {:inventory_collection_name => :source_regions,
                                :reference                 => {:source_ref => "us-east-1"},
                                :ref                       => :manager_ref},
           :subnet          => nil},
          {:extra           => {:primary => true, :private_dns_name => nil},
           :ipaddress       => "11.0.0.0",
           :kind            => "private",
           :network_adapter =>
                               {:inventory_collection_name => :network_adapters,
                                :reference                 => {:source_ref => "instance_ec2_0"},
                                :ref                       => :manager_ref},
           :source_ref      => "instance_ec2_0______11.0.0.0",
           :source_region   =>
                               {:inventory_collection_name => :source_regions,
                                :reference                 => {:source_ref => "us-east-1"},
                                :ref                       => :manager_ref},
           :subnet          => nil},
          {:extra           => {:private_ip_address => "11.0.0.0"},
           :ipaddress       => "41.0.0.0",
           :kind            => "public",
           :network_adapter =>
                               {:inventory_collection_name => :network_adapters,
                                :reference                 => {:source_ref => "instance_ec2_0"},
                                :ref                       => :manager_ref},
           :source_ref      => "41.0.0.0",
           :source_region   =>
                               {:inventory_collection_name => :source_regions,
                                :reference                 => {:source_ref => "us-east-1"},
                                :ref                       => :manager_ref},
           :subnet          => nil},
          {:extra           =>
                               {:primary          => true,
                                :private_dns_name => nil,
                                :association      => {:public_ip => "58.0.0.0"}},
           :ipaddress       => "10.0.0.0",
           :kind            => "private",
           :network_adapter =>
                               {:inventory_collection_name => :network_adapters,
                                :reference                 => {:source_ref => "network_interface_0"},
                                :ref                       => :manager_ref},
           :source_ref      => "network_interface_0___subnet_0___10.0.0.0",
           :source_region   =>
                               {:inventory_collection_name => :source_regions,
                                :reference                 => {:source_ref => "us-east-1"},
                                :ref                       => :manager_ref},
           :subnet          =>
                               {:inventory_collection_name => :subnets,
                                :reference                 => {:source_ref => "subnet_0"},
                                :ref                       => :manager_ref}},
          {:extra           => {:primary => nil, :private_dns_name => nil, :association => nil},
           :ipaddress       => "11.0.0.0",
           :kind            => "private",
           :network_adapter =>
                               {:inventory_collection_name => :network_adapters,
                                :reference                 => {:source_ref => "network_interface_0"},
                                :ref                       => :manager_ref},
           :source_ref      => "network_interface_0___subnet_0___11.0.0.0",
           :source_region   =>
                               {:inventory_collection_name => :source_regions,
                                :reference                 => {:source_ref => "us-east-1"},
                                :ref                       => :manager_ref},
           :subnet          =>
                               {:inventory_collection_name => :subnets,
                                :reference                 => {:source_ref => "subnet_0"},
                                :ref                       => :manager_ref}},
          {:extra           => {:private_ip_address => nil},
           :ipaddress       => "58.0.0.0",
           :kind            => "public",
           :network_adapter =>
                               {:inventory_collection_name => :network_adapters,
                                :reference                 => {:source_ref => "network_interface_0"},
                                :ref                       => :manager_ref},
           :source_ref      => "58.0.0.0",
           :source_region   =>
                               {:inventory_collection_name => :source_regions,
                                :reference                 => {:source_ref => "us-east-1"},
                                :ref                       => :manager_ref},
           :subnet          => nil},
          {:extra               =>
                                   {:allocation_id      => "allocation_0",
                                    :association_id     => nil,
                                    :instance_id        => "instance_0",
                                    :domain             => "vpc",
                                    :public_ipv_4_pool  => nil,
                                    :private_ip_address => nil},
           :ipaddress           => "54.0.0.0",
           :kind                => "elastic",
           :network_adapter     => nil,
           :orchestration_stack => nil,
           :source_ref          => "allocation_0",
           :source_region       =>
                                   {:inventory_collection_name => :source_regions,
                                    :reference                 => {:source_ref => "us-east-1"},
                                    :ref                       => :manager_ref},
           :subscription        => nil},
          {:extra           => {:primary => true, :private_dns_name => nil},
           :ipaddress       => "10.0.0.0",
           :kind            => "private",
           :network_adapter =>
                               {:inventory_collection_name => :network_adapters,
                                :reference                 => {:source_ref => "instance_0"},
                                :ref                       => :manager_ref},
           :source_ref      => "instance_0______10.0.0.0",
           :source_region   =>
                               {:inventory_collection_name => :source_regions,
                                :reference                 => {:source_ref => "us-west-1"},
                                :ref                       => :manager_ref},
           :subnet          => nil},
          {:extra           => {:private_ip_address => "10.0.0.0"},
           :ipaddress       => "40.0.0.0",
           :kind            => "public",
           :network_adapter =>
                               {:inventory_collection_name => :network_adapters,
                                :reference                 => {:source_ref => "instance_0"},
                                :ref                       => :manager_ref},
           :source_ref      => "40.0.0.0",
           :source_region   =>
                               {:inventory_collection_name => :source_regions,
                                :reference                 => {:source_ref => "us-west-1"},
                                :ref                       => :manager_ref},
           :subnet          => nil},
          {:extra           => {:primary => true, :private_dns_name => nil},
           :ipaddress       => "11.0.0.0",
           :kind            => "private",
           :network_adapter =>
                               {:inventory_collection_name => :network_adapters,
                                :reference                 => {:source_ref => "instance_ec2_0"},
                                :ref                       => :manager_ref},
           :source_ref      => "instance_ec2_0______11.0.0.0",
           :source_region   =>
                               {:inventory_collection_name => :source_regions,
                                :reference                 => {:source_ref => "us-west-1"},
                                :ref                       => :manager_ref},
           :subnet          => nil},
          {:extra           => {:private_ip_address => "11.0.0.0"},
           :ipaddress       => "41.0.0.0",
           :kind            => "public",
           :network_adapter =>
                               {:inventory_collection_name => :network_adapters,
                                :reference                 => {:source_ref => "instance_ec2_0"},
                                :ref                       => :manager_ref},
           :source_ref      => "41.0.0.0",
           :source_region   =>
                               {:inventory_collection_name => :source_regions,
                                :reference                 => {:source_ref => "us-west-1"},
                                :ref                       => :manager_ref},
           :subnet          => nil},
          {:extra           =>
                               {:primary          => true,
                                :private_dns_name => nil,
                                :association      => {:public_ip => "58.0.0.0"}},
           :ipaddress       => "10.0.0.0",
           :kind            => "private",
           :network_adapter =>
                               {:inventory_collection_name => :network_adapters,
                                :reference                 => {:source_ref => "network_interface_0"},
                                :ref                       => :manager_ref},
           :source_ref      => "network_interface_0___subnet_0___10.0.0.0",
           :source_region   =>
                               {:inventory_collection_name => :source_regions,
                                :reference                 => {:source_ref => "us-west-1"},
                                :ref                       => :manager_ref},
           :subnet          =>
                               {:inventory_collection_name => :subnets,
                                :reference                 => {:source_ref => "subnet_0"},
                                :ref                       => :manager_ref}},
          {:extra           => {:primary => nil, :private_dns_name => nil, :association => nil},
           :ipaddress       => "11.0.0.0",
           :kind            => "private",
           :network_adapter =>
                               {:inventory_collection_name => :network_adapters,
                                :reference                 => {:source_ref => "network_interface_0"},
                                :ref                       => :manager_ref},
           :source_ref      => "network_interface_0___subnet_0___11.0.0.0",
           :source_region   =>
                               {:inventory_collection_name => :source_regions,
                                :reference                 => {:source_ref => "us-west-1"},
                                :ref                       => :manager_ref},
           :subnet          =>
                               {:inventory_collection_name => :subnets,
                                :reference                 => {:source_ref => "subnet_0"},
                                :ref                       => :manager_ref}},
          {:extra           => {:private_ip_address => nil},
           :ipaddress       => "58.0.0.0",
           :kind            => "public",
           :network_adapter =>
                               {:inventory_collection_name => :network_adapters,
                                :reference                 => {:source_ref => "network_interface_0"},
                                :ref                       => :manager_ref},
           :source_ref      => "58.0.0.0",
           :source_region   =>
                               {:inventory_collection_name => :source_regions,
                                :reference                 => {:source_ref => "us-west-1"},
                                :ref                       => :manager_ref},
           :subnet          => nil},
          {:extra               =>
                                   {:allocation_id      => "allocation_0",
                                    :association_id     => nil,
                                    :instance_id        => "instance_0",
                                    :domain             => "vpc",
                                    :public_ipv_4_pool  => nil,
                                    :private_ip_address => nil},
           :ipaddress           => "54.0.0.0",
           :kind                => "elastic",
           :network_adapter     => nil,
           :orchestration_stack => nil,
           :source_ref          => "allocation_0",
           :source_region       =>
                                   {:inventory_collection_name => :source_regions,
                                    :reference                 => {:source_ref => "us-west-1"},
                                    :ref                       => :manager_ref},
           :subscription        => nil}
        ]
      )
    )

    expect(format_hash(:ipaddress_tags, parser)).to(
      match_array(
        [
          {:ipaddress =>
                         {:inventory_collection_name => :ipaddresses,
                          :reference                 => {:source_ref => "allocation_0"},
                          :ref                       => :manager_ref},
           :tag       =>
                         {:inventory_collection_name => :tags,
                          :reference                 => {:name => "is_floating", :value => "true", :namespace => "amazon"},
                          :ref                       => :manager_ref}},
          {:ipaddress =>
                         {:inventory_collection_name => :ipaddresses,
                          :reference                 => {:source_ref => "allocation_0"},
                          :ref                       => :manager_ref},
           :tag       =>
                         {:inventory_collection_name => :tags,
                          :reference                 => {:name => "color", :value => "void", :namespace => "amazon"},
                          :ref                       => :manager_ref}},
          {:ipaddress =>
                         {:inventory_collection_name => :ipaddresses,
                          :reference                 => {:source_ref => "allocation_0"},
                          :ref                       => :manager_ref},
           :tag       =>
                         {:inventory_collection_name => :tags,
                          :reference                 => {:name => "is_floating", :value => "true", :namespace => "amazon"},
                          :ref                       => :manager_ref}},
          {:ipaddress =>
                         {:inventory_collection_name => :ipaddresses,
                          :reference                 => {:source_ref => "allocation_0"},
                          :ref                       => :manager_ref},
           :tag       =>
                         {:inventory_collection_name => :tags,
                          :reference                 => {:name => "color", :value => "void", :namespace => "amazon"},
                          :ref                       => :manager_ref}}
        ]
      )
    )

    expect(format_hash(:vm_security_groups, parser)).to(
      match_array(
        [
          {:security_group =>
                              {:inventory_collection_name => :security_groups,
                               :reference                 => {:source_ref => "security_group_0"},
                               :ref                       => :manager_ref},
           :vm             =>
                              {:inventory_collection_name => :vms,
                               :reference                 => {:source_ref => "instance_0"},
                               :ref                       => :manager_ref}},
          {:security_group =>
                              {:inventory_collection_name => :security_groups,
                               :reference                 => {:source_ref => "security_group_0"},
                               :ref                       => :manager_ref},
           :vm             =>
                              {:inventory_collection_name => :vms,
                               :reference                 => {:source_ref => "instance_0"},
                               :ref                       => :manager_ref}}
        ]
      )
    )
  end

  it "collects and parses networks" do
    parser = collect_and_parse(:networks)

    expect(format_hash(:networks, parser)).to(
      match_array(
        [
          {:cidr                => nil,
           :extra               =>
                                   {:ipv_6_cidr_block_association_set => [],
                                    :cidr_block_association_set       => [],
                                    :dhcp_options_id                  => nil,
                                    :is_default                       => nil,
                                    :instance_tenancy                 => nil},
           :name                => "vpc_0",
           :orchestration_stack => nil,
           :source_ref          => "vpc_0",
           :source_region       =>
                                   {:inventory_collection_name => :source_regions,
                                    :reference                 => {:source_ref => "us-east-1"},
                                    :ref                       => :manager_ref},
           :subscription        => nil,
           :status              => "inactive"},
          {:cidr                => nil,
           :extra               =>
                                   {:ipv_6_cidr_block_association_set => [],
                                    :cidr_block_association_set       => [],
                                    :dhcp_options_id                  => nil,
                                    :is_default                       => nil,
                                    :instance_tenancy                 => nil},
           :name                => "vpc_0",
           :orchestration_stack => nil,
           :source_ref          => "vpc_0",
           :source_region       =>
                                   {:inventory_collection_name => :source_regions,
                                    :reference                 => {:source_ref => "us-west-1"},
                                    :ref                       => :manager_ref},
           :subscription        => nil,
           :status              => "inactive"}
        ]
      )
    )

    expect(format_hash(:network_tags, parser)).to(
      match_array([])
    )
  end

  it "collects and parses subnets" do
    parser = collect_and_parse(:subnets)

    expect(format_hash(:subnets, parser)).to(
      match_array(
        [
          {:cidr                => nil,
           :extra               =>
                                   {:subnet_arn                       => nil,
                                    :availability_zone                => nil,
                                    :available_ip_address_count       => nil,
                                    :default_for_az                   => nil,
                                    :map_public_ip_on_launch          => nil,
                                    :assign_ipv_6_address_on_creation => nil,
                                    :ipv_6_cidr_block_association_set => []},
           :name                => "subnet_0",
           :network             =>
                                   {:inventory_collection_name => :networks,
                                    :reference                 => {:source_ref => "vpc_0"},
                                    :ref                       => :manager_ref},
           :source_ref          => "subnet_0",
           :source_region       =>
                                   {:inventory_collection_name => :source_regions,
                                    :reference                 => {:source_ref => "us-east-1"},
                                    :ref                       => :manager_ref},
           :subscription        => nil,
           :status              => nil,
           :orchestration_stack => nil},
          {:cidr                => nil,
           :extra               =>
                                   {:subnet_arn                       => nil,
                                    :availability_zone                => nil,
                                    :available_ip_address_count       => nil,
                                    :default_for_az                   => nil,
                                    :map_public_ip_on_launch          => nil,
                                    :assign_ipv_6_address_on_creation => nil,
                                    :ipv_6_cidr_block_association_set => []},
           :name                => "subnet_0",
           :network             =>
                                   {:inventory_collection_name => :networks,
                                    :reference                 => {:source_ref => "vpc_0"},
                                    :ref                       => :manager_ref},
           :source_ref          => "subnet_0",
           :source_region       =>
                                   {:inventory_collection_name => :source_regions,
                                    :reference                 => {:source_ref => "us-west-1"},
                                    :ref                       => :manager_ref},
           :subscription        => nil,
           :status              => nil,
           :orchestration_stack => nil}
        ]
      )
    )

    expect(format_hash(:subnet_tags, parser)).to(
      match_array([])
    )
  end

  it "collects and parses security_groups" do
    parser = collect_and_parse(:security_groups)

    expect(format_hash(:security_groups, parser)).to(
      match_array(
        [
          {:extra               =>
                                   {:ip_permissions        =>
                                                              [{:from_port           => 0,
                                                                :ip_protocol         => "TCP",
                                                                :to_port             => 0,
                                                                :user_id_group_pairs => [{:vpc_id => "vpc_0"}]}],
                                    :ip_permissions_egress =>
                                                              [{:from_port   => 0,
                                                                :ip_protocol => "TCP",
                                                                :ip_ranges   => [{:cidr_ip => "0.0.0.0/0"}],
                                                                :to_port     => 0}]},
           :description         => nil,
           :name                => "security_group_0",
           :source_ref          => "security_group_0",
           :source_region       =>
                                   {:inventory_collection_name => :source_regions,
                                    :reference                 => {:source_ref => "us-east-1"},
                                    :ref                       => :manager_ref},
           :subscription        => nil,
           :orchestration_stack => nil,
           :network             =>
                                   {:inventory_collection_name => :networks,
                                    :reference                 => {:source_ref => "vpc_0"},
                                    :ref                       => :manager_ref},},
          {:extra               =>
                                   {:ip_permissions        =>
                                                              [{:from_port           => 0,
                                                                :ip_protocol         => "TCP",
                                                                :to_port             => 0,
                                                                :user_id_group_pairs => [{:vpc_id => "vpc_0"}]}],
                                    :ip_permissions_egress =>
                                                              [{:from_port   => 0,
                                                                :ip_protocol => "TCP",
                                                                :ip_ranges   => [{:cidr_ip => "0.0.0.0/0"}],
                                                                :to_port     => 0}]},
           :description         => nil,
           :name                => "security_group_0",
           :source_ref          => "security_group_0",
           :source_region       =>
                                   {:inventory_collection_name => :source_regions,
                                    :reference                 => {:source_ref => "us-west-1"},
                                    :ref                       => :manager_ref},
           :subscription        => nil,
           :orchestration_stack => nil,
           :network             =>
                                   {:inventory_collection_name => :networks,
                                    :reference                 => {:source_ref => "vpc_0"},
                                    :ref                       => :manager_ref},}
        ]
      )
    )

    expect(format_hash(:security_group_tags, parser)).to(
      match_array(
        [
          {:security_group =>
                              {:inventory_collection_name => :security_groups,
                               :reference                 => {:source_ref => "security_group_0"},
                               :ref                       => :manager_ref},
           :tag            =>
                              {:inventory_collection_name => :tags,
                               :reference                 => {:name => "is_secure", :value => "true", :namespace => "amazon"},
                               :ref                       => :manager_ref}},
          {:security_group =>
                              {:inventory_collection_name => :security_groups,
                               :reference                 => {:source_ref => "security_group_0"},
                               :ref                       => :manager_ref},
           :tag            =>
                              {:inventory_collection_name => :tags,
                               :reference                 => {:name => "dimension", :value => "void_42", :namespace => "amazon"},
                               :ref                       => :manager_ref}},
          {:security_group =>
                              {:inventory_collection_name => :security_groups,
                               :reference                 => {:source_ref => "security_group_0"},
                               :ref                       => :manager_ref},
           :tag            =>
                              {:inventory_collection_name => :tags,
                               :reference                 => {:name => "is_secure", :value => "true", :namespace => "amazon"},
                               :ref                       => :manager_ref}},
          {:security_group =>
                              {:inventory_collection_name => :security_groups,
                               :reference                 => {:source_ref => "security_group_0"},
                               :ref                       => :manager_ref},
           :tag            =>
                              {:inventory_collection_name => :tags,
                               :reference                 => {:name => "dimension", :value => "void_42", :namespace => "amazon"},
                               :ref                       => :manager_ref}}
        ]
      )
    )
  end

  it "collects and parses volumes" do
    parser = collect_and_parse(:volumes)

    expect(format_hash(:volumes, parser)).to(
      match_array(
        [{:source_ref          => "volume_id_0",
          :name                => "volume_0",
          :state               => "in-use",
          :size                => 1_073_741_824,
          :source_created_at   => Time.parse("2019-02-20 09:53:48 UTC").utc,
          :volume_type         =>
                                  {:inventory_collection_name => :volume_types,
                                   :reference                 => {:source_ref => "standard"},
                                   :ref                       => :manager_ref},
          :source_region       =>
                                  {:inventory_collection_name => :source_regions,
                                   :reference                 => {:source_ref => "us-east-1"},
                                   :ref                       => :manager_ref},
          :subscription        => nil,
          :orchestration_stack => nil},
         {:source_ref          => "volume_id_0",
          :name                => "volume_0",
          :state               => "in-use",
          :size                => 1_073_741_824,
          :source_created_at   => Time.parse("2019-02-20 09:53:48 UTC").utc,
          :volume_type         =>
                                  {:inventory_collection_name => :volume_types,
                                   :reference                 => {:source_ref => "standard"},
                                   :ref                       => :manager_ref},
          :source_region       =>
                                  {:inventory_collection_name => :source_regions,
                                   :reference                 => {:source_ref => "us-west-1"},
                                   :ref                       => :manager_ref},
          :subscription        => nil,
          :orchestration_stack => nil}]
      )
    )
  end

  it "collects and parses source_regions" do
    parser = collect_and_parse(:source_regions)

    expect(format_hash(:source_regions, parser)).to(
      match_array(
        [{:source_ref => "us-east-1", :name => "us-east-1", :endpoint => nil},
         {:source_ref => "us-west-1", :name => "us-west-1", :endpoint => nil}]
      )
    )
  end

  it "collects and parses service_offerings" do
    parser = collect_and_parse(:service_offerings)

    expect(format_hash(:service_offerings, parser)).to(
      match_array(
        [
          {
            :description       => nil,
            :extra             => {
              :product_view_summary => {:name => "name_0", :product_id => "prod_0"},
              :status               => "",
              :product_arn          => "arn_0",
            },
            :source_ref        => "prod_0",
            :name              => "name_0",
            :source_created_at => Time.parse("2016-08-10 14:42:09 UTC").utc,
            :source_region     => {
              :inventory_collection_name => :source_regions,
              :reference                 => {:source_ref => "us-east-1"},
              :ref                       => :manager_ref
            },
            :subscription      => nil
          },
          {
            :description       => nil,
            :extra             => {
              :product_view_summary => {:name => "name_0", :product_id => "prod_0"},
              :status               => "",
              :product_arn          => "arn_0",
            },
            :source_ref        => "prod_0",
            :name              => "name_0",
            :source_created_at => Time.parse("2016-08-10 14:42:09 UTC").utc,
            :source_region     => {
              :inventory_collection_name => :source_regions,
              :reference                 => {:source_ref => "us-west-1"},
              :ref                       => :manager_ref
            },
            :subscription      => nil,
          }
        ]
      )
    )
  end

  it "collects and parses service_instances" do
    parser = collect_and_parse(:service_instances)

    expect(format_hash(:service_instances, parser, :ignore => [:extra])).to(
      match_array(
        [
          {
            :name              => nil,
            :service_offering  =>
                                  {:inventory_collection_name => :service_offerings,
                                   :reference                 => {:source_ref => "prod_1"},
                                   :ref                       => :manager_ref},
            :service_plan      =>
                                  {:inventory_collection_name => :service_plans,
                                   :reference                 => {:source_ref => "prod_1__provisioning_artifact_1__path_1"},
                                   :ref                       => :manager_ref},
            :source_created_at => Time.parse("2016-08-10 16:42:01 +0200").utc,
            :source_ref        => "id_0",
            :source_region     =>
                                  {:inventory_collection_name => :source_regions,
                                   :reference                 => {:source_ref => "us-east-1"},
                                   :ref                       => :manager_ref},
            :subscription      => nil,
          },
          {:name              => nil,
           :service_offering  =>
                                 {:inventory_collection_name => :service_offerings,
                                  :reference                 => {:source_ref => "prod_1"},
                                  :ref                       => :manager_ref},
           :service_plan      =>
                                 {:inventory_collection_name => :service_plans,
                                  :reference                 => {:source_ref => "prod_1__provisioning_artifact_1__path_1"},
                                  :ref                       => :manager_ref},
           :source_created_at => Time.parse("2016-08-10 16:42:01 +0200").utc,
           :source_ref        => "id_0",
           :source_region     =>
                                 {:inventory_collection_name => :source_regions,
                                  :reference                 => {:source_ref => "us-west-1"},
                                  :ref                       => :manager_ref},
           :subscription      => nil}
        ]
      )
    )
  end

  it "collects and parses service_plans" do
    parser = collect_and_parse(:service_plans)

    expect(format_hash(:service_plans, parser, :ignore => [:extra])).to(
      match_array(
        [
          {
            :create_json_schema => nil,
            :description        => nil,
            :name               => "name_0 provisioning_artifact_1_name path_1_name",
            :service_offering   =>
                                   {:inventory_collection_name => :service_offerings,
                                    :reference                 => {:source_ref => "prod_0"},
                                    :ref                       => :manager_ref},
            :source_created_at  => nil,
            :source_ref         => "prod_0__provisioning_artifact_1__path_1",
            :source_region      =>
                                   {:inventory_collection_name => :source_regions,
                                    :reference                 => {:source_ref => "us-east-1"},
                                    :ref                       => :manager_ref},
            :subscription       => nil
          },
          {
            :create_json_schema => nil,
            :description        => nil,
            :name               => "name_0 provisioning_artifact_1_name path_1_name",
            :service_offering   =>
                                   {:inventory_collection_name => :service_offerings,
                                    :reference                 => {:source_ref => "prod_0"},
                                    :ref                       => :manager_ref},
            :source_created_at  => nil,
            :source_ref         => "prod_0__provisioning_artifact_1__path_1",
            :source_region      =>
                                   {:inventory_collection_name => :source_regions,
                                    :reference                 => {:source_ref => "us-west-1"},
                                    :ref                       => :manager_ref},
            :subscription       => nil
          }
        ]
      )
    )
  end

  it "collects and parses flavors" do
    parser = collect_and_parse(:flavors)

    expect(format_hash(:flavors, parser)).to(
      match_array(
        [{:source_ref => "m5d.12xlarge",
          :name       => "m5d.12xlarge",
          :disk_size  => 966_367_641_600,
          :disk_count => "2",
          :memory     => 206_158_430_208,
          :cpus       => 48,
          :extra      => {
            :attributes => {
              :dedicatedEbsThroughput => "6000 Mbps",
              :physicalProcessor      => "Intel Xeon Platinum 8175",
              :clockSpeed             => "2.5 GHz",
              :ecu                    => "173",
              :networkPerformance     => "10 Gigabit",
              :processorFeatures      => "Intel AVX, Intel AVX2, Intel AVX512, Intel Turbo"
            },
            :prices     => {
              :OnDemand => {
                "22PCVUMSTSHECWJD.JRTCKXETXF" => {
                  "sku"             => "22PCVUMSTSHECWJD",
                  "effectiveDate"   => "2018-12-01T00:00:00Z",
                  "offerTermCode"   => "JRTCKXETXF",
                  "termAttributes"  => {},
                  "priceDimensions" => {
                    "22PCVUMSTSHECWJD.JRTCKXETXF.6YS6EN2CT7" => {
                      "unit"         => "Hrs",
                      "endRange"     => "Inf",
                      "rateCode"     => "22PCVUMSTSHECWJD.JRTCKXETXF.6YS6EN2CT7",
                      "appliesTo"    => [],
                      "beginRange"   => "0",
                      "description"  => "$2.712 per On Demand Linux m5d.12xlarge Instance Hour",
                      "pricePerUnit" => {"USD" => "2.7120000000"}
                    }
                  }
                }
              }
            }
          }},
         {:source_ref => "t1.micro",
          :name       => "t1.micro",
          :disk_size  => 0,
          :disk_count => 0,
          :memory     => 2_064_805_527_552,
          :cpus       => 2,
          :extra      =>
                         {:attributes =>
                                         {:dedicatedEbsThroughput => "6000 Mbps",
                                          :physicalProcessor      => "Intel Xeon Platinum 8175",
                                          :clockSpeed             => "2.5 GHz",
                                          :ecu                    => "173",
                                          :networkPerformance     => "10 Gigabit",
                                          :processorFeatures      => "Intel AVX, Intel AVX2, Intel AVX512, Intel Turbo"},
                          :prices     => {:OnDemand => nil}}}]
      )
    )
  end

  it "collects and parses volume_types" do
    parser = collect_and_parse(:volume_types)

    expect(format_hash(:volume_types, parser)).to(
      match_array(
        [{:source_ref  => "standard",
          :name        => "standard",
          :description => "Magnetic",
          :extra       =>
                          {:storageMedia  => "HDD-backed",
                           :volumeType    => "Magnetic",
                           :maxIopsvolume => "40 - 200",
                           :maxVolumeSize => "1 TiB"}},
         {:source_ref  => "gp2",
          :name        => "gp2",
          :description => "General Purpose",
          :extra       =>
                          {:storageMedia  => "SSD-backed",
                           :volumeType    => "General Purpose",
                           :maxIopsvolume => "16000",
                           :maxVolumeSize => "16 TiB"}}]
      )
    )
  end

  def collect_and_parse(entity)
    parser  = TopologicalInventory::Amazon::Parser.new
    metrics = instance_double(TopologicalInventory::Amazon::Collector::Metrics,
                              :record_error => nil)

    collector = TopologicalInventory::Amazon::Collector.new(
      "source", "access_key_id", "secret_access_key", nil, metrics
    )
    allow(collector).to receive(:save_inventory).and_return(1)
    allow(collector).to receive(:sweep_inventory)
    allow(collector).to receive(:create_parser).and_return(parser)

    with_aws_stubbed(stub_responses) do
      regions = collector.send(:list_regions)
      accounts = collector.send(:list_accounts)

      collector.send(:process_entity, entity, regions, accounts)
    end
    parser
  end

  def format_hash(entity, parser, ignore: nil)
    hash = parser.collections[entity].data.map(&:to_hash)
    if ignore
      hash = hash.map { |x| x.except(*ignore) }
    end
    hash
  end

  def with_aws_stubbed(stub_responses_per_service)
    stub_responses_per_service.each do |service, stub_responses|
      raise "Aws.config[#{service}][:stub_responses] already set" if Aws.config.fetch(service, {})[:stub_responses]

      Aws.config[service] ||= {}
      Aws.config[service][:stub_responses] = stub_responses
    end
    yield
  ensure
    stub_responses_per_service.keys.each do |service|
      Aws.config[service].delete(:stub_responses)
    end
  end

  def stub_responses
    {
      :ec2            => {
        :describe_regions            => mocked_regions,
        :describe_availability_zones => mocked_availability_zones,
        :describe_instances          => mocked_instances,
        :describe_key_pairs          => mocked_key_pairs,
        :describe_images             => mocked_images,
        :describe_vpcs               => mocked_vpcs,
        :describe_subnets            => mocked_subnets,
        :describe_security_groups    => mocked_security_groups,
        :describe_network_interfaces => mocked_network_ports,
        :describe_addresses          => mocked_floating_ips,
        :describe_volumes            => mocked_cloud_volumes,
        :describe_snapshots          => mocked_cloud_volume_snapshots,
      },
      :cloudformation => {
        :describe_stacks      => mocked_stacks,
        :list_stack_resources => mocked_stack_resources
      },
      :servicecatalog => {
        :search_products_as_admin  => mocked_products,
        :scan_provisioned_products => mocked_provisioned_products,
        :describe_record           => mocked_describe_record,
        :describe_product          => mocked_describe_product,
        :list_launch_paths         => mocked_list_launch_paths,
      },
      :pricing        => {
        :get_products => mocked_pricing_products,
      }
    }
  end
end
