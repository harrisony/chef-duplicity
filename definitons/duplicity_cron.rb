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
  
  opts = params

  duplicity opts[:source] do
    source opts[:source]
    destination opts[:destination]
    aws_access_key opts[:aws_access_key]
    aws_secret_access_key opts[:aws_secret_access_key]
  end

  cron_d "duplicity_#{opts[:source]}" do
    minute opts[:minute]
    hour opts[:hour]
    command $env.collect {|e| "#{e[0]}=#{e[1]}"}.join(' ') + " " + $command
    user opts[:user]
    mailto opts[:mailto]
    path opts[:path]
    home opts[:home]
    shell opts[:shell]
  end
  
end