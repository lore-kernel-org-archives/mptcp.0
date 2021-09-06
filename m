Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5103FC1
	for <mptcp@lists.linux.dev>; Mon,  6 Sep 2021 13:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1630935744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FgRJl6Ymv0EsdpibvohGwGh5m0v7JiskxtfR87+CppA=;
	b=MSQvjdRQy/Et71Shg3TbfGKc2tl1wQD5Yyo//lrM1ZQcJ6aw7ce4TE6ldfEkWbLGbfZ9r4
	/Rm01pZZd2EzSnz+l1m7yXeV4ByTbXKLxGeQ84srduoV31IZSIyd90xgxaFh1ABda7wlNU
	RJ7C3hvRFsq/IlW6RKVeDv/ePiu4808=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-YgI83qdgN6G7zv9jChwboQ-1; Mon, 06 Sep 2021 09:42:22 -0400
X-MC-Unique: YgI83qdgN6G7zv9jChwboQ-1
Received: by mail-wr1-f72.google.com with SMTP id d10-20020adffbca000000b00157bc86d94eso1200331wrs.20
        for <mptcp@lists.linux.dev>; Mon, 06 Sep 2021 06:42:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=FgRJl6Ymv0EsdpibvohGwGh5m0v7JiskxtfR87+CppA=;
        b=BmJkSrdTwEYBC5cityxPhCahYNLX8w72rq13qdpqp4b/lRO12yIpHvzMIU5jp/QFeS
         Neb0ryNCncCmEHHiiOwcJabroRcVQeb93MN/LIR1ERiUi03Mkh5eRPxOg4s9k4T9w8/5
         fRmV56eYI4QSnUm3L7fwJ58+GK3B3JM3hcNmUhhpPWz1Op5SWbuCFA6b3lnXrNsZbS2d
         33WNO+NHxYrX0PZWj2GhXhcHf7v9gEAV6YaHKbyhvHh61eoG9IJN+sMMVbJOzY/qpX9O
         VmRPVhTd0W8IyYDc15Ecc1ji1X8sc8jVKt+4dsVH4qXp87+Q18X/OBmFfdErbBJWfnoF
         c+5A==
X-Gm-Message-State: AOAM531tXUFHOoa7Ofp6rntZDh629SUTSnPVyzp4Ld1svlOj9YCJZcTQ
	OXt/CP0Ng0p7Smm8XqXIVau5YdIRYD/CJWcGoMv5eLMzN+YaBhK4gUr+Jg2ErIBkiZlQepFEkOb
	Y/tmhXDG6WUFVX3A=
X-Received: by 2002:adf:b7c5:: with SMTP id t5mr13383593wre.322.1630935741070;
        Mon, 06 Sep 2021 06:42:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfyQV3+T34+o5J3JCG2wB+eKhmsxNF7YtSvFGn5x8qmzmJqHc33aqQiyUOXrAM7ZT4bathIg==
X-Received: by 2002:adf:b7c5:: with SMTP id t5mr13383578wre.322.1630935740878;
        Mon, 06 Sep 2021 06:42:20 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-233-185.dyn.eolo.it. [146.241.233.185])
        by smtp.gmail.com with ESMTPSA id r26sm7153945wmh.27.2021.09.06.06.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 06:42:20 -0700 (PDT)
Message-ID: <b813a7d19914c8ab740fd278c1056c561cddadcd.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2 2/2] mptcp: re-arm retransmit timer if
 data is pending
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Date: Mon, 06 Sep 2021 15:42:19 +0200
In-Reply-To: <20210906131045.18513-3-fw@strlen.de>
References: <20210906131045.18513-1-fw@strlen.de>
	 <20210906131045.18513-3-fw@strlen.de>
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

On Mon, 2021-09-06 at 15:10 +0200, Florian Westphal wrote:
> The retransmit head will be NULL in case there is no in-flight data
> (meaning all data injected into network has been acked).
> 
> In that case the retransmit timer is stopped.
> 
> This is only correct if there is no more pending, not-yet-sent data.
> 
> If there is, the retransmit timer needs to set the PENDING bit again so
> that mptcp tries to send the remaining (new) data once a subflow can accept
> more data.
> 
> Also, mptcp_subflow_get_retrans() has to be called unconditionally.
> 
> This function checks for subflows that have become unresponsive and marks
> them as stale, so in the case where the rtx queue is empty, subflows
> will never be marked stale which prevents available backup subflows from
> becoming eligible for transmit.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/226
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  Changes in v2:
>   - drop reset-pending conditional in __mptcp_push_pending,
>     retrans timer already takes care of this (Paolo)
>   - rename patch subject
>   - add a 'closes' tag to commit message
> 
>  net/mptcp/protocol.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index c0e0ee4cb24f..73cb5d053785 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1105,7 +1105,8 @@ static void __mptcp_clean_una(struct sock *sk)
>  	if (cleaned && tcp_under_memory_pressure(sk))
>  		__mptcp_mem_reclaim_partial(sk);
>  
> -	if (snd_una == READ_ONCE(msk->snd_nxt) && !msk->recovery) {
> +	if (snd_una == READ_ONCE(msk->snd_nxt) &&
> +	    snd_una == READ_ONCE(msk->write_seq)) {
>  		if (mptcp_timer_pending(sk) && !mptcp_data_fin_enabled(msk))
>  			mptcp_stop_timer(sk);
>  	} else {
> @@ -1547,6 +1548,13 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
>  		msk->snd_nxt = snd_nxt_new;
>  }
>  
> +static void mptcp_check_and_set_pending(struct sock *sk)
> +{
> +	if (mptcp_send_head(sk) &&
> +	    !test_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->flags))
> +		set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->flags);
> +}
> +
>  void __mptcp_push_pending(struct sock *sk, unsigned int flags)
>  {
>  	struct sock *prev_ssk = NULL, *ssk = NULL;
> @@ -2414,6 +2422,9 @@ static void __mptcp_retrans(struct sock *sk)
>  	int ret;
>  
>  	mptcp_clean_una_wakeup(sk);
> +
> +	/* first check ssk: need to kick "stale" logic */
> +	ssk = mptcp_subflow_get_retrans(msk);
>  	dfrag = mptcp_rtx_head(sk);
>  	if (!dfrag) {
>  		if (mptcp_data_fin_enabled(msk)) {
> @@ -2426,10 +2437,12 @@ static void __mptcp_retrans(struct sock *sk)
>  			goto reset_timer;
>  		}
>  
> -		return;
> +		if (!mptcp_send_head(sk))
> +			return;
> +
> +		goto reset_timer;
>  	}
>  
> -	ssk = mptcp_subflow_get_retrans(msk);
>  	if (!ssk)
>  		goto reset_timer;
>  
> @@ -2456,6 +2469,8 @@ static void __mptcp_retrans(struct sock *sk)
>  	release_sock(ssk);
>  
>  reset_timer:
> +	mptcp_check_and_set_pending(sk);
> +
>  	if (!mptcp_timer_pending(sk))
>  		mptcp_reset_timer(sk);
>  }

LGTM, thanks Florian!

Acked-by: Paolo Abeni <pabeni@redhat.com>

