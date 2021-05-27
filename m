Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8062FB4
	for <mptcp@lists.linux.dev>; Thu, 27 May 2021 09:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1622107802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OvFWgWJsd8LS/pauBU6s7GDyjE/T7FzECy+zAPT8NNI=;
	b=CoGtTuVDXMvogyCBUO4aCDeVbT1lChcF4fE6EPSjZXRjm07+faC/DXCbm58iDaIzVx8Snh
	1veHIOCkzjPX5olKZqVtjJy36E++gPz5TOFuVbzyT2swSudDpcrRaEE8ah7Ojls9Q/Lluc
	urxs4qvoM/YXahFWHJYOKuperI5HQys=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-X5E0KTkmPwaqHox4vy7ToA-1; Thu, 27 May 2021 05:30:00 -0400
X-MC-Unique: X5E0KTkmPwaqHox4vy7ToA-1
Received: by mail-wm1-f71.google.com with SMTP id x20-20020a1c7c140000b029018f49a7efb7so1284216wmc.1
        for <mptcp@lists.linux.dev>; Thu, 27 May 2021 02:30:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=OvFWgWJsd8LS/pauBU6s7GDyjE/T7FzECy+zAPT8NNI=;
        b=NGSePAzhDAjRHJMQGrw5aC4XkHbp/kdwIGqsJIs8EnJ1jpqSDdBx3wXdbFPr+1JpKd
         E+Ltj69KF/fwzi1E7+eTOGCTI1pKBz/r3flmiSjSpX+eTlMNT3qvRC14VuOqQu1JgdxV
         Oh9kV1cSQPOB9kEKU3RVWYAWhTsenOOY1D1Mk4w1zzqFpm5V8nGhlV9jkbm+BLN64vuN
         wlIvdkh2BkRaWz8zfaNjnukjlpuc+jlKTxQlQmffjlHggnlrutPWlwfxYfvUBmU++RU0
         pk+84uoVr1BKl2k3IlV0WnKCcr5+17eV/8AyXdnoAHOUUjA3CCCteGq+0cs23PW3Ut3L
         KoVA==
X-Gm-Message-State: AOAM533QPaChcZupxJjgbHUeEuOfUEu46ylBEOAmEmnoyLsX+0fgy8eF
	Z8K7/QNlUPC71z+csawubbZVT0TIsH2+FRn6g0TD0KU34YJMY3dg9XpBKkYbG8JBporJAoedgtb
	2i4SSRefEd9k8BJc=
X-Received: by 2002:a05:600c:3043:: with SMTP id n3mr2481735wmh.98.1622107799179;
        Thu, 27 May 2021 02:29:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPfBXNH2Q6DtfR/MNMThIScrIhFC8LzH9CO2La+0phkbn8NJfU3x9yS2uHhdCBBZnOvBRE6g==
X-Received: by 2002:a05:600c:3043:: with SMTP id n3mr2481723wmh.98.1622107798997;
        Thu, 27 May 2021 02:29:58 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-110-123.dyn.eolo.it. [146.241.110.123])
        by smtp.gmail.com with ESMTPSA id f12sm2293432wre.88.2021.05.27.02.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 02:29:58 -0700 (PDT)
Message-ID: <3df56d50e64671f9220715c2572fe93d4a4b7242.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] tcp: ensure that backlog coalescing don't
 break MPTCP DSS
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, max@internet.ru
Date: Thu, 27 May 2021 11:29:57 +0200
In-Reply-To: <8268318-9d67-4752-46c5-5da27e507ebb@linux.intel.com>
References: <925dcab4e637ab2ad2d947baa937a62146040802.1622044966.git.pabeni@redhat.com>
	 <8268318-9d67-4752-46c5-5da27e507ebb@linux.intel.com>
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

On Wed, 2021-05-26 at 16:27 -0700, Mat Martineau wrote:
> On Wed, 26 May 2021, Paolo Abeni wrote:
> 
> > Currently the backlog coalescing does check for MPTCP validation:
> > a relevant DSS could be lost leading to MPTCP stream corruption.
> > 
> > The above is quite infrequent since the MPTCP subflows are not
> > exposed to user-space but the MPTCP still acquires the ssk socket
> > lock on some events.
> > 
> > Fix the issue adding the missing test.
> > 
> > Fixes: 85712484110d ("tcp: coalesce/collapse must respect MPTCP extensions")
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > this can possibly fix issues/196, but it's very hard to demonstrate,
> > even with pktdrill
> > ---
> > net/ipv4/tcp_ipv4.c | 1 +
> > 1 file changed, 1 insertion(+)
> > 
> > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > index 4f5b68a90be9..6b033593d069 100644
> > --- a/net/ipv4/tcp_ipv4.c
> > +++ b/net/ipv4/tcp_ipv4.c
> > @@ -1822,6 +1822,7 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb)
> > 
> > 	if (TCP_SKB_CB(tail)->end_seq != TCP_SKB_CB(skb)->seq ||
> > 	    TCP_SKB_CB(tail)->ip_dsfield != TCP_SKB_CB(skb)->ip_dsfield ||
> > +	    !mptcp_skb_can_collapse(tail, skb) ||
> > 	    ((TCP_SKB_CB(tail)->tcp_flags |
> > 	      TCP_SKB_CB(skb)->tcp_flags) & (TCPHDR_SYN | TCPHDR_RST | TCPHDR_URG)) ||
> > 	    !((TCP_SKB_CB(tail)->tcp_flags &
> > -- 
> > 2.26.3
> 
> Yeah, definitely could lose MPTCP header information here.
> 
> Since mptcp_incoming_options() hasn't been called yet, skbs in the backlog 
> queue will never have the MPTCP skb extensions that 
> mptcp_skb_can_collapse() relies on.

whoops, I missed that point!!! 

> Is it worth it to add a function that will do a subset of the 
> mptcp_incoming_options() work to populate the skb extension for mptcp 
> subflow socks? (and modify mptcp_incoming_options() to detect existing 
> mpexts?)

I was wondering about memcmp-aring the TCP options carried by the two
skbs, then I noted that the existing code already does:

	 thtail->doff != th->doff ||
	 memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)))

Skbs with different mapping can't really be merged, and the suspected
issue is really not possible.

I think this patch can be dropped,

thanks!

Paolo

