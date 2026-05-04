Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAF03E0233
	for <mptcp@lists.linux.dev>; Mon,  4 May 2026 16:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777912748; cv=none; b=BbatBocg1TavncW01/fpBj9CDupcUtZ25Q/R9jh0ce0dMz9Ld2N33GuS31CVx7383ZQmsEfSoRzFEQm21lOiXLp02lukGlHmGOwfD7JH9+wcarN8G+shGu9sAwJDDvxkDF9yzUX2/MvDn2CfX28+/DQ40JFqczk8lW9PQ7EFiPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777912748; c=relaxed/simple;
	bh=lvCureQ3Zf4HHZRtDaWlFCvPI6QU6iXYHdSW+X0vJN0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cK5jcDZS3KzyolhESunA3PktOsBtsArFjx84wYuC4WTyhEcw8FLG841XAcMIgaZbd8Rhwy21JorpDa7oXRGKIB/as0/mSqLdR+15W6uxpVJgEZ1E0UyWwCVLLL21hSY74I/aDJz3f3rB+08AGRH5r4kgzuNsPDOzAlkAI2AENYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KmwTjAV6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KmwTjAV6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777912745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=53vNZKkoxg+5LuhSbYGACr7t+MtiBk53dLO9FNa6Zcs=;
	b=KmwTjAV6EGb0h3n76qK4YSJiEtMPRz7OYU2NbyTyHiARE0X32rwSv2l/Jflq9k4X2l9uy7
	5lZnygmrxjWAPm/M7r3uU37+6RS6vmUE19KkOQjH50/f2qg27f3cwce7LqrRlRBbBdh863
	zRnzvpD+OoXJH2yF8nLYzVqUpDvp920=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-jE9PoGg9NX-S2ZoxOCsnYA-1; Mon, 04 May 2026 12:39:04 -0400
X-MC-Unique: jE9PoGg9NX-S2ZoxOCsnYA-1
X-Mimecast-MFC-AGG-ID: jE9PoGg9NX-S2ZoxOCsnYA_1777912743
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43fe791a398so3972096f8f.0
        for <mptcp@lists.linux.dev>; Mon, 04 May 2026 09:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777912743; x=1778517543;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=53vNZKkoxg+5LuhSbYGACr7t+MtiBk53dLO9FNa6Zcs=;
        b=eHjcPIU3JmJHTdoMb+sg0/ApEn9uhlBNqruMq2qjwyBWfj8+b0Nlgo6CvY85GzdO65
         8gwHyVG6HwjpAFZmgqxZzyxFutfH+zQ8/cib7/BV2PGf745LkzOZW5BHX8Kw+DKK2mFH
         vX6Tleu/I+CAq1HHFNMXlS4jF+Hj49w6pMuEJR0eF+z9EkM+Os1YSGoU7ZaWFbsRXGzP
         02VaWtLqQa58eee6Kya9plxAiCNuI3iWf78fMT7G29mzmwx4Uefje1KKjFHnJR04BRNf
         jAgXHbyTeJjcU+KrcPCk+jOd6BUBNSxM2qnxuopGnCqp5sndwB7UceJKDbjTgq8ZhKD3
         m6Sw==
X-Forwarded-Encrypted: i=1; AFNElJ/D9CkYWe46Nqqyyx6tK7L65+kodmm3v1kotAoFxFaw4Y/4aSfGRvitOQXehSe6gPRkz5gBEA==@lists.linux.dev
X-Gm-Message-State: AOJu0YznTyAp9+TPgqiZtR1VVAedMmDyc0IRkEPXG1wJhno+2AK4/7iX
	AK+o8bmHlg3D6Rqm2jV/GZWiVAqpdC0fGZCNJ5eFZgxhfcX3aKaqI/CpslLNLfrWV7fGkvsxb0y
	V9iHWctClpPpRc6MtgQkKs3m3bE0ZeHdf5fVyKiVrLRObcQPDMgv4AGQ3
