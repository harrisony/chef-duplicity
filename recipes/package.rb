node['duplicity']['packages'].each do |pkg|
  package pkg do
    action :install
  end
end