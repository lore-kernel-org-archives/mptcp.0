Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794845727;
	b=f/KdWsGyPE4X2u7Ps7cY76m5NkJ2Bpc/3Fdci8xGpTIgWpSO0ZoFo6rWSOpsbaaMXyjG
	 ayoFUmLnkVBltfHQPMCOFpnLOeOv6h5OD+g8LLOmGHARiylt+APupfghV7xFu00LNTfzh
	 JSlS0gGLwxtpE8VVf8aGfMOIvdRJ3IYPclqHpt4WbPqREFD9bkGDISWLeIrSV/eriFoPJ
	 6ZSqgypNiUbbHIVtt9d3/uCTyruK7IT/6hiEktuyZvPHhJTTGvzclttPrv9n3R6yWwBzy
	 C5Mc1kAi+in3x3aoPVNmnE/0/rSo0jNoYX+KwNQT9j+7vbrmd37tzJdhNqQUYQ154gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845727;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=XpO41rF7fuuT/Jt6BqEu29smVLYOtXz6DZtH/axydLM=;
	b=vaM0bSEbP8ztpPp5qmVvOZ+IHROxEqFcI/Z0C5EqcY5lYxUqXfjNWLMjfPceYtXNOLMu
	 aMdjKIZTy9j8vlH7ub5VbyakdOYKbuiuYgF5qeu12WEuj1OsOpq0vvmlhqIqSypBlUK0d
	 8LG409NY95cGFX9t1ygIRL8JSXkomdH8wIfD/wpWIILgogL+0u+sKYR/NhsDFsV73jVer
	 3yGxZRN1xq3b5g95c8Q2Y4QF4cu0MCa53rJKyZLTcRU9piPoYAhbMgW3MKiH4LbYqSsZt
	 yde0YTmuC7ag2Nc45s+x5cvJ9McufLEB7connWfxZWiXu0f+AE0SuPmLE5aAfGGwpsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cyAxau5Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4F2606A329;
	Mon, 16 Nov 2026 16:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cyAxau5Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D5B1F000C4;
	Mon, 16 Nov 2026 16:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794845726;
	bh=XpO41rF7fuuT/Jt6BqEu29smVLYOtXz6DZtH/axydLM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cyAxau5ZGhX1pqO6cIopx7yAcSPhWtCKG04Sl5ADX50BH0Nwf9XGLSrQC6Hj0bpms
	 0NKgqTwwlvd7E7YgcdS0az4jDmVLnbVDxVkrXrghL+2nedCu760ECL8Khc61JW47dw
	 CkchGjL9i16FQiFzjzwsW8fyxybVrWqAa1wo2vU3C8cx1MVNwClrhMhgd7T0WJH8vb
	 1wGGzMX9iDDdg98+z8yA49q6cUjEHLI73PqoowBYICrBA9HN6+hDNIznFWqTHa8IqH
	 RFXNTKcFOMkOZD3rijg4265V2kCpB3p+PmW/7fWEvrSzp6cuyvSwzN25EdgNbFMjO1
	 wzMHx9YOxy+fA==
Message-ID: <3d9efe33-f11d-4541-8000-01906197d2d1@kernel.org>
Date: Mon, 16 Nov 2026 17:15:21 +0100
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v1 net-next 3/8] tcp: Stop collapsing if not bloated.
Content-Language: fr
To: Eric Dumazet <edumazet@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: Mat Martineau <martineau@kernel.org>, Neal Cardwell
 <ncardwell@google.com>, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
 MPTCP Linux <mptcp@lists.linux.dev>
References: <20261114040101.1043546-1-kuniyu@google.com>
 <20261114040101.1043546-4-kuniyu@google.com>
 <CAL4Wiipd9jDp+rVAo44-JDVtXrGR_0cubE3yaZ5Qb6w8-s+6Zw@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CAL4Wiipd9jDp+rVAo44-JDVtXrGR_0cubE3yaZ5Qb6w8-s+6Zw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Eric, Kuniyuki, Paolo,

(+cc MPTCP ML)

