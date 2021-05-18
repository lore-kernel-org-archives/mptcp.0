Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B0529CA
	for <mptcp@lists.linux.dev>; Tue, 18 May 2021 14:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1621347444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8cIyUC3A2hseK+z1kTGsfEkrOtqvXRQRXhIMAfCtd9w=;
	b=Vr6PDM70YxtzQlSbgPLkQSfIHi5jiXULKv9uT+dZo1ExNWJQTKPMYMDnyf+cTVWMIBRBaW
	7qUc568+q85mvCSHeJUuoGWMngOg2+kchi8SeXYXAaM9a+dEOxynr7kf7/BzwW7kM86oD0
	+D/1UyNGs9gJLKjMSSAJyaucMtJPUIo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-TxA3LlW2MN2K008E4KEn9w-1; Tue, 18 May 2021 10:17:19 -0400
X-MC-Unique: TxA3LlW2MN2K008E4KEn9w-1
Received: by mail-wr1-f70.google.com with SMTP id a9-20020adfc4490000b0290112095ca785so433285wrg.14
        for <mptcp@lists.linux.dev>; Tue, 18 May 2021 07:17:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=8cIyUC3A2hseK+z1kTGsfEkrOtqvXRQRXhIMAfCtd9w=;
        b=eMz9kRRseFRQNmKHIo2Ol/xN0Eu3wqWfefPfsVp9NktO1v9XrPMbVtTkEwNh85lRr4
         HIEVxpk9YgPyNhHfeitgUuH09Wd8JIFlTE/v/3QdOSfNDhj3H+AsFxhfqSRSnIxCGGOm
         CM/pNsU6ASPDZyiJKSc1rYli7LDEjbstGJRzFOwMqNxy7ZZWwRJzd/4xL0TM2twtO9nN
         sPY+kocbTEZSpixLKLYkPLtHVbDXHCI2ZIhRYsM1xWCcibP8t2+rzaaJRojYbd4xIUtY
         V20TpiXQksmrLxeyY101vB1JelWcFvI70/O/MMTnUaPH7GQ/biyUa7/GD/vU4JC7q0jL
         rYRA==
X-Gm-Message-State: AOAM532LtEBYzbXHu6Eg5Nkn5MzYSym2W60L5RsfC3teZYIOI3rCyTn2
	ZUjBUvBT5Mgmia3mqhR1Bq2ikARrKhcNMWx50z0xJFRiB2zbxIX/+TCgmrFQzlrNVN4lpqkSKLT
	X7THbTp4mRSH353k=
X-Received: by 2002:a5d:6484:: with SMTP id o4mr7167649wri.8.1621347437686;
        Tue, 18 May 2021 07:17:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcTfjidRlXzWZ7qv9wFxD/SQl/D66HblPZCoBUWm2lVtPo+aaY8bsBu7clz5dbqot2Oz44lA==
X-Received: by 2002:a5d:6484:: with SMTP id o4mr7167622wri.8.1621347437427;
        Tue, 18 May 2021 07:17:17 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-245-104.dyn.eolo.it. [146.241.245.104])
        by smtp.gmail.com with ESMTPSA id u14sm1871174wmc.41.2021.05.18.07.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 07:17:17 -0700 (PDT)
Message-ID: <d816c5c2b4bcb0d69effdb3b8fc4fd09fa2a9003.camel@redhat.com>
Subject: Re: [PATCH v2 mptcp-net 2/2] mptcp: do not reset MP_CAPABLE subflow
 on mapping errors
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Tue, 18 May 2021 16:17:16 +0200
In-Reply-To: <2651afa0-d371-8730-a685-def56669d6e@linux.intel.com>
References: <18ddcf2f53d732eb9b41a485ce7da23329aaa81e.1621270518.git.pabeni@redhat.com>
	 <99f56765d4939e6f21c3950ed2ee3b54369e6d5b.1621270518.git.pabeni@redhat.com>
	 <2651afa0-d371-8730-a685-def56669d6e@linux.intel.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
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

On Mon, 2021-05-17 at 17:16 -0700, Mat Martineau wrote:
> On Mon, 17 May 2021, Paolo Abeni wrote:
> 
> > When some mapping related errors occours we close the main
> > MPC subflow with a RST. We should instead fallback gracefully
> > to TCP, and do the reset only for MPJ subflows.
> > 
> > Fixes: d22f4988ffec ("mptcp: process MP_CAPABLE data option")
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/192
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > net/mptcp/subflow.c | 39 +++++++++++++++++++--------------------
> > 1 file changed, 19 insertions(+), 20 deletions(-)
> > 
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index 278986585088..9befe9fe7bca 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -1110,10 +1110,9 @@ static bool subflow_check_data_avail(struct sock *ssk)
> > 
> > 		status = get_mapping_status(ssk, msk);
> > 		trace_subflow_check_data_avail(status, skb_peek(&ssk->sk_receive_queue));
> > -		if (unlikely(status == MAPPING_INVALID)) {
> > -			ssk->sk_err = EBADMSG;
> > -			goto fatal;
> > -		}
> > +		if (unlikely(status == MAPPING_INVALID))
> > +			goto fallback;
> > +
> 
> There are a bunch of other ways to get MAPPING_INVALID during the life of 
> a connection, including when there are multiple subflows active and 
> fallback is not a valid option. Can the new fallback condition be more 
> targeted to this "out of order / packet loss at connection time" issue so 
> truly fatal MAPPING_INVALID cases still reset the connection?

What we should do if we get a MAPPING_INVALID and we have a single
(MPC) subflow? I could not find any specific reference in the RFC. I
think it's roughly the same as 'no mapping' at all: if we can fallback
we do fallback, otherwise we reset.

Note that with this patch, under the 'fallback' label, checks if a
reset is needed or not. The current patch does a reset only if the
subflow is an MP_JOIN one, but that condition could be additionally
extended to 'msk has multiple subflows' - even if the latter looks like
a net-next patch.

WDYT?

Thanks!

Paolo

