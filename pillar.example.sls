powerdns:
  lookup:
    recursor:
      config:
        main:
          settings:
            entropy-source: /dev/random
            local-address: '127.0.0.1, ::1'
            local-port: 53
            quiet: 'yes'
            setgid: pdns
            setuid: pdns
            version-string: ''
            forward-zones-recurse: domain1.de=10.1.0.23, domain2.de=10.1.0.23, 0.1.10.in-addr.arpa=10.1.0.23

