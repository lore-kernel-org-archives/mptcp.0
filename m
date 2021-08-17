Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AE22FB6
	for <mptcp@lists.linux.dev>; Tue, 17 Aug 2021 14:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1629211180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fMmaor5I8UxPx0vGzJZyUnZJ0wa09eF+lL18QGY+2kM=;
	b=K76qSqP/6AKVaaxTGD4T13lp9tHgQanD48Tw2t7jZBJz8PIZS00b1ACOo4S9kl99Z6to48
	KoJjWqFWyDoyGW6vMOM0urB2F+cd40km7xTk1bNvOaAWHYA00xKSN4XT1Ws3JB69c/ArwR
	pddO4r5p2mEnpsaHzgCB8e5jRQDCfaQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-4CVtepgBNK-11DIDMm12TQ-1; Tue, 17 Aug 2021 10:39:39 -0400
X-MC-Unique: 4CVtepgBNK-11DIDMm12TQ-1
Received: by mail-ed1-f69.google.com with SMTP id e18-20020a0564020892b02903be9702d63eso9504609edy.17
        for <mptcp@lists.linux.dev>; Tue, 17 Aug 2021 07:39:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=fMmaor5I8UxPx0vGzJZyUnZJ0wa09eF+lL18QGY+2kM=;
        b=nMUzJSCf9a+EJuQ8SMGpFtMlGZ0NxkHShyxLcYK+yHsrB7/mzZHjsziM1/Yb2VI4Re
         AG3wT/sEH4Kvm3usHCWYFicagoE5Sn9DcdMAht5cJiFp8fEiifsoJVRgowB++GSVFQeX
         yvUNrn6FO/GjIU1TamQW64t4AgR9MflMh/FAlj3L65EM3rPO2rg4V2/l8D9N9q62ZaWU
         KFrehgTJu2ZNIcq0MD5pvpTj+uBRm93rhn2L3nQiEIsjZ389ElcipI7FZNzqLx5jk7wa
         HY6jlmRKNVrszR+2JnCFw8CjvXQBDyggyU3niwdwDdltNP0v0+Aw2Un62UhRSXfQRwzt
         fD/Q==
X-Gm-Message-State: AOAM53101Gi24FArryMf1/6+dsAy89odqCRPj9JUoI4jUoF3Fs7Znjum
	m+waG92T9eGjdl++sTt1+VC3IRtacYpwTaBJlLVq9JvYtMzJuUQkDOrdKQsG5BbhCKbXuMbg1CZ
	m2tzEI9Hoy7c0UPM=
X-Received: by 2002:a17:906:d7af:: with SMTP id pk15mr4402649ejb.51.1629211177754;
        Tue, 17 Aug 2021 07:39:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTm8bOlDmRQObeWBPoWWY+8kXSSIkiTLqApk8yKpTp/DlQKZT9CquCoDu7Wuu2YBTGjTOMFA==
X-Received: by 2002:a17:906:d7af:: with SMTP id pk15mr4402635ejb.51.1629211177582;
        Tue, 17 Aug 2021 07:39:37 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-224-77.dyn.eolo.it. [146.241.224.77])
        by smtp.gmail.com with ESMTPSA id cn16sm1171860edb.9.2021.08.17.07.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 07:39:37 -0700 (PDT)
Message-ID: <09b699930245cd1d4eb1fa431c5bbf485b527644.camel@redhat.com>
Subject: Re: [PATCH mptcp-net v2 0/2] mptcp: ADD_ADDR and fully_estab
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, Mat Martineau
	 <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Tue, 17 Aug 2021 16:39:36 +0200
In-Reply-To: <98e667a4-3b48-cb22-cd48-56e319daa514@tessares.net>
References: <20210816172548.2339984-1-matthieu.baerts@tessares.net>
	 <4c6a722-d7c6-64d8-ddf-cb8d869c342c@linux.intel.com>
	 <98e667a4-3b48-cb22-cd48-56e319daa514@tessares.net>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
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

On Tue, 2021-08-17 at 08:48 +0200, Matthieu Baerts wrote:
> Hi Mat,
> 
> On 17/08/2021 01:53, Mat Martineau wrote:
> > On Mon, 16 Aug 2021, Matthieu Baerts wrote:
> > 
> > > This is the v2 of "mptcp: full fully established support after ADD_ADDR"
> > > but now we also make sure the HMAC bit is present (patch 1/2, as
> > > suggested by Mat, thanks!).
> > > 
> > > Matthieu Baerts (2):
> > >  mptcp: check for HMAC presence in ADD_ADDR
> > >  mptcp: full fully established support after ADD_ADDR
> > > 
> > > net/mptcp/options.c | 10 +++-------
> > > 1 file changed, 3 insertions(+), 7 deletions(-)
> > > 
> > > -- 
> > > 2.32.0
> > 
> > Thanks for the v2.
> 
> Thank you for the review!
> 
> > I'd prefer that these are squashed, I don't think it's important to
> > change the single line in patch 1 that just gets deleted in patch 2. It
> > wasn't my intent to ask for two patches in my previous review, if that
> > was a factor.
> 
> Sure I can squash them. I initially had one single patch but I decided
> to split it in two to avoid adding something like "oh and BTW, an
> additional check has been added" in the commit message.
> But fine to do that.

+1 on squashing - if not already done ;)

Cheers,

Paolo

