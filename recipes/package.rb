%w(duplicity python-boto).each do |pkg|
  package pkg do
    action :install
  end
end