Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59473FD0
	for <mptcp@lists.linux.dev>; Tue, 14 Sep 2021 15:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1631633535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4LsBYEpSFNNxqLYsuSciFZQ+BDnsOGrROIqmM4KKMbE=;
	b=a2Be4m5cbUv3Z6Tp2TUnZ/P2L7OMJ8sAmmoGicXLMXWETKkyB4DHsMXCykNRCHqhYvg/wh
	uYpIHCb92YKbxxWc9Vcx52vDTrg6Ld1JtDZijjDPYez2cLujpWQ75XRWJ540e1PBef0/gx
	YEgEmPEefdOq99RXWD0fJGGLPzIhfL8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-wHOTRYLNOEK-Zs-04BAcXA-1; Tue, 14 Sep 2021 11:32:14 -0400
X-MC-Unique: wHOTRYLNOEK-Zs-04BAcXA-1
Received: by mail-wm1-f71.google.com with SMTP id c187-20020a1c35c4000000b00304b489f2d8so4786535wma.6
        for <mptcp@lists.linux.dev>; Tue, 14 Sep 2021 08:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=4LsBYEpSFNNxqLYsuSciFZQ+BDnsOGrROIqmM4KKMbE=;
        b=AdNXmsRKegH63NQ7i6FEg4/08RoRujNTvZzYAhhYujmk39DwK2dCjRFAWFPEa0S6yg
         KjeJa5TXZ3CzCKSc9vYQXfDGcNg67FuWF1cZchdJMGhbAvgwdcdJZBcE3dKRF7T3W83z
         gXfnXyF5d3bWQBFUmlgnqFShLiJwaQFI8VDKHgxAPD+RYcEYTmSQLhUcQgWEfmGeReli
         bMNyPnIs7LwVMGLuhUwqbryUMjPJ9YUlqmAiAUxYKj9kAOM7VnZAF+0kI2KApR5wV6s+
         E3k0S7taIJhE3CoNCiPcsqw/uY7Ufl1LLwoXZQ/OnhgV2E5K1+rx+NRwlINIfespUJQU
         wn9w==
X-Gm-Message-State: AOAM53085WFECRF78mnzSZ9sxtm9h5NOjKZpNn9srvgf2wBb6dtvnudP
	FYQwxatv5EZOjOYeMn3Q9mjlszTYcH8coYxYIPZ4/GQ+Vxo0WN1Ucw0iZ2n1xsDSe4bRreutNok
	CastJa5amsm9PiyU=
X-Received: by 2002:adf:ec0d:: with SMTP id x13mr2139534wrn.38.1631633532906;
        Tue, 14 Sep 2021 08:32:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfc6l2pfri1klcpAtQeyoC8K02eFnVli4KyoJD5o0XGcy+3CRMyBvGrkG/X4kKrkzQAqxKSg==
X-Received: by 2002:adf:ec0d:: with SMTP id x13mr2139495wrn.38.1631633532580;
        Tue, 14 Sep 2021 08:32:12 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-254-211.dyn.eolo.it. [146.241.254.211])
        by smtp.gmail.com with ESMTPSA id p21sm1527453wmi.30.2021.09.14.08.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 08:32:12 -0700 (PDT)
Message-ID: <bd5b486dab66893019096ebc468a7fb873919d1a.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v3 1/8] mptcp: add mptcp_is_data_contiguous
 helper
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Date: Tue, 14 Sep 2021 17:32:11 +0200
In-Reply-To: <3610b34039bb8e73cd2eecdbc43d5a0cfbc5d2da.1631610729.git.geliangtang@gmail.com>
References: <cover.1631610729.git.geliangtang@gmail.com>
	 <3610b34039bb8e73cd2eecdbc43d5a0cfbc5d2da.1631610729.git.geliangtang@gmail.com>
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

