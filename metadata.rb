name              "duplicity"
maintainer        "Harrison Conlin"
maintainer_email  "me@harrisony.com"
license           "Apache 2.0"
description       "Installs and configures duplicity."
version           "0.2.0"
recipe            "duplicity", "Installs and configures duplicity"

%w{ubuntu debian}.each do |os|
  supports os
end
