Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831123E8684
	for <mptcp@lists.linux.dev>; Mon, 27 Jul 2026 09:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785143270; cv=none; b=n9DR/sK85ou2C74e5izWGU0xmnvd66MbSrNE6ItXATzcQcupaw7tHGUSrHL//1BCayyRZ8THfLeLVrKCUJoP3hgncdjjY2vvipromPjavHUURbz0mJPQ6BRkDftcYTcbqHXcEsYSm+RHF3tv+b8jd6AZTm83yP0PS2LTUyxoOGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785143270; c=relaxed/simple;
	bh=LHTwQzb1gcagsKYDCbh4Uu3tI3NgNUQJ4rSjFOX1KyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fSEkOPCM5nrhWV9xCd/miG6dJvf+0E6PZKimePcrl922ZO5ex8MwD81/7Y1VPT9rAczHn4jqH37p6XCGvNkv9tSh/MmSQn5YDUjZ6L5d4MVBJJXgqwRsUHWapI6LAxT15wcNM/Lxbk7KQTJhONf5wMYNd3HqWmNCXKS8d2ENAWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O78KpHQl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O78KpHQl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785143267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rApJhbpK/b0CVV5ov/9vIdRIrElFvcSvZqbKQTS4MB8=;
	b=O78KpHQlDPeWp/ksmOnpkgT6ODOAN+3DSZT3T5f/zq92qOXse5YnKVyZzIWPceUW5UV9kU
	unUpOdxVqC9KsubOY4AWhKj7+ODSi/xcNFepk8LMHKNk6HPu+wTV5GJmVwBE+0l5EwBO1M
	yH01Cto8YWNhR1fPj5JASSsx/Ux/cGM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-yDpW0FsSMjyxjsWfs-sCQA-1; Mon, 27 Jul 2026 05:07:45 -0400
X-MC-Unique: yDpW0FsSMjyxjsWfs-sCQA-1
X-Mimecast-MFC-AGG-ID: yDpW0FsSMjyxjsWfs-sCQA_1785143265
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c16740eb587so192518066b.1
        for <mptcp@lists.linux.dev>; Mon, 27 Jul 2026 02:07:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785143264; x=1785748064;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rApJhbpK/b0CVV5ov/9vIdRIrElFvcSvZqbKQTS4MB8=;
        b=m0b23JKU+fFxAqK35JKfQE9jrwnXrSHI7lvXC/c1MpVMk6xOwHsJG6WWsBkmIJNV/R
         mxrHKq2XURKh3hFqrJEy+rn0gFW1lEpDmxvElmCfLGEjxbg8LyYUea3wbKFPMEixYQ07
         u4YbHcST+QvtgZJ038cllXFCoCU3FJT6cezgTtwdqLWa5iQEL+dfZY+qSSS+70bhI2f+
         Ijl5i6o9Z3Xy5oA/sLsuiELwOBAjFKMEAYJzYlOkVr3ifmKFS1aE6a6hkMOZq3UmmavE
         dJkrfu+27Ygx0vsS/vE8+valy44CatHI6fjZ+9Y1qZiDmU8m8xz9dW/YB2dcZ9OQuB48
         J5LA==
X-Forwarded-Encrypted: i=1; AHgh+RqK1aK2vtHBWRKQnXcb1pORjWExfAXfRD98IEJdpMVn7ccDEsjVxlLbPQkq4nlNQzLcTvRUPA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxU7zKEnF1IvGU8Lsqpg2tTMXjyRof4DYFK6TiPhopUuU1LK3Ng
	K3hgGD46hNrn6584eyVrgrVc0sE9a2syVAWrO/HBq1MFmcQsIWc45mPBlB2wm8j4kxhLTzU+1bg
	tuU8sk8QHbqOlujGLTFlA05XS5HS1BBdogEF6C8EliD7bbQhUEPCTV4N+
X-Gm-Gg: AR+sD133Q62NPzJ3LJACdWqkyv+ZE3qnP23NXQoz0XCAwaNPwVetMDhrDZcKMQgRKdg
	DqHEUCqCPoK4ThJGlrEjE0IxCHzvAEDaBwYTMk5rERLX/bR+PLWCHY2haYMliqAKaI+QlR+pXDv
	LlRRuH3Mikl4IzJkYFui6/e40F+LK9fbeAbGkh2Y2t2bH0qYpaOCoYaZdSH9cvPNhmMJDgPk1cc
	xQXMQety8cFQ090A5luQFviml+0qHy6CLZLLH/5cGQW3IVtzkf5m0TueNLBXiyHLPfeggEYCcIc
	SbVGDCWrCGVHnox6K0XD2KUKYr7NQ4KoLOK4KZ1/Fc/QqV4+GUbhaJO4dJ7Lts5GrqO6VNdpsmy
	SRGA7zjH6ZbxzxoN1aS8djaTsll+8YaS8ABWFUN78bfODJzICPdkqnqoL3c8jlzW1e/OkYH6Bpc
	GOfA==
X-Received: by 2002:a17:906:9f85:b0:c15:a1e8:c141 with SMTP id a640c23a62f3a-c1f1f032c7amr381694666b.30.1785143264453;
        Mon, 27 Jul 2026 02:07:44 -0700 (PDT)
X-Received: by 2002:a17:906:9f85:b0:c15:a1e8:c141 with SMTP id a640c23a62f3a-c1f1f032c7amr381693566b.30.1785143263925;
        Mon, 27 Jul 2026 02:07:43 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32a78260sm601879866b.6.2026.07.27.02.07.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 02:07:43 -0700 (PDT)
