Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB823FC1
	for <mptcp@lists.linux.dev>; Mon,  6 Sep 2021 13:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1630934094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SR1fg+bjVtWbKAKX0dlZKOGHUEIpe4GJDEq4mzdq5ro=;
	b=ILYD10DSer0ighp5gmlZh4Q3GXuOpvTI1+3jmnDpprWCjZ/eWUTyrHK2y9rKEWVLvd0K9j
	vWRByc4FuAYUGfi1ofMpfgjEy9atj2qIslZm2cqLhGlTQ61eh+8eQvYr0pMuZaQKB9/2fi
	fsrq4LLUX+71SdP7NASTYuXTpx+54lk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-WrKOtDMOOzGY_SI28nUbSw-1; Mon, 06 Sep 2021 09:14:53 -0400
X-MC-Unique: WrKOtDMOOzGY_SI28nUbSw-1
Received: by mail-wm1-f69.google.com with SMTP id b126-20020a1c8084000000b002f152a868a2so2169999wmd.1
        for <mptcp@lists.linux.dev>; Mon, 06 Sep 2021 06:14:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=SR1fg+bjVtWbKAKX0dlZKOGHUEIpe4GJDEq4mzdq5ro=;
        b=BV+89LYlTJsbZ92g20m72D3oWFYXx9Brw4tOhw+rPoIJq3SiHZmHn+p5A0qLbnJdA5
         Xxl1Dygf03vF/Tf0ukNuM47v/O+RhWnjOeBDZyQj5atVMeNiT1wIdxHrYb+nh0VwLF+v
         JVN7XFRW+8ljsQ4l8rpI4Vahj3kYymzFLmuLZc4eSJ1AdcxdgFMEbP+Y9n6zKoPNBcNd
         LbZ+19qIMHKrBoD90GP9DohscsVl5THpFny3tRG+VUYW2pNdrOzR1LMM+/pYI5HlAosd
         IhKwYrk++4wHCcxp/Np1UQ2N0xxkXIA18Ny1YJLGne+07hhCw4CMIvwnHzxta5OoQp9o
         rd6g==
X-Gm-Message-State: AOAM530wf/NBDpM3v5h4XidgX2NW5MiOt3qyJlfJzPrmX34ZCJ3V4Qxo
	L6JNlQV4tkmNx2teHh5UrnkOdkmpPKZSXv6unr4CRDySXmSszrGi/ZQrjrOw0UyECiyEEpIAwub
	hJEpG8fLD/viFXrw=
X-Received: by 2002:adf:e5c2:: with SMTP id a2mr2955997wrn.251.1630934092074;
        Mon, 06 Sep 2021 06:14:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFnjTzLuduJmJSptmbesA4lLL5dyiT7G8IZ5n8YcfwPx+XnSQ8C5h/bHyPR8AbRXoLw2C0MQ==
X-Received: by 2002:adf:e5c2:: with SMTP id a2mr2955972wrn.251.1630934091837;
        Mon, 06 Sep 2021 06:14:51 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-233-185.dyn.eolo.it. [146.241.233.185])
        by smtp.gmail.com with ESMTPSA id w9sm7931283wrs.7.2021.09.06.06.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 06:14:51 -0700 (PDT)
Message-ID: <379641c2d20832800fb3fde1e516f28d2b153249.camel@redhat.com>
Subject: Re: [mptcp-next 2/2] mptcp: re-set push-pending bit on retransmit
 failure
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>
Cc: mptcp@lists.linux.dev, Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 06 Sep 2021 15:14:50 +0200
In-Reply-To: <20210906113547.GE23554@breakpoint.cc>
References: <20210906060614.25217-1-fw@strlen.de>
	 <20210906060614.25217-3-fw@strlen.de>
	 <aaefcedbe475b6bf060bbb4d6266233d57d59225.camel@redhat.com>
	 <20210906075531.GD23554@breakpoint.cc>
	 <c0fc73caa4f52bdfc639ea76b552b1bc255eab9b.camel@redhat.com>
	 <20210906113547.GE23554@breakpoint.cc>
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

On Mon, 2021-09-06 at 13:35 +0200, Florian Westphal wrote:
> Paolo Abeni <pabeni@redhat.com> wrote:
> > On Mon, 2021-09-06 at 09:55 +0200, Florian Westphal wrote:
> > > Because I don't think it makes sense to re-try ASAP if we could
> > > not find a ssk, and instead defer until next firing of rtx timer.
> > 
> > Ok
> > > > Do we need something similar for __mptcp_subflow_push_pending(), too?
> > > 
> > > I don't think so, its thats not invoked from the mptcp-release cb; 
> > 
> > yup, right. To be clear, with "something similar" I also referred to
> > ensuring the rtx timer is armed.
> 
> __mptcp_subflow_push_pending() is only called when we already have
> pending xmit, i.e. the timer is already running and with the change in
> this patch the timer is guaranteed to re-arm itself unless there is
> nothing to transmit anymore.
> 
> __mptcp_push_pending is different because that is called when new data
> is passed in via sendmsg, i.e. timer might not be running (yet).
> 
> Makes sense to you?

Yes, thanks for the explaination!

> > > > I'm wondering if this will cause a sort of 'spinning'/busy loop on
> > > > above condition inside mptcp_release_cb().
> > > 
> > > Hmm, right, that might indeed happen.
> > > It should be sae to remove the above clause and unconditioally wait
> > > for the reworked rtx timer to assert pending bit again.
> > 
> > +1 :) (assuming s/sae/safe/ :)
> 
> Yep, safe.  Test has been running for a few hours now with no failures,
> will send v2 shortly.

Excellent!

Cheeers,

Paolo

