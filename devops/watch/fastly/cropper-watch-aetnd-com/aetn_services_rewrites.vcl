sub aetn_services_rewrites {

/* The below block of code is to redirect URLs such as cropper.watch.aetnd.com/S3bucket-fastlyURL/blah/blah.svg to https://S3Bucket-FastlyURL/blah/blah.svg as cropper does not process .svg files. Note the S3 bucket fastly URLs could be something like cdn.watch.aetnd.com or cdn.aenetworks.com etc. For further info lookup the Jira ticket DSOEM-380 */

  if (req.url ~ "\.svg") {
    if (req.url ~ "aetnd.com") {
      set req.url = regsub(req.url, "\/", "");
      set req.http.X-Redirect = "https://" req.url;
      error 703 req.http.X-Redirect;
    }
  }
  elsif (req.http.AETN-env != "DEV" && req.http.Referer ~ "https\:\/\/dev\.*"){
    set req.http.host = "dev-cropper.watch.aetnd.com";
    set req.http.X-Redirect = "https://" req.http.host req.url;
    error 703 req.http.X-Redirect;
  }
  elsif (req.http.AETN-env != "QA" && req.http.Referer ~ "https\:\/\/qa\.*"){
    set req.http.host = "qa-cropper.watch.aetnd.com";
    set req.http.X-Redirect = "https://" req.http.host req.url;
    error 703 req.http.X-Redirect;
  }

}