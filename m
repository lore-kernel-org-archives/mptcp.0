Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC4B3FC0
	for <mptcp@lists.linux.dev>; Mon,  6 Sep 2021 07:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1630914202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j8Q80me6CldVAPIXS8oVt4BbL/lyZkHtjfS5TQgU67k=;
	b=Sgq/s8aLPLY/d5dnp8hYARs3xFlSvcTpzMMNxvPV8+yb1zI0cytqNDeE4vjJi/xi1pbS+p
	q28TlzHL50pZN8bEzpcwVxoXhkUXLPiNrCZV7sELOXVhpu/PgAcBHAmugpy0jDrh2dSe6N
	AIe+KeKd4OqEYnI4in9QGnZBo4dBjFI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-_Yh3ubc-N02S3yJaFSxUnQ-1; Mon, 06 Sep 2021 03:43:21 -0400
X-MC-Unique: _Yh3ubc-N02S3yJaFSxUnQ-1
Received: by mail-wm1-f70.google.com with SMTP id o20-20020a05600c379400b002e755735eedso2926964wmr.0
        for <mptcp@lists.linux.dev>; Mon, 06 Sep 2021 00:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=j8Q80me6CldVAPIXS8oVt4BbL/lyZkHtjfS5TQgU67k=;
        b=hJRgw0jADVOEztN70Yw4BXKJl1VUmGXVtOnQlN99EBC7SJ2FbJAfrAYFgismzZLvwK
         h7eqv9qCT+68NQ8e6HAhBddWJkBTzYt2goL6lQym9MI7dQiAORbsbGsMBLuHPdv7nHhq
         LFoYV8RZBJ6+v921BdciwuoFVc2RSYsmMPGLzOETHcaikjSkOY/fEdkrocOY9gEwdB+w
         EKL25N2/YThb+U1ImR/W9kBgE7RE2AnNCg6Ei/B2Ukj3zHtDfmDyKO+FqWNxX/aDX9k/
         mKL3iokFFVV7axG1LsRoJd7oRNdtqS3b9iOSgRCmfUnlgT6EZ4F+X5AITwjw0yOxdxnR
         ABfQ==
X-Gm-Message-State: AOAM530kXWXk/2x5+1Hp2Kn64OkJM/phwZflpV41QP2X6gLqqI4QRGD/
	Iqx9PLWUFcC2hSElQlQYrCIP3CzLq0Wf73jhmfnhPEq/kkvIJ16n1pHGq6VlwVGnJ3UrX20hWFJ
	gYkw8L9usfg/4ojo=
X-Received: by 2002:a1c:44c4:: with SMTP id r187mr9963280wma.69.1630914200218;
        Mon, 06 Sep 2021 00:43:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrn4TcpV0smSF6DumlQgoIoAoN1clnBPBYKplP28QiIRBhR7x2kzQ1Kx0GaALwxXQLse+gjg==
X-Received: by 2002:a1c:44c4:: with SMTP id r187mr9963262wma.69.1630914199937;
        Mon, 06 Sep 2021 00:43:19 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-233-185.dyn.eolo.it. [146.241.233.185])
        by smtp.gmail.com with ESMTPSA id f7sm6473340wmh.20.2021.09.06.00.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 00:43:19 -0700 (PDT)
Message-ID: <aaefcedbe475b6bf060bbb4d6266233d57d59225.camel@redhat.com>
Subject: Re: [mptcp-next 2/2] mptcp: re-set push-pending bit on retransmit
 failure
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev, Matthieu Baerts
	 <matthieu.baerts@tessares.net>
Date: Mon, 06 Sep 2021 09:43:17 +0200
In-Reply-To: <20210906060614.25217-3-fw@strlen.de>
References: <20210906060614.25217-1-fw@strlen.de>
	 <20210906060614.25217-3-fw@strlen.de>
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

On Mon, 2021-09-06 at 08:06 +0200, Florian Westphal wrote:
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
> This function checks for subflows that have become unresponsive and marks
> them as stale, so in the case where the rtx queue is empty, subflows
> will never be marked stale which prevents available backup subflows from
> becoming eligible for transmit.
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>

Looks great, but I'm struggling to follow the code in a couple of
points, see below...

> ---
>  net/mptcp/protocol.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index c0e0ee4cb24f..b88a9b61025b 100644
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

@Mat: I'm wild guessing the above could possibly address also
issues/230. Could you please give it a spin in the CI? How frequently
do you observe the mentioned issue in the CI?

> } else {
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
> @@ -1603,6 +1611,13 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
>  		mptcp_push_release(sk, ssk, &info);
>  
>  out:
> +	/* Set PENDING again in case we found an ssk
> +	 * that could not accept more data
> +	 */
> +	if (unlikely(copied == 0) &&
> +	    READ_ONCE(msk->snd_una) == msk->snd_nxt && ssk)
> +		mptcp_check_and_set_pending(sk);

@Florian: Why we need to check for ssk != NULL?
Do we need something similar for __mptcp_subflow_push_pending(), too? 
I'm wondering if this will cause a sort of 'spinning'/busy loop on
above condition inside mptcp_release_cb(). Could we just ensure that
the rtx timer is harmed instead? We likely have to wait a bit for the
subflow to become ready, I think.

Cheers,

Paolo