On 14/11/2026 16:35, Eric Dumazet wrote:
> Le sam. 14 nov. 2026 à 05:01, Kuniyuki Iwashima <kuniyu@google.com> a écrit :
>>
>> Even when a skb is not bloated, tcp_collapse() starts collapsing
>> if the next skb has overlapping data.
>>
>> Also, tcp_collapse() does not stop until it reaches the tail or
>> unmergable skb (SYN/FIN, unreadable frags).
>>
>> Assume we detect a low-density skb followed by fully-packed 4K-MSS
>> GRO skbs:
>>
>>              skb->len  truesize  scaling_ratio
>>   skb    #1      1448      2944      125 (49%)
>>   skb    #2     65536     66432      252 (98%)
>>   skb    #3     65536     66432      252 (98%)
>>   ...
>>   skb    #9     65536     66432      252 (98%)
>>   --------------------------------------------
>>   total                  534400
>>
>> Then, even the high-density skbs are repacked into lower-density
>> skbs, and we end up consuming much more memory.
>>
>>              skb->len  truesize  scaling_ratio
>>   nskb   #1      3776      4352      222 (86%)
>>   nskb   #2      3776      4352      222 (86%)
>>   ...
>>   nskb #139      3776      4352      222 (86%)
>>   nskb #140       872      2304       96 (37%)
>>   --------------------------------------------
>>   total                  607232 (+72832!)
>>
>> Even if we find a collapsible skb, we should not collapse
>> subsequent skbs with scaling_ratio >= TCP_COLLAPSE_SCALING_RATIO.
>>
>> Conversely, even if tp->scaling_ratio is smaller than
>> TCP_COLLAPSE_SCALING_RATIO, we should repack skbs once we
>> start collapsing, which results in higher-density skb.
>>
>> Let's remove the next skb condition in the first loop,
>> search for collapsible bloated skb range, and repeat
>> collapsing for each range.
>>
>> Note that even when the next skb is not bloated, we must
>> collapse it for OOO rbtree if it has overlapping data.
>>
>>         if ((list || !before(TCP_SKB_CB(n)->seq, sub_end)) &&
>>             !tcp_collapse_skb_bloated(n, sub_end,
>>                                       TCP_COLLAPSE_SCALING_RATIO))
>>
>> For example, bloated skb_1 and non-bloated skb_2 have overlapping
>> data and only skb_1 is collapsed to nskb_1 and nskb_2.
>>
>>    skb_1 = [1000, 5000]
>>    skb_2 = [2000, 66000]
>>
>> Then, nskb_2 will be inserted after skb_2 in rbtree, wrongly
>> setting tp->ooo_last_skb to 5000.
>>
>>   nskb_1 = [1000, 4776]
>>    skb_2 = [2000, 66000]
>>   nskb_2 = [4776, 5000]
>>
>> This case is still inefficient, but a later patch handles this.

Thank you for working on that!

>> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
>> ---
>>  net/ipv4/tcp_input.c | 66 +++++++++++++++++++++++++-------------------
>>  1 file changed, 37 insertions(+), 29 deletions(-)
>>
>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
>> index e07f43347409..5bd42a74c6f5 100644
>> --- a/net/ipv4/tcp_input.c
>> +++ b/net/ipv4/tcp_input.c
>> @@ -5839,7 +5839,7 @@ static struct sk_buff *tcp_collapse_one(struct sock *sk, struct sk_buff *skb,
>>  }
>>
>>  /* Collapse contiguous sequence of skbs head..tail with
>> - * sequence numbers start..end.
>> + * sequence numbers start..sub_end.
>>   *
>>   * If tail is NULL, this means until the end of the queue.
>>   *
>> @@ -5848,15 +5848,18 @@ static struct sk_buff *tcp_collapse_one(struct sock *sk, struct sk_buff *skb,
>>   */
>>  static void
>>  tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
>> -            struct sk_buff *head, struct sk_buff *tail, u32 start, u32 end)
>> +            struct sk_buff *head, struct sk_buff *tail, u32 start)
>>  {
>>         struct sk_buff *skb = head, *n;
>>         struct sk_buff_head tmp;
>>         u8 scaling_ratio;
>> +       u32 sub_end;
>>
>>         scaling_ratio = min(tcp_sk(sk)->scaling_ratio,
>>                             TCP_COLLAPSE_SCALING_RATIO);
>>
>> +       __skb_queue_head_init(&tmp);
>> +
>>         /* First, check that queue is collapsible and find
>>          * the point where collapsing can be useful.
>>          */
>> @@ -5872,38 +5875,48 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
>>
>>                 /* The first skb to collapse is:
>>                  * - not SYN/FIN and
>> -                * - the unread portion starting from "start" is bloated, or
>> -                *   overlaps to the next one and mptcp allow collapsing.
>> +                * - the unread portion starting from "start" is bloated.
>>                  */
>> -               if (!skb_frags_readable(skb) ||
>> -                   TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN))
>> -                       goto skip_this;
>> -
>> -               if (tcp_collapse_skb_bloated(skb, start, scaling_ratio))
>> -                       break;
>> -
>> -               if (n && n != tail && skb_frags_readable(n) &&
>> -                   tcp_skb_can_collapse_rx(skb, n) &&
>> -                   TCP_SKB_CB(skb)->end_seq != TCP_SKB_CB(n)->seq)
>> +               if (skb_frags_readable(skb) &&
>> +                   !(TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN)) &&
>> +                   tcp_collapse_skb_bloated(skb, start, scaling_ratio))
>>                         break;
>>
>> -skip_this:
>>                 /* Decided to skip this, advance start seq. */
>>                 start = TCP_SKB_CB(skb)->end_seq;
>>         }
>>
>>         if (!skb || skb == tail)
>> -               return;
>> +               goto end;
>>
>> -       __skb_queue_head_init(&tmp);
>> +       /* Second, find consecutive collapsible skb. */
>> +       sub_end = TCP_SKB_CB(skb)->end_seq;
>> +
>> +       for (n = tcp_skb_next(skb, list); n && n != tail; n = tcp_skb_next(n, list)) {
>> +               if (!skb_frags_readable(n) ||
>> +                   TCP_SKB_CB(n)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN) ||
>> +                   !tcp_skb_can_collapse_rx(skb, n))
>> +                       break;
> 
> 
> Adding MPTCP maintainers.

Thank you!

> Before this patch, each candidate was tested against the current new
> skb:
> 
>         !tcp_skb_can_collapse_rx(nskb, skb)
> 
> and nskb is the result of mptcp_skb_ext_move(nskb, skb), done with
> the skb that was being copied when nskb was allocated.
> 
> Now all candidates are tested against the first skb of the range,
> before any extension has been moved.
> 
> mptcp_ext_matches() is not symmetric (a 'from' skb without extension
> matches anything), so the two are not equivalent when the range needs
> more than one new skb. For instance:
> 
>   skb1 (ext A, 6000 bytes), skb2 (ext A)
> 
> nskb1 gets ext A, nskb2 is allocated while skb1 is still being
> copied and gets no extension. Before the patch, skb2 was not merged
> into nskb2 (to_ext == NULL, from_ext != NULL). Now it is, and its
> extension is dropped.
> 
> This might be fine since skb2 has the same mapping as nskb1, but
> I would like MPTCP folks to confirm, and the changelog should
> mention it.

This looks fine to me for MPTCP, and this series should make collapsing
work better for MPTCP. If, by chance, Paolo has the opportunity to
confirm this, that would be nice as he worked on this part for MPTCP.
(But feel free to move on.)

> The rest of the patch looks good to me.

That's maybe more for a follow-up, but *if* I understood this correctly,
I'm wondering if we couldn't skip an out-of-order range when an SKB that
cannot be merged partially overlaps it. That would address SKBs with
different MPTCP mapping (or a FIN overlapped by bloated segments, for
example). We could skip overlapped SKBs here above and "goto restart"?

But with the MPTCP Linux stack, retransmissions should keep the same
mapping (except for the DATA_FIN). So maybe not worth supporting that
case, except if the goal is to deal with misbehaving peers?

>> +               if (!after(TCP_SKB_CB(n)->end_seq, sub_end))
>> +                       continue;
>> +
>> +               /* seq and end_seq must increase monotonically for rbtree. */
>> +               if ((list || !before(TCP_SKB_CB(n)->seq, sub_end)) &&
>> +                   !tcp_collapse_skb_bloated(n, sub_end,
>> +                                             TCP_COLLAPSE_SCALING_RATIO))
>> +                       break;

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

