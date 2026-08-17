{ ... }: 
  let 
    email = "sophr.temin@ro.ru";
    domain = "sophron.ru";
  in {
    security.acme = {
      acceptTerms = true;

      defaults = {
        email = email;
        group = "nginx";
	#server = "https://acme-staging-v02.api.letsencrypt.org/directory";
      };
    
      certs."${domain}" = {
        domain = domain;
        extraDomainNames = [ "cloud.${domain}" "stories.${domain}" ];
	webroot = "/var/lib/acme/acme-challenge";
      };
    };
}
