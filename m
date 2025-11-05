Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B86A21C9EA
	for <mptcp@lists.linux.dev>; Wed,  5 Nov 2025 00:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762302259; cv=none; b=tYI+KEBPrnUc8zRuYu73yhzdmJ7tChXFyRWLwi2o0f4HXjMhTUkSKRysn7dtrl+y8jeEWGnOtmRlv2LF2OnGl6KSie13oSAjX17/y/2FSkJUEeNuynmiuJP9hGClG6xHND/T/rc8NnEh430UVe3+L+z7Z7con1q8BRV8jHDf5ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762302259; c=relaxed/simple;
	bh=EJiLXB0wATlRUvSBKJaptZ86ve8debCZfKT94/dGh2w=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=h+7cnwsm6cvTqzTCEteGMSyvTUxuWauhz89jiZoHjicyxzOn2MnS1yLMF1mQD9HBgAckqx9LercXlv9ZL6OjbY026cEIzzhvqgmTCg+gc8g3z4z/5a+DyFeHWJh+CyBgv4qP8SfvkyKxNNug8Lxgvic/T05m8zjQr7JOPeWM/e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqcbrB+4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqcbrB+4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87875C4CEF7;
	Wed,  5 Nov 2025 00:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762302257;
	bh=EJiLXB0wATlRUvSBKJaptZ86ve8debCZfKT94/dGh2w=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=bqcbrB+44F38riBjXTm8Q0WPhdrwkxCLmqlmXVQOlmCplD6ZR3irgXqxAuhJ63JWu
	 HGm7WN0KoyU2ts9pp4S9LQsyDGl5CbRh8piZW7CimZP4SxuBbkw/QoRWiN0Y0COq3s
	 wfE8W3tI7hPJoDp4XgrWkedBRtxT/wf+1Dyro+9Cca06JYjAt32G9zVahi4ybZABdh
	 H01TC9XYafeLDqfX1uJfpwJlNALWVwu6O8fu/apwzRLCk2bp3wkoRCZFZ4cpBgLXv3
	 3uC2xsCQeO4s1LQpr0hSN4X2gse0+HCzGxNroT+twqSOEJAXeJBQkK/rtNQkajmzqv
	 7AOxtJ/hYJ0zw==
Date: Tue, 4 Nov 2025 16:24:16 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v2 mptcp-next 1/7] trace: mptcp: add mptcp_rcvbuf_grow
 tracepoint
In-Reply-To: <5b1042b7f934b9a749dee435b7494a414adb57ce.1762292476.git.pabeni@redhat.com>
Message-ID: <076e1386-240e-f23e-f95a-876e7284a346@kernel.org>
References: <cover.1762292476.git.pabeni@redhat.com> <5b1042b7f934b9a749dee435b7494a414adb57ce.1762292476.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 4 Nov 2025, Paolo Abeni wrote:

