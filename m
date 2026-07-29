Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895893A3809
	for <mptcp@lists.linux.dev>; Wed, 29 Jul 2026 07:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785311699; cv=none; b=P8omK1KhW9je5I0iemlyM0BG69rbiUPoXwhNuKaSBM31syL/XoJmP7IofrJP5SRfGD2HMkiiAnbenyn3g8xknFOMOiKFuKVP1WjxaJ2Jo+2wPgr6ZtypZBzSt2wM4kjhI0QCkG+zOp9Sfjat6NrGcCXSh8dgVSDbKfswAJhEiiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785311699; c=relaxed/simple;
	bh=tppcHbFgz+J1Snn1EwelMXSIaSlr4AQDEXrJ6ssJZ6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=acFhNkQ9TMC1EeLUE1PT+HkfIhIngl+eqeNZLhpLXd2uQBS0mYrIJOwCTTI6lEQKLQSAP164bPqZPXhnyt2u9rVs3Lnh4xellpXt+yiUy52/hcMYJhWfKLsJTPgmqSfI4Kc0IRr0psS4cq8Qtya1Zj3E7j0ufRRTwBufZlpoGPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CW4VJTcG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CW4VJTcG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785311696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7RD7G4ZJ8Up3ImtAeg8XqMB3kVX3zCmmmiV290nOLOc=;
	b=CW4VJTcGKLLhdDf76hWvA4HrRX03pGXQboIt8pVSEQqqoT64jDQxsQ8KKnq2UhFGGqF0kW
	+ar29vV+8U8mKmkpEo4EGZeo8IE95itg/r624Sr/3GhZcPBFdLUvT6L7SmtIS2p9zlGvFc
	QhUGztAFcG7nxZgpF4aNUrtcsSs2S2Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-YbUqC_j_OWGgTlS1q8Wr2A-1; Wed, 29 Jul 2026 03:54:55 -0400
X-MC-Unique: YbUqC_j_OWGgTlS1q8Wr2A-1
X-Mimecast-MFC-AGG-ID: YbUqC_j_OWGgTlS1q8Wr2A_1785311694
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-495495ad5ddso3859415e9.3
        for <mptcp@lists.linux.dev>; Wed, 29 Jul 2026 00:54:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785311694; x=1785916494;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7RD7G4ZJ8Up3ImtAeg8XqMB3kVX3zCmmmiV290nOLOc=;
        b=qHLIhh6qh3LXb+k9KiBmHIAayYpPcGou3ZhrxAA3E/r513lH+5nYZ8oXy2iz4rL1SF
         knGH+WrAYVTZzSXHyF0Dqueom0mWp3XOBeCkBProgDJz7N+1ac00HNRGL7ml0HpuxQZP
         WO0i5bopXzEF051EjbgOsBb2maRe7KpTPfjFyfLlukO7gteStUAsLBj3gvHH8zge4HQC
         T3TEx2rykapd/OSiblglPWPxzINzut3UoZTpH3oc1ySDl87Gn9QSp3gUJviK7nuQcA3k
         0mTpYcpD2KS39X9mzEQ7UkOlqBwF7TminOhV7sAeeMMSTuohoHhtG+ADYbPa7oIfXP5e
         0/kw==
X-Forwarded-Encrypted: i=1; AHgh+RrKR2P2AZsPaEaeG2OmLWQkXnW/C6StWimMIdNgLkH8NhmqVJJWAsCoXHu/PjvuQ16t0E8EAQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyKDhRjnSJYTltEtX63f4uyBH/LegmYWHiiENqCwueWyQqpmX3K
	ESRCqbGO/FwMgtKDp2A7GTZUZr1EZyarK4ilzxBK1Cdf9541+PRSH+1SM+LHUcZoGOW0frFPmrD
	Aun/Cw2lLvlzAp4WCEvFMmhEBIUeZyxryxXeyTegfriFdAJiuW8v8BUaA
X-Gm-Gg: AR+sD13ymx777ElQn6tMApooxjfsUdcdYxxNsCmdujmolRaFYfiFH8XCBfqnL9ZzU7Y
	kXvLkiFUEWeZEB+zSc84f700z5Q5Y/heQwvjOO5VMZqgGphCaMl/Vx3LuHG71llaj5ubU7daSfO
	eyIi+zITBKS7pPX8OJ1xmUCMU8lnaCXKtQJn353hiwnb6dbMw0n8FyHnFi8tBhdjo25X6SsgHX4
	bNa5R5nm34S7MCc9uH2HuXSLRziydrkgi/j3wW4agM4sTK6uv9TSt4KW7/sKiVu0Ux6n1hoBUGf
	oRhtzZ41/9emqEomge+CYY8yFpmYAfv02LvmYcJU7mjgBsBpaRkvgLg7Iho86F733Xxb311hYPE
	0RoJWaKG0rKnE1YFr4LIFLkwWM4ibgjf1hTvU0mVZ6ah0H2CTps4UsOI6eFvy4r9slBgFh4BV/t
	1auQ==
X-Received: by 2002:a05:600c:e548:20b0:495:7757:f467 with SMTP id 5b1f17b1804b1-496c657d052mr39793615e9.24.1785311693724;
        Wed, 29 Jul 2026 00:54:53 -0700 (PDT)
