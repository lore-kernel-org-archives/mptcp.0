Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED1B68
	for <mptcp@lists.linux.dev>; Thu,  4 Nov 2021 11:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1636026562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vVBD0MP0e2013ZR1qgdvXmirieBXHT4WtRUchBv2CaI=;
	b=P3LfeJeuVEL8r+wjELwxe4gHYlOgthKp8nJQC+GltCoxODh4tuLNaOvTzkvMI57W3GPiY2
	bVMJ1zyhUzMiTNscnkYTdNXEuIuadGPPkBD/OvmFhWBqdY9eswzPtm99gf6KiUGLUl5fSz
	sbGZjur6g3pV8Ws77i3hdeThOAFOsU8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-yw5DRijxNIG5k0_iZ8V_WQ-1; Thu, 04 Nov 2021 07:49:17 -0400
X-MC-Unique: yw5DRijxNIG5k0_iZ8V_WQ-1
Received: by mail-ed1-f70.google.com with SMTP id t18-20020a056402021200b003db9e6b0e57so5448843edv.10
        for <mptcp@lists.linux.dev>; Thu, 04 Nov 2021 04:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=vVBD0MP0e2013ZR1qgdvXmirieBXHT4WtRUchBv2CaI=;
        b=bmest8OHZUfCvH2qrVH0l2+VJ8Lx53yy4H8RiWcwxvq99gSW00OMpI0B0KnrHv4XLS
         lbB6ronj7LO3PQlh5LpZtINonu8BcuQU9usoSsVCcvF7xCx6SuKkyNy3X4h9myr2VUj9
         D1o7JZtdtRsAZnorCWNrBmozeidx2j/aj44I906FoO1PtbAht+JA61a1UXFpt1T85IDH
         gRsqAZPkd9nqHt4hHah65G1lsIUPrJjfOhDXDQTukYUif63sxrHEqMvmF2R/nXofmFO3
         sRJbhJ+jrTFWiPpAmmPMBzKOHnzxLU83ffPMLvAKqjOs3U11lvkHHBSVoP6NkufxC7f8
         7h4w==
X-Gm-Message-State: AOAM531Ty3jWgWtC3l7rsElDN+YEw8yeOz0LmlavpctAzqE4JC3qSt7o
	dj/1MsKGGw2ApN+kM9Ky4B4DlNhI+oxfaIJ/52TGz9JV793e9WI7+ixl0wmcQsMXt1GEPCcIIfc
	ed0Zqa474CKznTH0=
X-Received: by 2002:a05:6402:5189:: with SMTP id q9mr66571796edd.94.1636026556388;
        Thu, 04 Nov 2021 04:49:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjhQBZ+ZNNt2P30fvph8s9CgIlw/DbkvJy3YhyE8kV3hNSCrVh9VwabL27b3EbrG1JkaMtDg==
X-Received: by 2002:a05:6402:5189:: with SMTP id q9mr66571773edd.94.1636026556125;
        Thu, 04 Nov 2021 04:49:16 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-236-6.dyn.eolo.it. [146.241.236.6])
        by smtp.gmail.com with ESMTPSA id f18sm2968258edd.10.2021.11.04.04.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 04:49:15 -0700 (PDT)
Message-ID: <85d45ed2fb3a781b6f1d56b71c56172eac2887fa.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: fix race between close() and accept()
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Thu, 04 Nov 2021 12:49:14 +0100
In-Reply-To: <d77d8e84-90a9-8c61-1460-eb569646ca62@linux.intel.com>
References: <beea1c3bd7e3fc9b8bc309874cec2597766d7fba.1635958931.git.pabeni@redhat.com>
	 <d77d8e84-90a9-8c61-1460-eb569646ca62@linux.intel.com>
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

On Wed, 2021-11-03 at 16:06 -0700, Mat Martineau wrote:
> On Wed, 3 Nov 2021, Paolo Abeni wrote:
> 
> > The current implementation of mptcp_accept() is prone to the
> > following race vs mptcp_close():
> > 
> > (on CPU 0)
> > listen(msk)
> > accept(msk)
> >  |-> mptcp_stream_accept(msk)
> >        |-> <listen status check successful>
> > 
> > (preempted or on CPU 1)
> > close(msk)
> >  |-> <msk->sk_state = TCP_CLOSE, ssk is orphaned, ssk state is unchanged>
> > 
> > (preempted or on CPU 0, continuing accept())
> >  |-> mptcp_accept()
> >        |-> inet_csk_accept()
> >              |-> <ssk status check is successful even if ssk is orphaned: oops>
> > 
> > The solution is atomically close the listener subflow at mptcp_close()
> > time.
> > 
> > Reported-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> > Fixes: e16163b6e2b7 ("mptcp: refactor shutdown and close")
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > Note: this should close:
> > 
> > https://github.com/multipath-tcp/mptcp_net-next/issues/239
> > 
> > but without a repro I can't be sure...
> > ---
> > net/mptcp/protocol.c | 13 ++++++++++---
> > 1 file changed, 10 insertions(+), 3 deletions(-)
> > 
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 1ee3530ac2a3..4c96a9eb2142 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -2712,18 +2712,25 @@ static void mptcp_close(struct sock *sk, long timeout)
> > 	lock_sock(sk);
> > 	sk->sk_shutdown = SHUTDOWN_MASK;
> > 
> > -	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)) {
> > -		inet_sk_state_store(sk, TCP_CLOSE);
> > +	if (sk->sk_state == TCP_LISTEN) {
> > +		struct socket *listener;
> > +
> > +		listener = __mptcp_nmpc_socket(mptcp_sk(sk));
> > +		if (listener)
> > +			__mptcp_close_ssk(sk, listener->sk, mptcp_subflow_ctx(listener->sk));
> 
> It looks like __mptcp_close_ssk() will call 
> mtpcp_dispose_initial_subflow() and destroy the listener without regard 
> to the listener's sk_refcnt.

Ah! I think I see! double checking I understand the above
correctly: mptcp_dispose_initial_subflow() frees msk->subflow, and a
racing listen() can hit UaF while dererencing msk->subflow. It that the
critical scenario you refear to?

I reviewed again the race described in this patch, and now think I'm
wrong about it - details on the github ticket. This patch is likely
useless.

> Does it make sense to wait until __mptcp_destroy_sock() to dispose of the 
> listener instead (there's already a call there to do that), and 
> add sock_hold(listener->sk)/sock_put(listener->sk) in mptcp_accept()?

We already have sock_hold/sock_put in mptcp_stream_accept, I think
adding another pair in mptcp_accept should not help?!? And I really
would like to get rid of the existing pair...

Thanks!

Paolo

