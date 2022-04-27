Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1F87EF
	for <mptcp@lists.linux.dev>; Wed, 27 Apr 2022 08:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1651048048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eVGKDtkTqddzq8C3TGngM4zX40kv5AMY8xudyBBdJcA=;
	b=VCTKnXkN8lNH+csUrgJK9zgByE7vmdRJIBF9jb4G4uhEruIEUZkNnvf7VPFrS/ygLQQrFl
	DAIJ/oLf0NDZ0ZmuSaAKlWDrUxpdWKK0IueqTb+jHOJcLMCXQ40AeI2RIOOz2m9DLhOWpQ
	M2/nLlcC8HeQUtsJzB1Oz0Ot3c/oPtg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-F7oCpFWvNJiWkfdF7uf4lw-1; Wed, 27 Apr 2022 04:27:25 -0400
X-MC-Unique: F7oCpFWvNJiWkfdF7uf4lw-1
Received: by mail-wr1-f71.google.com with SMTP id l11-20020adfc78b000000b0020abc1ce7e4so466908wrg.1
        for <mptcp@lists.linux.dev>; Wed, 27 Apr 2022 01:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=eVGKDtkTqddzq8C3TGngM4zX40kv5AMY8xudyBBdJcA=;
        b=eufZdUCoR0rQgYs900UXvOlc5L9qInb+2cRvZO/q0yoG8D2jgS0DIfKJG08eETQIob
         1GZgcxoFi/lqBCkAWPRrmoGJw4YcEen8cEEUXsUJOYyDwB28ltT22OhgDvHjmjWiLqhV
         G4OzC3kyVvAbtNeJp/aPgy/bmmDkSK0YFQm4Cag29H+Y1HusXmcBFssB6VMY9gJ7xCpg
         Y3HwglHFIAu6EZFhd3NeO+kR1TT8ZEtwh9DUOQyt7w/NffuZcqVGMEAPlwKDUfpaVhIO
         TghqvwDe4Vd2oyhfPMOf6y+UhVz8jLOUT4a+ToO4uKjWnMcUKz2Xmew1kmkj1v5CJ9dn
         e2Yw==
X-Gm-Message-State: AOAM532psE+IXKzgkQjGyrvfI7CSax3ZfVvMdZqxb8PgAJQUzI6gUj8u
	R6qoZ7GlAoAsYrHmXRHPXZcuYx1Cc7UcVaQlD6viEuNBLJJh0UjxcKfH8hLfkypFkC1FulFUCIo
	ZCHsxmDjibkun3o8=
X-Received: by 2002:a5d:414b:0:b0:20a:dc15:bd00 with SMTP id c11-20020a5d414b000000b0020adc15bd00mr10937396wrq.136.1651048043701;
        Wed, 27 Apr 2022 01:27:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz36Aw4hmnmVRvqFpfIVZARNn99p+JbArZhTEGvCAJjZSlfgZ3EOC7f6ZNqYEod3FFGtyU5xg==
X-Received: by 2002:a5d:414b:0:b0:20a:dc15:bd00 with SMTP id c11-20020a5d414b000000b0020adc15bd00mr10937381wrq.136.1651048043404;
        Wed, 27 Apr 2022 01:27:23 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-117-160.dyn.eolo.it. [146.241.117.160])
        by smtp.gmail.com with ESMTPSA id o8-20020a5d6488000000b002051f1028f6sm15166078wri.111.2022.04.27.01.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 01:27:22 -0700 (PDT)
Message-ID: <d0234513a342a1c3e833c73663feac656d935cfc.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v16 5/8] mptcp: add get_subflow wrapper
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Date: Wed, 27 Apr 2022 10:27:21 +0200
In-Reply-To: <f69a828ffffa6b0a57d8913a273d84a9150cc860.1651024344.git.geliang.tang@suse.com>
References: <cover.1651024344.git.geliang.tang@suse.com>
	 <f69a828ffffa6b0a57d8913a273d84a9150cc860.1651024344.git.geliang.tang@suse.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
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

Hello,

First of all I'm sorry for the very late feedback: I had some
difficulties to allocate time to follow this development.

On Wed, 2022-04-27 at 09:56 +0800, Geliang Tang wrote:
> This patch defines a new wrapper mptcp_sched_get_subflow(), invoke
> get_subflow() of msk->sched in it. Use the wrapper instead of using
> mptcp_subflow_get_send() directly.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  net/mptcp/protocol.c |  9 ++++-----
>  net/mptcp/protocol.h | 16 ++++++++++++++++
>  2 files changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 7590e2d29f39..c6e963848b18 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1515,7 +1515,6 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
>  	subflow->avg_pacing_rate = div_u64((u64)subflow->avg_pacing_rate * wmem +
>  					   READ_ONCE(ssk->sk_pacing_rate) * burst,
>  					   burst + wmem);
> -	msk->last_snd = ssk;
>  	msk->snd_burst = burst;
>  	return ssk;
>  }

