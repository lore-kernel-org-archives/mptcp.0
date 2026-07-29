Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E2647A0BA
	for <mptcp@lists.linux.dev>; Wed, 29 Jul 2026 11:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785325846; cv=none; b=VofyI7dqeUof79xbFt5iymO3k4q1cAB5USMVxRGPJFsx4zv5KoX8C/ubi7b6xInacYUY+IZ9DOuGbB/i6IF29D9EjmBaKO4qMZi+Zs6jW7h2squlfXMMJ1v3YThXQ9iQgdUux/LHnKIrlbewFAZkSOMf8qV8SxDkzsBeI5d+1co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785325846; c=relaxed/simple;
	bh=OZg4v1OL8lkbbT4rynpcKQ5ePvV99OJ6XxY4nvbx8IY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tjOeSsF8H91LiH06IOMDHZJzPmlogsC7cJqoBYHdJrijECBWwDS2N4HeydnDAMFpomMVgU+IDI3Rxgh8vmhA2QmJrSGjRBe2opFh41hFljKKMZyr6uAlRsLlnNum900e7fJs0Tt7GjNSZLdGJbUdbFAJHh5/BeKQlPV/sf+FDfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fgk/UdCc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fgk/UdCc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0071F00A3A;
	Wed, 29 Jul 2026 11:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785325844;
	bh=h8EHksasKKTJTxOXF8E4gK+SUzlozdilKTK8jFJE5cQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Fgk/UdCcI0d5rf8L1FJW4gDXuGWE6KL8IU1BZsxfq5H8Mo8tBdUqCswk6udkP5iWt
	 cWzycmF7MeqSCxtv3LKljfQ5BNFVTrESTpisDI9ecOnuuS3fM2R0PBL/sprMS+ryD/
	 5UkOA3H1ozb9oCsmYfITZrFn42k+g/fs+cfoD3SZNnx0A11E/3T3M2pTwG/s+7MdVG
	 zwC+H0I8LldlOngX6lusTW/cTH5MCibaR7MG3EaNGjGJY1TfGogg87+84Mr61IraZ4
	 t7it9GKkRz0IxNZmVOWFOSgrqTE7pvXspnuEUI035eql5fpeDbJRJHhIyKAxUAyIvJ
	 RJGhH6Hsvl0nA==
Message-ID: <70fa5aff-40c0-4ca5-8a29-4e57489d3637@kernel.org>
Date: Wed, 29 Jul 2026 13:50:42 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 3/3] DO-NOT-MERGE: mptcp: sched: penalise
 counters
Content-Language: fr
To: Shardul Bankar <shardul.b@mpiricsoftware.com>
Cc: shardulsb08@gmail.com, MPTCP Linux <mptcp@lists.linux.dev>
References: <20260726-mptcp_penalise_send-v1-0-84485e0e995b@mpiricsoftware.com>
 <20260726-mptcp_penalise_send-v1-3-84485e0e995b@mpiricsoftware.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260726-mptcp_penalise_send-v1-3-84485e0e995b@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Shardul,

On 26/07/2026 07:55, Shardul Bankar wrote:
> Instrumentation for validating the two preceding patches; not for merge.
> 
> Adds two MPTcpExt SNMP counters:
> - CwndPenalized: times a subflow cwnd was actually halved;
> - PenalCandidate: times the rate trigger picked a slow subflow.

I think at least the first counter is interesting, probably the second
one as well, no?

Generally, if you need counters during the development, they might be
needed to debug issues. But here with the scheduler, maybe the tracing
are better. Did you use "trace_mptcp_subflow_get_send"?

> Together they separate "the guard held the penalty back" (PenalCandidate
> high, CwndPenalized ~0) from "the trigger never fired" (both ~0), which is
> what the receive-window-limited case needs to be read correctly.
> 
> Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
> ---
>  net/mptcp/mib.c      | 2 ++
>  net/mptcp/mib.h      | 2 ++
>  net/mptcp/protocol.c | 8 ++++++++
>  3 files changed, 12 insertions(+)
> 
> diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
> index d9bd4f4afcc0..1299613e183b 100644
> --- a/net/mptcp/mib.c
> +++ b/net/mptcp/mib.c
> @@ -88,6 +88,8 @@ static const struct snmp_mib mptcp_snmp_list[] = {
>  	SNMP_MIB_ITEM("BacklogDrop", MPTCP_MIB_BACKLOGDROP),
>  	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
>  	SNMP_MIB_ITEM("OfoPruned", MPTCP_MIB_OFO_PRUNED),
> +	SNMP_MIB_ITEM("CwndPenalized", MPTCP_MIB_CWNDPENALIZED),
> +	SNMP_MIB_ITEM("PenalCandidate", MPTCP_MIB_PENALCAND),
>  };
>  
>  /* mptcp_mib_alloc - allocate percpu mib counters
> diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
> index 18f35f7e0a2d..93b3a7e9584f 100644
> --- a/net/mptcp/mib.h
> +++ b/net/mptcp/mib.h
> @@ -91,6 +91,8 @@ enum linux_mptcp_mib_field {
>  	MPTCP_MIB_BACKLOGDROP,		/* Backlog over memory limit */
>  	MPTCP_MIB_RCVPRUNED,		/* Dropped due to memory constrains */
>  	MPTCP_MIB_OFO_PRUNED,		/* MPTCP-level OoO queue pruned */
> +	MPTCP_MIB_CWNDPENALIZED,	/* DEBUG: subflow cwnd halved by the scheduler (#345) */
> +	MPTCP_MIB_PENALCAND,		/* DEBUG: picker chose a slow (low-rate) subflow */
>  	__MPTCP_MIB_MAX
>  };
>  
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 7cbc5aa17e22..80866f09831a 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1607,6 +1607,7 @@ static void mptcp_penalise_cwnd(struct sock *ssk)
>  	subflow->penalise = false;
>  	subflow->last_penalise = tcp_jiffies32;
>  	tcp_snd_cwnd_set(tp, max_t(u32, cwnd >> 1, 2));
> +	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_CWNDPENALIZED);
>  	if (cwnd >= tp->snd_ssthresh)
>  		tp->snd_ssthresh = max_t(u32, tp->snd_ssthresh >> 1, 2);
>  }
> @@ -1694,6 +1695,13 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
>  	 * once per RTT.
>  	 */
>  	subflow = mptcp_subflow_ctx(ssk);
> +	/* DEBUG: count how often the trigger picks a slow path, so a gated-off
> +	 * run (PenalCandidate high, CwndPenalized 0) is distinguishable from one
> +	 * where the trigger never fired.
> +	 */
> +	if (fastest && ssk != fastest &&
> +	    (u64)subflow->avg_pacing_rate * MPTCP_PENALISE_RATE_RATIO < max_pace)

If this counter is interesting, you could have a variable for penal_cand
and use it below.

> +		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_PENALCAND);
>  	subflow->penalise = fastest && ssk != fastest &&
>  			    (u64)subflow->avg_pacing_rate * MPTCP_PENALISE_RATE_RATIO < max_pace &&
>  			    inet_csk(ssk)->icsk_ca_state == TCP_CA_Open &&
> 

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

