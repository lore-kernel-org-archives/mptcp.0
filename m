Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2C823CB
	for <mptcp@lists.linux.dev>; Mon,  6 Jun 2022 11:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1654513883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/PzYEeWFnq3O5f5LfccRnlVq3Nw3IzxiT2+LvE6z5hE=;
	b=O34K59y+n8D+IFRLDD6sBlhnk7yvpxfi+YWZdzv7HNv47n/L7TKp/k+OGUTgm5q/JXXQDm
	gENAIlkcrREnd/J5zlK2kUShRtxcziaMzWuXdOybu3Q9dcpiAQnDiYaXr3UVjc/Ym+pRHu
	93zaDMnG1hj/K0JyFtEh4qvTn3YIN54=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-527-EAcLC_aXO664-2a56cB4Ww-1; Mon, 06 Jun 2022 07:11:21 -0400
X-MC-Unique: EAcLC_aXO664-2a56cB4Ww-1
Received: by mail-wr1-f71.google.com with SMTP id s16-20020adfeb10000000b0020cc4e5e683so2689429wrn.6
        for <mptcp@lists.linux.dev>; Mon, 06 Jun 2022 04:11:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=/PzYEeWFnq3O5f5LfccRnlVq3Nw3IzxiT2+LvE6z5hE=;
        b=lnFkANE1ELNJtdOAVw/wIwvXtTAdTbWnNOvzvLXpv1B9jgr+pkIzGRL2/TuLlMs+kF
         EnveHvH14TTT0MITnLcOeY9bxYQwcwpwnhbYcXuCOWdN0sxXfSGj+6qFqkk1DpW4SMNY
         Q9DF+GXpdHu00NwdZRuXEkRKzT+NgAn8a/kq8JCsdbxgCnDchLLEbe9qapFrnfU0if6+
         dsLON9UP4QMFKTlnF/sHmkHxP0HOIeQtb86a2irtvRtG4hCTDV2tz4XDoAf/gbkSLTjp
         UUTfPJfusyuQAaS0igta/teCHOgYRdmHc1em7kM05iEmJVsYxsm/29OOCue+SNWsfT4x
         BiWw==
X-Gm-Message-State: AOAM5311lIi77np1q1dcxb+aZlqfj23rII7MIa3Ham9ohgQFKhUASmNR
	hFKVA3qU9pR296xPfEgPHVN3nsH7GVzA4IxOzn6ATbT5BkzNwNjqhCaZAOvXeG5/K9LqKJ2sapB
	3mom8kD1clr5PP6Y=
X-Received: by 2002:a1c:4682:0:b0:39c:4459:6a84 with SMTP id t124-20020a1c4682000000b0039c44596a84mr12624169wma.167.1654513880294;
        Mon, 06 Jun 2022 04:11:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyd/rPg+cMMT/aIyv2HlbX0mtkGlpPhwbsMQzWlM901VbrGCETvnzN7hgejG04mXo1ajTmVXQ==
X-Received: by 2002:a1c:4682:0:b0:39c:4459:6a84 with SMTP id t124-20020a1c4682000000b0039c44596a84mr12624151wma.167.1654513880020;
        Mon, 06 Jun 2022 04:11:20 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-112-184.dyn.eolo.it. [146.241.112.184])
        by smtp.gmail.com with ESMTPSA id p3-20020a05600c358300b0039c4cc65701sm4252264wmq.3.2022.06.06.04.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 04:11:19 -0700 (PDT)
Message-ID: <9cf0e60d27b46012298ad03fa32d12bdc6b29acd.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v4 3/5] mptcp: add mptcp_sched_get_send
 wrapper
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Date: Mon, 06 Jun 2022 13:11:18 +0200
In-Reply-To: <0d87803df540cb9e103b3696a366b5355c0104f7.1654508532.git.geliang.tang@suse.com>
References: <cover.1654508532.git.geliang.tang@suse.com>
	 <0d87803df540cb9e103b3696a366b5355c0104f7.1654508532.git.geliang.tang@suse.com>
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

On Mon, 2022-06-06 at 17:47 +0800, Geliang Tang wrote:
> This patch defines the wrapper mptcp_sched_get_send(), invoke
> __mptcp_sched_get_send() in it. Use this wrapper instead of using
> mptcp_subflow_get_retrans() directly in __mptcp_subflow_push_pending().
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  net/mptcp/protocol.c |  4 ++--
>  net/mptcp/protocol.h |  1 +
>  net/mptcp/sched.c    | 26 ++++++++++++++++++++++++++
>  3 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 999e83eae821..16612bed5890 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1635,7 +1635,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
>  			 * check for a different subflow usage only after
>  			 * spooling the first chunk of data
>  			 */
> -			xmit_ssk = first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
> +			xmit_ssk = first ? ssk : mptcp_sched_get_send(mptcp_sk(sk));
>  			if (!xmit_ssk)
>  				goto out;
>  			if (xmit_ssk != ssk) {
> @@ -3125,7 +3125,7 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
>  		return;
>  
>  	if (!sock_owned_by_user(sk)) {
> -		struct sock *xmit_ssk = mptcp_subflow_get_send(mptcp_sk(sk));
> +		struct sock *xmit_ssk = mptcp_sched_get_send(mptcp_sk(sk));
>  
>  		if (xmit_ssk == ssk)
>  			__mptcp_subflow_push_pending(sk, ssk);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 4669d34f4d7c..6d9e8ec5c96f 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -634,6 +634,7 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
>  struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
>  struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
>  int __mptcp_sched_get_send(struct mptcp_sock *msk);
> +struct sock *mptcp_sched_get_send(struct mptcp_sock *msk);
>  int __mptcp_sched_get_retrans(struct mptcp_sock *msk);
>  
>  static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *subflow)
> diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> index 70ab43c59989..70c6b7b86f23 100644
> --- a/net/mptcp/sched.c
> +++ b/net/mptcp/sched.c
> @@ -147,6 +147,32 @@ int __mptcp_sched_get_send(struct mptcp_sock *msk)
>  	return 0;
>  }
>  
> +struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct sock *ssk = NULL;
> +	int err;
> +
> +	err = __mptcp_sched_get_send(msk);
> +	if (err)
> +		return NULL;
> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		if (READ_ONCE(subflow->scheduled)) {
> +			/*
> +			 * TODO: Redundant subflows are not supported in
> +			 * __mptcp_subflow_push_pending() yet. Here's a
> +			 * placeholder to pick the first subflow for the
> +			 * redundant subflows case.
> +			 */
> +			ssk = subflow->tcp_sock;
> +			break;
> +		}
> +	}
> +
> +	return ssk;
> +}
> +
>  int __mptcp_sched_get_retrans(struct mptcp_sock *msk)
>  {
>  	struct mptcp_sched_data data;

I think we should try to preserver the optimization to
mptcp_subflow_get_send() for the non eBPF case, to avoid unnecessary
subflow traversal.

Thanks!

Paolo