> Similar to tcp, provide a new tracepoint to better understand
> mptcp_rcv_space_adjust() behavior, which presents many artifacts.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> include/trace/events/mptcp.h | 74 ++++++++++++++++++++++++++++++++++++
> net/mptcp/protocol.c         |  3 ++
> 2 files changed, 77 insertions(+)
>
> diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
> index 085b749cdd97..71fd6d33f48b 100644
> --- a/include/trace/events/mptcp.h
> +++ b/include/trace/events/mptcp.h
> @@ -178,6 +178,80 @@ TRACE_EVENT(subflow_check_data_avail,
> 		  __entry->skb)
> );
>
> +#include <trace/events/net_probe_common.h>
> +
> +TRACE_EVENT(mptcp_rcvbuf_grow,
> +
> +	TP_PROTO(struct sock *sk, int time),
> +
> +	TP_ARGS(sk, time),
> +
> +	TP_STRUCT__entry(
> +		__field(int, time)
> +		__field(__u32, rtt_us)
> +		__field(__u32, copied)
> +		__field(__u32, inq)
> +		__field(__u32, space)
> +		__field(__u32, ooo_space)
> +		__field(__u32, rcvbuf)
> +		__field(__u32, rcv_wnd)
> +		__field(__u8, scaling_ratio)
> +		__field(__u16, sport)
> +		__field(__u16, dport)
> +		__field(__u16, family)
> +		__array(__u8, saddr, 4)
> +		__array(__u8, daddr, 4)
> +		__array(__u8, saddr_v6, 16)
> +		__array(__u8, daddr_v6, 16)
> +		__field(const void *, skaddr)
> +	),
> +
> +	TP_fast_assign(
> +		struct mptcp_sock *msk = mptcp_sk(sk);
> +		struct inet_sock *inet = inet_sk(sk);
> +		__be32 *p32;
> +
> +		__entry->time = time;
> +		__entry->rtt_us = msk->rcvq_space.rtt_us >> 3;
> +		__entry->copied = msk->rcvq_space.copied;
> +		__entry->inq = mptcp_inq_hint(sk);
> +		__entry->space = msk->rcvq_space.space;
> +		__entry->ooo_space = RB_EMPTY_ROOT(&msk->out_of_order_queue) ? 0 :
> +				     MPTCP_SKB_CB(msk->ooo_last_skb)->end_seq -
> +				     msk->ack_seq;
> +
> +		__entry->rcvbuf = sk->sk_rcvbuf;
> +		__entry->rcv_wnd = atomic64_read(&msk->rcv_wnd_sent) -  msk->ack_seq;
> +		__entry->scaling_ratio = msk->scaling_ratio;
> +		__entry->sport = ntohs(inet->inet_sport);
> +		__entry->dport = ntohs(inet->inet_dport);
> +		__entry->family = sk->sk_family;

Hi Paolo -

__entry->family isn't referenced in the TP_printk() below.

Other than that, the series is looking good. I still need to work on 
understanding the last 2 patches, even with the commit messages & comments 
the behavioral changes/consequences aren't clear to me yet.

- Mat

> +
> +		p32 = (__be32 *) __entry->saddr;
> +		*p32 = inet->inet_saddr;
> +
> +		p32 = (__be32 *) __entry->daddr;
> +		*p32 = inet->inet_daddr;
> +
> +		TP_STORE_ADDRS(__entry, inet->inet_saddr, inet->inet_daddr,
> +			       sk->sk_v6_rcv_saddr, sk->sk_v6_daddr);
> +
> +		__entry->skaddr = sk;
> +	),
> +
> +	TP_printk("time=%u rtt_us=%u copied=%u inq=%u space=%u ooo=%u scaling_ratio=%u rcvbuf=%u "
> +		  "rcv_wnd=%u "
> +		  "sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 "
> +		  "saddrv6=%pI6c daddrv6=%pI6c skaddr=%p",
> +		  __entry->time, __entry->rtt_us, __entry->copied,
> +		  __entry->inq, __entry->space, __entry->ooo_space,
> +		  __entry->scaling_ratio, __entry->rcvbuf,
> +		  __entry->rcv_wnd,
> +		  __entry->sport, __entry->dport,
> +		  __entry->saddr, __entry->daddr,
> +		  __entry->saddr_v6, __entry->daddr_v6,
> +		  __entry->skaddr)
> +);
> #endif /* _TRACE_MPTCP_H */
>
> /* This part must be outside protection */
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 01114456dec6..443406bc4a54 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -28,6 +28,8 @@
> #include "protocol.h"
> #include "mib.h"
>
> +static unsigned int mptcp_inq_hint(const struct sock *sk);
> +
> #define CREATE_TRACE_POINTS
> #include <trace/events/mptcp.h>
>
> @@ -2101,6 +2103,7 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
> 	if (msk->rcvq_space.copied <= msk->rcvq_space.space)
> 		goto new_measure;
>
> +	trace_mptcp_rcvbuf_grow(sk, time);
> 	if (mptcp_rcvbuf_grow(sk, msk->rcvq_space.copied)) {
> 		/* Make subflows follow along.  If we do not do this, we
> 		 * get drops at subflow level if skbs can't be moved to
> -- 
> 2.51.0
>
>
>