X-Gm-Gg: AeBDievRCbPKBCFQLiZLNXQmPUf5/HoomBP44YrEQ09bT53+mzp/NE6RzFy2EfOmdan
	C94jt/Y3jBgvIk/z3CnuKGPkypufhQnZMBvg3px7L0cOEaeEdPyZjJt6mnZ+rVcgyEV+5kA1nLr
	kY+By7AAkPGlHRKc863ejIAw8fjx0KlW3iSOM87Y7dMd/BlFrTVxJSNRCL7xorWB6X+mHkvWFIi
	4CeC7mofP7khYZ3kJ6q8cmKWZPWIuzsA26Qrne8lyI3ak+Fhg94sQYO6Z+a/qsQpnXbfmMUqlJu
	vXfG2saWWVevDRY+tmrIvcwOlxEcrprOvQ+LpsJu82OPFExmUKtHnXeJNjP6STWpKbI+xEBcU8r
	B8Q/7Ceiuz/0BT6i9UX2DbADtmHyBrsogFlI/tJsg7Ruw4jXffo2GCNctGmTY+nUZCg==
X-Received: by 2002:a05:6000:1acf:b0:43f:ea25:c965 with SMTP id ffacd0b85a97d-44bb6205eb6mr17025756f8f.32.1777912743106;
        Mon, 04 May 2026 09:39:03 -0700 (PDT)
X-Received: by 2002:a05:6000:1acf:b0:43f:ea25:c965 with SMTP id ffacd0b85a97d-44bb6205eb6mr17025712f8f.32.1777912742515;
        Mon, 04 May 2026 09:39:02 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a986aab44sm28253885f8f.29.2026.05.04.09.39.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 09:39:02 -0700 (PDT)
Message-ID: <0c361889-533f-4467-b908-0774dc23f08d@redhat.com>
Date: Mon, 4 May 2026 18:39:01 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 mptcp-next 06/10] tcp: expose the
 tcp_collapse_ofo_queue() helper to mptcp usage, too
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Geliang Tang <geliang@kernel.org>, gang.yan@linux.dev,
 mptcp@lists.linux.dev
References: <cover.1777908248.git.pabeni@redhat.com>
 <eec217c214e8db54355c7708b328c34a92c2bdcb.1777908248.git.pabeni@redhat.com>
In-Reply-To: <eec217c214e8db54355c7708b328c34a92c2bdcb.1777908248.git.pabeni@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 52aGaewN3MoB8suICoIbixu_HN7A5YQ4VmJCoMJ3AEU_1777912743
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Eric,

I'd like to re-use some existing TCP helpers (tcp_collapse_ofo_queue()
and tcp_collapse()) in the MPTCP code, to avoid duplicating the non
trivial logic there.

The idea is that the 'struct sock *' in such helpers could be either a
tcp_sock* or an mptcp_sock *, and the processed skbs could be sitting in
TCP level queues or MPTCP ones.

That poses some hard constraints on the sk fields that the helpers can
access. To make them clear I'm renaming such helpers using an 'xtcp_'
prefix.

The full patch touching the TCP code is below. For completeness,  the
whole series is available here:

https://lore.kernel.org/mptcp/cover.1777908248.git.pabeni@redhat.com/T/#me6eda13ec2c70fbb400b6223aa2d07a4fd3bf865

but I guess most of it is not interesting for you/from TCP perspective.

The MPTCP bits are not yet finalized, but I'd like to know it you would
consider this approach doable or a complete no-go.

Thanks,