On Tue, 2021-09-14 at 17:19 +0800, Geliang Tang wrote:
> This patch added a new member last_retrans_seq in the msk to track the
> last retransmitting sequence number.
> 
> Add a new helper named mptcp_is_data_contiguous() to check whether the
> data is contiguous on a subflow.
> 
> When a bad checksum is detected and a single contiguous subflow is in
> use, don't send RST + MP_FAIL, send data_ack + MP_FAIL instead.
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
>  net/mptcp/protocol.c |  3 +++
>  net/mptcp/protocol.h |  6 ++++++
>  net/mptcp/subflow.c  | 12 ++++++------
>  3 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index ff574d62073f..71a5427609a9 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2464,6 +2464,7 @@ static void __mptcp_retrans(struct sock *sk)
>  		dfrag->already_sent = max(dfrag->already_sent, info.sent);
>  		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
>  			 info.size_goal);
> +		msk-> = dfrag->data_seq;
>  	}
>  
>  	release_sock(ssk);
> @@ -2889,6 +2890,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
>  	msk->snd_una = msk->write_seq;
>  	msk->wnd_end = msk->snd_nxt + req->rsk_rcv_wnd;
>  	msk->setsockopt_seq = mptcp_sk(sk)->setsockopt_seq;
> +	msk->last_retrans_seq = subflow_req->idsn - 1;
>  
>  	if (mp_opt->suboptions & OPTIONS_MPTCP_MPC) {
>  		msk->can_ack = true;
> @@ -3145,6 +3147,7 @@ void mptcp_finish_connect(struct sock *ssk)
>  	WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
>  	WRITE_ONCE(msk->can_ack, 1);
>  	WRITE_ONCE(msk->snd_una, msk->write_seq);
> +	WRITE_ONCE(msk->last_retrans_seq, subflow->idsn - 1);
>  
>  	mptcp_pm_new_connection(msk, ssk, 0);
>  
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index d516fb6578cc..eb3473d128d4 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -227,6 +227,7 @@ struct mptcp_sock {
>  	u64		ack_seq;
>  	u64		rcv_wnd_sent;
>  	u64		rcv_data_fin_seq;
> +	u64		last_retrans_seq;
>  	int		wmem_reserved;
>  	struct sock	*last_snd;
>  	int		snd_burst;
> @@ -625,6 +626,11 @@ static inline bool mptcp_has_another_subflow(struct sock *ssk)
>  	return false;
>  }
>  
> +static inline bool mptcp_is_data_contiguous(struct mptcp_sock *msk)
> +{
> +	return before64(msk->last_retrans_seq, msk->snd_una);
> +}
> +
>  void __init mptcp_proto_init(void);
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>  int __init mptcp_proto_v6_init(void);
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 1de7ce883c37..b07803ed3053 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1166,15 +1166,15 @@ static bool subflow_check_data_avail(struct sock *ssk)
>  fallback:
>  	/* RFC 8684 section 3.7. */
>  	if (subflow->send_mp_fail) {
> -		if (mptcp_has_another_subflow(ssk)) {
> +		if (mptcp_has_another_subflow(ssk) || !mptcp_is_data_contiguous(msk)) {
> +			ssk->sk_err = EBADMSG;
> +			tcp_set_state(ssk, TCP_CLOSE);
> +			subflow->reset_transient = 0;
> +			subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
> +			tcp_send_active_reset(ssk, GFP_ATOMIC);
>  			while ((skb = skb_peek(&ssk->sk_receive_queue)))
>  				sk_eat_skb(ssk, skb);
>  		}
> -		ssk->sk_err = EBADMSG;
> -		tcp_set_state(ssk, TCP_CLOSE);
> -		subflow->reset_transient = 0;
> -		subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
> -		tcp_send_active_reset(ssk, GFP_ATOMIC);
>  		WRITE_ONCE(subflow->data_avail, 0);
>  		return true;
>  	}

As noted by Mat, to avoid wrap-around on 'last_retrans_seq', we also
need to updated it in mptcp_clean_una, something alike:

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index
bb8a2a231479..cc3534052227 100644
--- a/net/mptcp/protocol.c
+++
b/net/mptcp/protocol.c
@@ -1102,8 +1102,13 @@ static void
__mptcp_clean_una(struct sock *sk)
                msk->recovery =
false;
 
 out:
-       if (cleaned && tcp_under_memory_pressure(sk))
-     
          __mptcp_mem_reclaim_partial(sk);
+       if (cleaned) {
+      
         if (mptcp_is_data_contiguous(msk))
+                       msk-
>last_retrans_seq = msk->snd_una - 1;
+
+               if
(tcp_under_memory_pressure(sk))
+                       __mptcp_mem_recl
aim_partial(sk);
+       }
 
        if (snd_una == READ_ONCE(msk-
>snd_nxt) && !msk->recovery) {

/P

