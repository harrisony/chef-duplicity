class Chef::Provider::Duplicity
  def run_duplicity(command, env)
    $command = command
    $env = env
   return 0
  end 
end

define :duplicity_cron do
  include_recipe "duplicity"
  include_recipe "cron"
  ruby_block "duplicity" do
    block do
      d = Chef::Resource::Duplicity.new("duplicity_#{params[:source]}", run_context)
      d.source params[:source]
      d.destination params[:destination]
      d.aws_access_key params[:aws_access_key]
      d.aws_secret_access_key params[:aws_secret_access_key]
      d.run_action :backup

      c = Chef::Resource:Cron.new("duplicity_#{params[:name]}", run_context)
      c.minute params[:minute]
      c.hour params[:hour]
      c.user params[:user]
      c.mailto params[:mailto]
      c.path params[:path]
      c.home params[:home]
      c.shell params[:shell]
      envvars = $env.collect {|e| "#{e[0]}=#{e[1]}"}
      envvars << "PASSPHRASE=#{params[:passphrase]}" if params.has_key? params[:passphrase]
      c.command .join(' ') + " " + $command
      c.run_action :create
    end
  end
end