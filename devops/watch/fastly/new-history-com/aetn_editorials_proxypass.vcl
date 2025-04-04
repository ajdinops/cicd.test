sub aetn_editorials_proxypass {
  if (req.url.path ~ "^/the-obama-years($|\/$)" ){
     set req.url = "/the-obama-years/index.html";
     error 701 req.url;
  }

  elsif (req.url.path ~ "^/the-promised-land($|\/$)" ){
     set req.url = "/the-promised-land/index.html";
     error 701 req.url;
  }

  elsif (req.url.path ~ "^/george-washington-timeline-life-events($|\/$)" ){
     set req.url = "/george-washington-timeline-life-events/index.html";
     error 701 req.url;
  }

  elsif (req.url.path ~ "^/d-day-operation-overlord-timeline-map($|\/$)" ){
     set req.url = "/d-day-operation-overlord-timeline-map/index.html";
     error 701 req.url;
  }

  elsif (req.url.path ~ "^/area-51-quiz-real-history($|\/$)" ){
     set req.url = "/area-51-quiz-real-history/index.html";
     error 701 req.url;
  }

  elsif (req.url.path ~ "^/george-washington-battle-map-american-revolution($|\/$)" ){
     set req.url = "/george-washington-battle-map-american-revolution/index.html";
     error 701 req.url;
  }
  else {

    set req.http.host = "prod-editorials-watch-aetnd-com.s3.amazonaws.com";
    set req.http.AETN-Bucket = "/prod-editorials-watch-aetnd-com";

    if (req.http.AETN-env ~ "DEV") {
      set req.http.host = "dev-editorials-watch-aetnd-com.s3.amazonaws.com";
      set req.http.AETN-Bucket = "/dev-editorials-watch-aetnd-com";
    }

    elsif (req.http.AETN-env ~ "QA") {
      set req.http.host = "qa-editorials-watch-aetnd-com.s3.amazonaws.com";
      set req.http.AETN-Bucket = "/qa-editorials-watch-aetnd-com";
    }

  }

  set req.backend = editorials_watch_aetnd_com;
  call aetn_sign_s3;
}