This breaks "mptcp: really share subflow snd_wnd": When the MPTCP-level
cwin is 0, we want to do 0-window probe (so mptcp_subflow_get_send()
return a 'valid' subflow) but we don't want to start a new burst for
such 0 win probe (so mptcp_subflow_get_send() clears last_snd).

With this change, when MPTCP-level cwin is 0, 'last_send' is not
cleared anymore. 

A simple sulution would be:

---
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 653757ea0aca..c20f5fd04cad 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1507,7 +1507,7 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
        burst = min_t(int, MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
        wmem = READ_ONCE(ssk->sk_wmem_queued);
        if (!burst) {
-               msk->last_snd = NULL;
+               msk->snd_burst = 0;
                return ssk;
        }
---

Probably a better solution would be adding 'snd_burst' to struct
mptcp_sched_data, and let mptcp_sched_get_subflow() update msk-
>snd_burst as specified by the scheduler. With this latter change the
'msk' argument in mptcp_sched_ops->schedule() could be const.

> @@ -1575,7 +1574,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
>  			int ret = 0;
>  
>  			prev_ssk = ssk;
> -			ssk = mptcp_subflow_get_send(msk);
> +			ssk = mptcp_sched_get_subflow(msk, false);
>  
>  			/* First check. If the ssk has changed since
>  			 * the last round, release prev_ssk
> @@ -1644,7 +1643,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
>  			 * check for a different subflow usage only after
>  			 * spooling the first chunk of data
>  			 */
> -			xmit_ssk = first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
> +			xmit_ssk = first ? ssk : mptcp_sched_get_subflow(mptcp_sk(sk), false);
>  			if (!xmit_ssk)
>  				goto out;
>  			if (xmit_ssk != ssk) {
> @@ -2489,7 +2488,7 @@ static void __mptcp_retrans(struct sock *sk)
>  	mptcp_clean_una_wakeup(sk);
>  
>  	/* first check ssk: need to kick "stale" logic */
> -	ssk = mptcp_subflow_get_retrans(msk);
> +	ssk = mptcp_sched_get_subflow(msk, true);
>  	dfrag = mptcp_rtx_head(sk);
>  	if (!dfrag) {
>  		if (mptcp_data_fin_enabled(msk)) {
> @@ -3154,7 +3153,7 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
>  		return;
>  
>  	if (!sock_owned_by_user(sk)) {
> -		struct sock *xmit_ssk = mptcp_subflow_get_send(mptcp_sk(sk));
> +		struct sock *xmit_ssk = mptcp_sched_get_subflow(mptcp_sk(sk), false);
>  
>  		if (xmit_ssk == ssk)
>  			__mptcp_subflow_push_pending(sk, ssk);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 22f3f41e1e32..91512fc25128 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -633,6 +633,22 @@ int mptcp_init_sched(struct mptcp_sock *msk,
>  		     struct mptcp_sched_ops *sched);
>  void mptcp_release_sched(struct mptcp_sock *msk);
>  
> +static inline struct sock *mptcp_sched_get_subflow(struct mptcp_sock *msk, bool reinject)
> +{
> +	struct mptcp_sched_data data = {
> +		.sock		= msk->first,
> +		.call_again	= 0,
> +	};

It's not clear to me:
- why we need the 'sock' argument, since the scheduler already get
'msk' as argument?
- why we need to initialize it (looks like an 'output' argument ?!?)
- what is the goal/role of the 'call_again' argument. It looks like we
just ignore it?!?

Side note: perhaps we should move the following chunk:

---
       sock_owned_by_me(sk);

        if (__mptcp_check_fallback(msk)) {
                if (!msk->first)
                        return NULL;
                return sk_stream_memory_free(msk->first) ? msk->first : NULL;
        }
---

  out of mptcp_subflow_get_send() into mptcp_sched_get_subflow(), so
that every scheduler will not have to deal with fallback sockets.

> +
> +	msk->sched ? INDIRECT_CALL_INET_1(msk->sched->get_subflow,
> +					  mptcp_get_subflow_default,
> +					  msk, reinject, &data) :
> +		     mptcp_get_subflow_default(msk, reinject, &data);

With this we have quite a lot of conditionals for the default
scheduler. I think we can drop the INDIRECT_CALL_INET_1() wrapper, and
rework the code so that msk->sched is always NULL with the default
scheduler.

And sorry to bring the next topic so late, but why a 'reinject'
argument instead of an additional mptcp_sched_ops op? the latter option
will avoid another branch in fast-path.

Thanks!

Paolo

