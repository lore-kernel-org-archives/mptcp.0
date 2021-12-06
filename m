Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC58768
	for <mptcp@lists.linux.dev>; Mon,  6 Dec 2021 10:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1638785885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9J/zZYILVQU9TqX66GmG5HsmIQ5sIjt3XIeUYronD88=;
	b=Sma5SM9E/SNM6i+CZHn6QxQyt06RqE8iJvEOWhNGUjI2ODivHc6I+w4C70ucN9MqRsUubW
	XiQGLiwCHPKh9/WlES0MvlpP/PNu790LbwxmEuW36zbXuOXD17CCYYilJ+ZMkCGl/NFzcK
	ULdQHiLH4A9RDZglQ+zj4yl64TcvwcA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-394-mMgrTzOjMUeV0jN7bUE0VA-1; Mon, 06 Dec 2021 05:18:04 -0500
X-MC-Unique: mMgrTzOjMUeV0jN7bUE0VA-1
Received: by mail-wm1-f71.google.com with SMTP id m14-20020a05600c3b0e00b0033308dcc933so4290310wms.7
        for <mptcp@lists.linux.dev>; Mon, 06 Dec 2021 02:18:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=9J/zZYILVQU9TqX66GmG5HsmIQ5sIjt3XIeUYronD88=;
        b=ZlWi0ZDjlj2U4qaJrsWHflxnntTMGURNw9Pu0Vy2vymEP9JNt2DB3Q/agahV4QCig8
         nuCH1MyRw8vgqqYjvY7cQEYe206KHHZFgjS9ZWhspPQttnhs2AGsFGN3iiEHTKHdDCHn
         rHsCFnm3ezokGgI3IIN8hH/jeilqt+deAE8aZThArLmuLcyxyj9lwYaVuf/PWaX8pgjr
         ziiFteA1zZibn5mzZTk6k6RbfdMwyC67WSLl5OWmHbycfJJnv/rNgB+XFzcvhTRHUkt2
         CCy3kvX/zTss7fEP0GuhC2ortUG7MD5h2XgQGbaGbr6UGQxAZisk8fxyIjbhsVzElPlb
         lgxg==
X-Gm-Message-State: AOAM533JAMg2NleFYV7r+Nlo+cCsAON0ESsICDL59z8G436Cag0zyeob
	GWmXq+uCutGkwVQ+8n4x3MpVAQ6MGCmBFMmpkSRjJZaWyJlrZrRuRlGZ9+a7y+mQzg/RNQzU73G
	HkIJaDVq0Iz2rbBs=
X-Received: by 2002:a1c:9d48:: with SMTP id g69mr38859912wme.188.1638785883246;
        Mon, 06 Dec 2021 02:18:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwtldQHurdMRNSqGdg3ovfD7HlQQsk8BPdBaHvkOsIln8aSqkCN907/dL4fKRdQZcGK0JMSXw==
X-Received: by 2002:a1c:9d48:: with SMTP id g69mr38859893wme.188.1638785883064;
        Mon, 06 Dec 2021 02:18:03 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-252-1.dyn.eolo.it. [146.241.252.1])
        by smtp.gmail.com with ESMTPSA id q123sm12603565wma.30.2021.12.06.02.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 02:18:02 -0800 (PST)
Message-ID: <b17fea76ad24e5a1cc6b793427f827ba9ea3c887.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v4 3/5] mptcp: keep track of local endpoint
 still available for each msk
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Mon, 06 Dec 2021 11:18:02 +0100
In-Reply-To: <e5ea098-af36-e35-1813-f97d7a187ffa@linux.intel.com>
References: <cover.1638544716.git.pabeni@redhat.com>
	 <20e1d11df9396b33ab49b07204bd8b7db2e21a01.1638544716.git.pabeni@redhat.com>
	 <e5ea098-af36-e35-1813-f97d7a187ffa@linux.intel.com>
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2021-12-03 at 17:05 -0800, Mat Martineau wrote:
> On Fri, 3 Dec 2021, Paolo Abeni wrote:
> 
> > Include into the path manager status a bitmap tracking the list
> > of local endpoints still available - not yet used - for the
> > relavant mptcp socket.
> > Keep such map updated at endpoint creation/deleteion time, so
> > that we can easily skip already used endpoint at local address
> > selection time.
> > This allows for fair local endpoints usage in case of subflow
> > failure.
> > 
> > As a side effect, this patch also enforces that each endpoint
> > is used at most once for each mptcp connection.
> 
> This seems like a significant change, possibly with unexpected 
> consequences (but maybe I've misunderstood the new constraint?). 
> Apparently the topoligies in our self tests happen to work fine!

Uhmmm... probably less then it may looks like. We already respected the
above constraint in almost every scenarios. AFAICS, the only exception
prior to this patch was following scenario:

1) subflow is established endpoint A

2) the peer closes the additional subflow

2) a new local endpoint B is created

3) the PM will create the 2nd subflow using again endpoint A. 

which is arguibly unexpected, as reported by issues/242. 

> If you have peer A with one interface and peer B with two, it seems like 
> this should be allowed:
> 
> Peer A connects to Peer B endpoint 0
> Peer B announces endpoint 1
> Peer A sends an MP_JOIN to Peer B interface 1
> 
> From the description above, it sounds like peer A would not be able to 
> create that second subflow.

Well, AFAICS the peer A will actually create the subflow, if the limits
allow that, both with or without this patch.
Specifically:

1) no endpoint configured, add_addr_accepted >=1, subflows >=1 on peer
A -> the subflow to peer be interface 1 will be created (with or
without this patch) because we don't have any other additional
constraint beyond the limits. 

2) endpoint configured on peer A matching the MPC subflow source
address -> again the subflow towards peer B endpoint 1 will be created,
because that will be the first time the PM will use the peer A
endpoint.

>  I think there's a quirk where the subflow 0 
> local interface gets to be used twice since bit 0 is not cleared 
> until the second subflow is established.

Uhmm? the 'endpoint available bit' is cleared before attempting to
create the subflow, and is set (making the endpoint available again)
after mptcp_close_ssk() is invoked on the relevant subflow.

> My suggestion is that the max number of subflows should be determined by 
> the existing limit values, not the number of local interfaces.

Sorry, I do not follow ?!? the max number of subflows are determinted
by the limits, the interfaces are never taken in account (with or
without this patch).

> Could the change in behavior (fair use of local endpoints) also have 
> unexpected effects if it causes backup endpoints to be used?

I can't think of any critical scenario, but that is probably lack of
fantasy on my side...

/P