Message-ID: <90370236-b773-4419-b42e-eab6a3a9385b@redhat.com>
Date: Mon, 27 Jul 2026 11:07:41 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/5] mptcp: explicitly drop over memory limits
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260724-net-next-mptcp-oooq-pruning-v1-0-5dd4dec63a54@kernel.org>
 <20260724-net-next-mptcp-oooq-pruning-v1-3-5dd4dec63a54@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260724-net-next-mptcp-oooq-pruning-v1-3-5dd4dec63a54@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VnluVA_CSgEHZueTkpePTnKN-_4ZZ4PXk2mykAd2vsQ_1785143265
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/24/26 4:02 PM, Matthieu Baerts (NGI0) wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> 
> Currently the enforcement of the rcvbuf constraint is implemented
> when moving the skbs into the msk receive or OoO queue, keeping the
> incoming skbs in the subflow queue when over limits.
> 
> Under significant memory pressure the above can cause permanent data
> transfer stalls, as the skb needed to make forward progress can be
> stuck in a subflow queue.
> 
> Over memory limits, drop the incoming skb, relying on MPTCP-level
> retransmissions.
> 
> Note that fallback socket must perform the limit before the skb reaches
> the subflow-level queue, as dropping an in-sequence already acked skb
> would break the stream.
> 
> This is not a complete fix for the stall issue, as the drop strategy
> needs refinements that will come in the next patches.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/mib.c      |  2 ++
>  net/mptcp/mib.h      |  2 ++
>  net/mptcp/options.c  | 28 +++++++++++++++++++++++++---
>  net/mptcp/protocol.c | 31 +++++++++++++++++++++++--------
>  4 files changed, 52 insertions(+), 11 deletions(-)
> 
> diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
> index f23fda0c55a7..ef65e2df709f 100644
> --- a/net/mptcp/mib.c
> +++ b/net/mptcp/mib.c
> @@ -85,6 +85,8 @@ static const struct snmp_mib mptcp_snmp_list[] = {
>  	SNMP_MIB_ITEM("SimultConnectFallback", MPTCP_MIB_SIMULTCONNFALLBACK),
>  	SNMP_MIB_ITEM("FallbackFailed", MPTCP_MIB_FALLBACKFAILED),
>  	SNMP_MIB_ITEM("WinProbe", MPTCP_MIB_WINPROBE),
> +	SNMP_MIB_ITEM("BacklogDrop", MPTCP_MIB_BACKLOGDROP),
> +	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
>  };
>  
>  /* mptcp_mib_alloc - allocate percpu mib counters
> diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
> index 812218b5ed2b..c84eb853d499 100644
> --- a/net/mptcp/mib.h
> +++ b/net/mptcp/mib.h
> @@ -88,6 +88,8 @@ enum linux_mptcp_mib_field {
>  	MPTCP_MIB_SIMULTCONNFALLBACK,	/* Simultaneous connect */
>  	MPTCP_MIB_FALLBACKFAILED,	/* Can't fallback due to msk status */
>  	MPTCP_MIB_WINPROBE,		/* MPTCP-level zero window probe */
> +	MPTCP_MIB_BACKLOGDROP,		/* Backlog over memory limit */
> +	MPTCP_MIB_RCVPRUNED,		/* Dropped due to memory constrains */
>  	__MPTCP_MIB_MAX
>  };
>  
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index c664023d37ba..7b954ef78672 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1127,8 +1127,30 @@ static bool add_addr_hmac_valid(struct mptcp_sock *msk,
>  	return hmac == mp_opt->ahmac;
>  }
>  
> -/* Return false in case of error (or subflow has been reset),
> - * else return true.
> +static bool mptcp_over_limit(struct sock *sk, struct sock *ssk,
> +			     const struct sk_buff *skb)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	u64 mem = sk_rmem_alloc_get(sk);
> +
> +	mem += READ_ONCE(msk->backlog_len);
> +	if (likely(mem <= READ_ONCE(sk->sk_rcvbuf)))
> +		return false;
> +
> +	/* Avoid silently dropping pure acks, fin or zero win probes. */
> +	if (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq ||
> +	    TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN ||
> +	    !after(TCP_SKB_CB(skb)->end_seq, tcp_sk(ssk)->rcv_nxt))
> +		return false;
> +
> +	/* Dropped due to memory constraints, schedule an ack. */
> +	inet_csk(ssk)->icsk_ack.pending |= ICSK_ACK_NOMEM | ICSK_ACK_NOW;
> +	inet_csk_schedule_ack(ssk);
> +	return true;
> +}
> +
> +/* Return false when the caller must drop the packet, i.e. in case of error,
> + * subflow has been reset, or over memory limits.
>   */
>  bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
>  {
> @@ -1154,7 +1176,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
>  
>  		__mptcp_data_acked(subflow->conn);
>  		mptcp_data_unlock(subflow->conn);
> -		return true;
> +		return !mptcp_over_limit(subflow->conn, sk, skb);
>  	}
>  
>  	mptcp_get_options(skb, &mp_opt);
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 72b1fa3ca71c..5f7d8340a3d9 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -381,6 +381,16 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
>  
>  	mptcp_borrow_fwdmem(sk, skb);
>  
> +	/* Can't drop packets for fallback socket this late, or the stream
> +	 * will break.
> +	 */
> +	if (unlikely(sk_rmem_alloc_get(sk) > READ_ONCE(sk->sk_rcvbuf)) &&
> +	    !__mptcp_check_fallback(msk)) {
> +		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
> +		mptcp_drop(sk, skb);

Here sashiko fears a possible forward-allocated memory leak. That is
sort of antinomy, as forward-allocated memory will be used for the next
skb(s) and excess fwd allocated memory will be still freed after the
next skb(s) processing or at sk close time. There is no real permanent leak.

We could release additionally allocated fwd memory in the error path as
a follow-up.

/P