Paolo
---
On 5/4/26 5:40 PM, Paolo Abeni wrote:
> The end goal is to avoid duplicating the quite untrivial strategy at MPTCP
> level.
> 
> After the previous patch, the mentioned helpers could process skbs standing
> in MPTCP-level queues without any CB-related adaptation.
> 
> The only additional adjustment needed is explicitly providing the OoO queue
> reference, to cope with different sk layout.
> 
> Additionally rename the helper to clearly document its hybrid nature and
> let it return the number of collapsed skbs, to allow proper accounting from
> the future MPTCP caller.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> rfc -> v1:
>  - fix arg typo
> 
> Note:
>  - this will need a significant amount of testing at the TCP level and
>    explicit approval from Eric, which I can't guess if we can hope.
> ---
>  include/net/tcp.h    |  8 +++++++
>  net/ipv4/tcp_input.c | 55 ++++++++++++++++++++++++++++----------------
>  2 files changed, 43 insertions(+), 20 deletions(-)
> 
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 6156d1d068e1..34a96f0bcf0a 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1828,6 +1828,14 @@ extern void tcp_openreq_init_rwin(struct request_sock *req,
>  
>  void tcp_enter_memory_pressure(struct sock *sk);
>  void tcp_leave_memory_pressure(struct sock *sk);
> +unsigned int xtcp_collapse(struct sock *sk, struct sk_buff_head *list,
> +			   struct rb_root *root, struct sk_buff *head,
> +			   struct sk_buff *tail, u32 start, u32 end,
> +			   u8 scaling_ratio);
> +unsigned int xtcp_collapse_ofo_queue(struct sock *sk,
> +				     struct rb_root *out_of_order_queue,
> +				     struct sk_buff **ooo_last_skb,
> +				     u8 scaling_ratio);
>  
>  static inline int keepalive_intvl_when(const struct tcp_sock *tp)
>  {
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 7171442c3ed7..8417785fa48f 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5725,16 +5725,22 @@ static struct sk_buff *tcp_collapse_one(struct sock *sk, struct sk_buff *skb,
>  /* Collapse contiguous sequence of skbs head..tail with
>   * sequence numbers start..end.
>   *
> + * sk can be either a TCP or an MPTCP socket.
> + *
>   * If tail is NULL, this means until the end of the queue.
>   *
>   * Segments with FIN/SYN are not collapsed (only because this
>   * simplifies code)
> + *
> + * Returns the number of collapsed skbs.
>   */
> -static void
> -tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
> -	     struct sk_buff *head, struct sk_buff *tail, u32 start, u32 end)
> +unsigned int
> +xtcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
> +	      struct sk_buff *head, struct sk_buff *tail, u32 start, u32 end,
> +	      u8 scaling_ratio)
>  {
>  	struct sk_buff *skb = head, *n;
> +	unsigned int collapsed = 0;
>  	struct sk_buff_head tmp;
>  	bool end_of_skbs;
>  
> @@ -5750,6 +5756,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
>  
>  		/* No new bits? It is possible on ofo queue. */
>  		if (!before(start, TCP_SKB_CB(skb)->end_seq)) {
> +			collapsed++;
>  			skb = tcp_collapse_one(sk, skb, list, root);
>  			if (!skb)
>  				break;
> @@ -5762,7 +5769,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
>  		 *   overlaps to the next one and mptcp allow collapsing.
>  		 */
>  		if (!(TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN)) &&
> -		    (tcp_win_from_space(sk, skb->truesize) > skb->len ||
> +		    (__tcp_win_from_space(scaling_ratio, skb->truesize) > skb->len ||
>  		     before(TCP_SKB_CB(skb)->seq, start))) {
>  			end_of_skbs = false;
>  			break;
> @@ -5782,7 +5789,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
>  	if (end_of_skbs ||
>  	    (TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN)) ||
>  	    !skb_frags_readable(skb))
> -		return;
> +		return collapsed;
>  
>  	__skb_queue_head_init(&tmp);
>  
> @@ -5819,6 +5826,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
>  				start += size;
>  			}
>  			if (!before(start, TCP_SKB_CB(skb)->end_seq)) {
> +				collapsed++;
>  				skb = tcp_collapse_one(sk, skb, list, root);
>  				if (!skb ||
>  				    skb == tail ||
> @@ -5832,23 +5840,26 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
>  end:
>  	skb_queue_walk_safe(&tmp, skb, n)
>  		tcp_rbtree_insert(root, skb);
> +	return collapsed;
>  }
>  
>  /* Collapse ofo queue. Algorithm: select contiguous sequence of skbs
> - * and tcp_collapse() them until all the queue is collapsed.
> + * and xtcp_collapse() them until all the queue is collapsed.
>   */
> -static void tcp_collapse_ofo_queue(struct sock *sk)
> +unsigned int xtcp_collapse_ofo_queue(struct sock *sk,
> +				     struct rb_root *ooo_queue,
> +				     struct sk_buff **ooo_last_skb,
> +				     u8 scaling_ratio)
>  {
> -	struct tcp_sock *tp = tcp_sk(sk);
> -	u32 range_truesize, sum_tiny = 0;
> +	u32 range_truesize, sum_tiny = 0, collapsed = 0;
>  	struct sk_buff *skb, *head;
>  	u32 start, end;
>  
> -	skb = skb_rb_first(&tp->out_of_order_queue);
> +	skb = skb_rb_first(ooo_queue);
>  new_range:
>  	if (!skb) {
> -		tp->ooo_last_skb = skb_rb_last(&tp->out_of_order_queue);
> -		return;
> +		*ooo_last_skb = skb_rb_last(ooo_queue);
> +		return collapsed;
>  	}
>  	start = TCP_SKB_CB(skb)->seq;
>  	end = TCP_SKB_CB(skb)->end_seq;
> @@ -5866,12 +5877,13 @@ static void tcp_collapse_ofo_queue(struct sock *sk)
>  			/* Do not attempt collapsing tiny skbs */
>  			if (range_truesize != head->truesize ||
>  			    end - start >= SKB_WITH_OVERHEAD(PAGE_SIZE)) {
> -				tcp_collapse(sk, NULL, &tp->out_of_order_queue,
> -					     head, skb, start, end);
> +				collapsed += xtcp_collapse(sk, NULL, ooo_queue,
> +					      head, skb, start, end,
> +					      scaling_ratio);
>  			} else {
>  				sum_tiny += range_truesize;
>  				if (sum_tiny > sk->sk_rcvbuf >> 3)
> -					return;
> +					return collapsed;
>  			}
>  			goto new_range;
>  		}
> @@ -5882,6 +5894,7 @@ static void tcp_collapse_ofo_queue(struct sock *sk)
>  		if (after(TCP_SKB_CB(skb)->end_seq, end))
>  			end = TCP_SKB_CB(skb)->end_seq;
>  	}
> +	return collapsed;
>  }
>  
>  /*
> @@ -5969,12 +5982,14 @@ static int tcp_prune_queue(struct sock *sk, const struct sk_buff *in_skb)
>  	if (tcp_can_ingest(sk, in_skb))
>  		return 0;
>  
> -	tcp_collapse_ofo_queue(sk);
> +	xtcp_collapse_ofo_queue(sk, &tp->out_of_order_queue,
> +				&tp->ooo_last_skb, tp->scaling_ratio);
>  	if (!skb_queue_empty(&sk->sk_receive_queue))
> -		tcp_collapse(sk, &sk->sk_receive_queue, NULL,
> -			     skb_peek(&sk->sk_receive_queue),
> -			     NULL,
> -			     tp->copied_seq, tp->rcv_nxt);
> +		xtcp_collapse(sk, &sk->sk_receive_queue, NULL,
> +			      skb_peek(&sk->sk_receive_queue),
> +			      NULL,
> +			      tp->copied_seq, tp->rcv_nxt,
> +			      tp->scaling_ratio);
>  
>  	if (tcp_can_ingest(sk, in_skb))
>  		return 0;

