Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B56B2F28
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 09:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1644486207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wQRhz9PZp8CS2pvZ/auJtt6ALtI8AjTUC0baNU+EznM=;
	b=EajTdt6OS2jJAHbqV0Qz6Bp6MHgWba8Sz4Sx6vLoCpKQlVG4rZlYp6UNCkocHchFn0on0n
	ra+eq9ey4Uo/sB+bmfmkKoa4xoMGP45pZ5sbAJTpPhP1qSGQqs+pvXRFq8bHme8He6MQ/C
	b4ouzeFerrB8sMljOKWWTmHEuXgyJME=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-471-_q8jihAIPZCrm1l5sH8liQ-1; Thu, 10 Feb 2022 04:43:26 -0500
X-MC-Unique: _q8jihAIPZCrm1l5sH8liQ-1
Received: by mail-qt1-f200.google.com with SMTP id j6-20020ac85f86000000b002d9c2505d01so2910463qta.15
        for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 01:43:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=wQRhz9PZp8CS2pvZ/auJtt6ALtI8AjTUC0baNU+EznM=;
        b=SHBKwNHuV/OKLpTUS+Kghk9KXkuKFoMpXkmGz+YUAW34eCRzahEExkU49pY+IInlmD
         BCAJzC4O5D2/tNyuxZUBnorN8b8CTXJw3V2OeHWHv66iIsOzegZiYgwTXnervbCVULpD
         3ZaW4/wkHSZZGk5N7zELrNk+k+0uixwni8MEZIv6BoqpnW7+ALaQBYeCwjblXsukgGgM
         r88/nISfjyFr/vhzi3jVDGjnTSH/El0NE6oW2SuhHe49hY86+0M5a8XBQkKAO8eqIMLz
         Nijn2E4RkOShlqFqFB/TD+a7T9MvOE0K3D3FG8cjxDRaLXpZTS5GYDZMvZrxSYdDpC/a
         /kTw==
X-Gm-Message-State: AOAM530Dn7vGU2zkjd5fghhblR+VpIc5Oa8Ru6EN/4rnkXHKcqYucUKp
	zBEqOhjRK1UPpyV6vclkuSULgCDAwIq4XZp2wYT4BUNXpaCMfKvkXcyicUDZMN+poQN+5CUdTrC
	5ILPzbMTtWm6wZTg=
X-Received: by 2002:a05:622a:15ce:: with SMTP id d14mr4159993qty.182.1644486205401;
        Thu, 10 Feb 2022 01:43:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzTBdR8AUPcwvsrxz+eRb7xR04pJ0BVYwU8WGiUH+cINNJCYdDviGqNWBx1XxFaE2QOB+xwzA==
X-Received: by 2002:a05:622a:15ce:: with SMTP id d14mr4159982qty.182.1644486205157;
        Thu, 10 Feb 2022 01:43:25 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-96-254.dyn.eolo.it. [146.241.96.254])
        by smtp.gmail.com with ESMTPSA id i20sm10546298qtx.44.2022.02.10.01.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 01:43:24 -0800 (PST)
Message-ID: <ea6053c01893a72d09a1a96f4cb546153e3c6d10.camel@redhat.com>
Subject: Re: [PATCH mptcp-next] mptcp: don't save tcp data_ready and write
 space callbacks
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, Florian Westphal
	 <fw@strlen.de>
Cc: mptcp@lists.linux.dev
Date: Thu, 10 Feb 2022 10:43:21 +0100
In-Reply-To: <28823aca-ba8-8d18-629b-a95e18643889@linux.intel.com>
References: <20220209101133.19514-1-fw@strlen.de>
	 <28823aca-ba8-8d18-629b-a95e18643889@linux.intel.com>
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35)
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

On Wed, 2022-02-09 at 15:18 -0800, Mat Martineau wrote:
> On Wed, 9 Feb 2022, Florian Westphal wrote:
> 
> > Assign the helpers directly rather than save/restore in the context
> > structure.
> > 
> > Signed-off-by: Florian Westphal <fw@strlen.de>
> > ---
> > net/mptcp/protocol.h | 6 ++----
> > net/mptcp/subflow.c  | 4 ----
> > 2 files changed, 2 insertions(+), 8 deletions(-)
> > 
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index f37f087caab3..202004473292 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -479,9 +479,7 @@ struct mptcp_subflow_context {
> > 	struct	sock *tcp_sock;	    /* tcp sk backpointer */
> > 	struct	sock *conn;	    /* parent mptcp_sock */
> > 	const	struct inet_connection_sock_af_ops *icsk_af_ops;
> > -	void	(*tcp_data_ready)(struct sock *sk);
> > 	void	(*tcp_state_change)(struct sock *sk);
> > -	void	(*tcp_write_space)(struct sock *sk);
> > 	void	(*tcp_error_report)(struct sock *sk);
> > 
> > 	struct	rcu_head rcu;
> > @@ -626,9 +624,9 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow);
> > static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
> > 					      struct mptcp_subflow_context *ctx)
> > {
> > -	sk->sk_data_ready = ctx->tcp_data_ready;
> > +	sk->sk_data_ready = sock_def_readable;
> > 	sk->sk_state_change = ctx->tcp_state_change;
> > -	sk->sk_write_space = ctx->tcp_write_space;
> > +	sk->sk_write_space = sk_stream_write_space;
> > 	sk->sk_error_report = ctx->tcp_error_report;
> > 
> > 	inet_csk(sk)->icsk_af_ops = ctx->icsk_af_ops;
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index 485f00dcaf84..d4b4d285ffc1 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -1661,9 +1661,7 @@ static int subflow_ulp_init(struct sock *sk)
> > 	tp->is_mptcp = 1;
> > 	ctx->icsk_af_ops = icsk->icsk_af_ops;
> > 	icsk->icsk_af_ops = subflow_default_af_ops(sk);
> > -	ctx->tcp_data_ready = sk->sk_data_ready;
> > 	ctx->tcp_state_change = sk->sk_state_change;
> > -	ctx->tcp_write_space = sk->sk_write_space;
> > 	ctx->tcp_error_report = sk->sk_error_report;
> > 	sk->sk_data_ready = subflow_data_ready;
> > 	sk->sk_write_space = subflow_write_space;
> 
> 
> Should we add any paranoid BUG_ON() checks to confirm that these sk 
> members are still set to sock_def_readable/sk_stream_write_space by TCP?
> 
> I don't expect those to ever change... but it seems better to not assume.

Yep, better safe than sorry ;). I guess WARN_ON_ONCE() should be
enough.

Thanks!

/P


