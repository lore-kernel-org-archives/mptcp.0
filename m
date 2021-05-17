Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D208970
	for <mptcp@lists.linux.dev>; Mon, 17 May 2021 16:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1621269814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y2OMkw9y9/1WEm4FjfUGRuR5W+K+olSRNoyIuCD/MC0=;
	b=K4hICCGsSUbxN/g42m/S/WizTFJpMIqJKnkBiZdg9emXlGnh2ZhCJf5LnkkPZmbNeRAWSj
	lSPUyff9nodaD9pMv30V2GhBFiPln7OiC7t0b6ucO3gbzEnN9YmBBr8gn+Y6h5kAgfglpx
	X6OnJbRXok5Zl6kycLBKB/UtWgWDzgE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-93f9tNu2PDmKPLV1xpAjGA-1; Mon, 17 May 2021 12:43:32 -0400
X-MC-Unique: 93f9tNu2PDmKPLV1xpAjGA-1
Received: by mail-wr1-f70.google.com with SMTP id i102-20020adf90ef0000b029010dfcfc46c0so4094435wri.1
        for <mptcp@lists.linux.dev>; Mon, 17 May 2021 09:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=y2OMkw9y9/1WEm4FjfUGRuR5W+K+olSRNoyIuCD/MC0=;
        b=BVC6V+Hv0kgSb5pvYW+9v322lHwotY6EW8DEwhYOjlWaJSny1y+OWhE5tV4vL9Dqjc
         K3L/YBcMjHrxmgqURFFCIY6zeCr7QLMYsJP8PiQu1dVqacyNxjDmyzzrbLnef9J4PxI7
         6D2ji9Cd4eHsLA8cNcz9wfA1mSoWgM5vutfFDlkhX/G7mp+b2UKcipAvAvmLX10855rl
         BfVSUQj+NVmjVLnhZHZtZmNQvgnf0/VChjvdcYc9iA/V2LCkRSDMzbPoTmJUHj8I3dK3
         ymhzLrUFnYIf2US+ErxbMzTKwLvmayVxyKbzBBg0Y6V8qULW6G4tJe2ID0PTLTFoI4P/
         3wJQ==
X-Gm-Message-State: AOAM5314X/FqUJl9J0Iu6dnuksjx8JlKU/vrV6Vv+xp86SSFcPZuyHNg
	FaMrWlaCe//yyWtXoNDdGV/bX8ffvli0IlK2RgsvJB6Q8/E5QubgRcPEA1YywmGrv9HjTdxIYul
	a6etx9aGE6p/4c198xm7ixzGTH2mTYo/AjiBlj0Rcy85Zht0Qy0LOxaa2xir+0hGS
X-Received: by 2002:a7b:c1c5:: with SMTP id a5mr12179wmj.63.1621269810953;
        Mon, 17 May 2021 09:43:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvW9HMRX54rwrTaFffOLDYnsYG4CogPSftPsBf9qxTNtyXPXZCUIgLKD4VgDeZ2wzjD87aLQ==
X-Received: by 2002:a7b:c1c5:: with SMTP id a5mr12163wmj.63.1621269810741;
        Mon, 17 May 2021 09:43:30 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-245-104.dyn.eolo.it. [146.241.245.104])
        by smtp.gmail.com with ESMTPSA id k20sm7039695wrc.1.2021.05.17.09.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 09:43:30 -0700 (PDT)
Message-ID: <77c418efaefe6e91c489a72e887b4ba8426cfb4b.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: always parse mptcp options for MPC
 reqsk
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev, Mat Martineau
 <mathew.j.martineau@linux.intel.com>,  Christoph Paasch <cpaasch@apple.com>
Date: Mon, 17 May 2021 18:43:29 +0200
In-Reply-To: <84d520ef86f7ba9644383f421ea4eb0b62c2cc1c.camel@redhat.com>
References: <024b61f2b46bb7f8d02db1dbdd1c822859b78674.1621248230.git.pabeni@redhat.com>
	 <84d520ef86f7ba9644383f421ea4eb0b62c2cc1c.camel@redhat.com>
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

On Mon, 2021-05-17 at 13:32 +0200, Paolo Abeni wrote:
> On Mon, 2021-05-17 at 12:44 +0200, Paolo Abeni wrote:
> > In subflow_syn_recv_sock() we currently skip options parsing
> > for OoO packet, given that such packets may not carry the relevant
> > MPC option.
> > 
> > If the peer generates an MPC+data TSO packet and some of the early
> > segments are lost or get reorder, we server will ignore the peer key,
> > causing transient, unexpected fallback to TCP.
> > 
> > The solution is always parsing the incoming MPTCP options, and
> > do the fallback only for in-order packets. This actually cleans
> > the existing code a bit.
> > 
> > Reported-by:  Matthieu Baerts <matthieu.baerts@tessares.net>
> > Fixes: d22f4988ffec ("mptcp: process MP_CAPABLE data option")
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/192
> > iSigned-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > a note on data ack len: with this patch the server will use
> > ack32 for OoO MPC+data pkts, and will move to ack64 ASA will get
> > the first in order MPC+data pkt.
> > 
> > We can clean-up/make more consistent the behavior with some additional
> > check in mptcp_sk_clone and/or subflow_syn_recv_sock(), but I prefer
> > to not introduce only partially related changes here
> 
> I just note the above is not a complete fix for issues/192.
> 
> Specifically we can have:
> 
> syn +  MPC ->
>           <- syn + ack + MPC ACK
> ack + MPC -> [not received by the server due to packet loss]
> ack + MPC + data -> [not received by the server due to packet loss]
> 		    [this cover data _after_ the MPC + data above]
> ack + DSS(DSS > 1) -> 

At this point the server can only reply with a TCP sack with no MPTCP
ack. Davide noted that the server should as well fallback to TCP.

I'll send a v2 doing the above after some more testing.

Side note: the self-tests end-up failing with reset and timeout because
we currently mis-handle a fallback scenario with a rst.

Another patch needed :(

/P