X-Received: by 2002:a05:600c:e548:20b0:495:7757:f467 with SMTP id 5b1f17b1804b1-496c657d052mr39793405e9.24.1785311693320;
        Wed, 29 Jul 2026 00:54:53 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49764d779e4sm35862595e9.6.2026.07.29.00.54.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 00:54:52 -0700 (PDT)
Message-ID: <186c41d1-f430-41dd-8427-d6733c5df4e0@redhat.com>
Date: Wed, 29 Jul 2026 09:54:51 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v11 3/4] mptcp: support MSG_ERRQUEUE on the
 parent socket
To: David Carlier <devnexen@gmail.com>, mptcp@lists.linux.dev
Cc: matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org
References: <20260531145955.322337-1-devnexen@gmail.com>
 <20260531145955.322337-4-devnexen@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260531145955.322337-4-devnexen@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CzqYTUm-bb2e1Aew70QASAraR0lpNPpM2iq2oG7IDk4_1785311694
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/31/26 4:59 PM, David Carlier wrote:
> Splice pending err skbs from each subflow's error queue onto the parent
> msk's error queue at error-report time, so poll() and recvmsg(MSG_ERRQUEUE)
> on the parent socket observe TX timestamps and MSG_ZEROCOPY completion
> notifications through the standard inet ABI.
> 
> The splice filters by SO_EE_ORIGIN: TIMESTAMPING / ZEROCOPY / LOCAL
> events forward to the parent because they are tied to user-handed data,
> not to a specific path; subflow-level ICMP errors are dropped because
> the legacy RECVERR ABI cannot meaningfully convey their per-subflow peer
> identity to single-path-aware userspace. Such events will be carried by
> a future MPTCP_RECERR channel.
> 
> Forwarded events all go through sock_queue_err_skb(), which re-homes
> skb->sk onto the parent and charges sk_rmem_alloc, so the parent's error
> queue stays bounded by sk_rcvbuf and is dropped under rmem pressure
> (sk_rmem_alloc + truesize >= sk_rcvbuf), matching tcp's sk_rcvbuf-gated
> tx-timestamp path and ip_icmp_error() / ipv6_icmp_error(). MPTCP itself
> never originates MSG_ZEROCOPY or OPT_ID tx-timestamp completions -- its
> data path copies into msk-owned pages and bypasses tcp_sendmsg_locked()
> -- so no subflow-relative ee_data sequence is ever forwarded to the
> parent. The MSG_ERRQUEUE branch of mptcp_recvmsg() forwards to
> inet_recv_error() directly, and poll() advertises EPOLLERR purely on the
> parent's sk_err / sk_error_queue, matching tcp_poll().
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>

Did I? I honestly can't recall anymore?!? (same for the previous patches).

This patch should possibly be applied before 1 && 2, to avoid sashiko
noise there. More relevantly, generally speaking its' better to
implement first the core infrastructure and only later expose it to the
user-space.

> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  net/mptcp/protocol.c | 63 +++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 54 insertions(+), 9 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index f1d74d4b28cf..42a355311c81 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -11,6 +11,7 @@
>  #include <linux/netdevice.h>
>  #include <linux/sched/signal.h>
>  #include <linux/atomic.h>
> +#include <linux/errqueue.h>
>  #include <net/aligned_data.h>
>  #include <net/rps.h>
>  #include <net/sock.h>
> @@ -894,21 +895,61 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
>  	return moved;
>  }
>  
> +static bool mptcp_errqueue_skb_forwardable(const struct sk_buff *skb)
> +{
> +	u8 origin = SKB_EXT_ERR(skb)->ee.ee_origin;
> +
> +	return origin == SO_EE_ORIGIN_LOCAL ||
> +		origin == SO_EE_ORIGIN_ZEROCOPY ||
> +		origin == SO_EE_ORIGIN_LOCAL;

Since SO_EE_ORIGIN_LOCAL and SO_EE_ORIGIN_ZEROCOPY can't yet be
generated, why including them here? If there are plans to support such
origins later, this nice helper could be updated at due time.

I *guess* that reducing its' scope...

> +}
> +
> +static bool __mptcp_subflow_splice_errqueue(struct sock *sk, struct sock *ssk)
> +{
> +	struct sk_buff *skb;
> +	bool moved = false;
> +
> +	while ((skb = skb_dequeue(&ssk->sk_error_queue))) {
> +		if (!mptcp_errqueue_skb_forwardable(skb)) {
> +			kfree_skb(skb);  /* path-specific (ICMP) — belongs in MPTCP_RECERR */
> +			continue;
> +		}
> +		/* sock_queue_err_skb() re-homes skb->sk onto the parent and
> +		 * charges its sk_rmem_alloc, so the error queue stays bounded by
> +		 * sk_rcvbuf; drop on overflow, matching tcp's tx-timestamp path.
> +		 * MPTCP never originates MSG_ZEROCOPY or OPT_ID tx-timestamp
> +		 * completions (the data path copies and bypasses
> +		 * tcp_sendmsg_locked()), so no subflow-relative ee_data sequence
> +		 * is ever forwarded.

... will allow dropping this rater verbose comment, which looks like
it's targeting mostly sashiko.

/P

