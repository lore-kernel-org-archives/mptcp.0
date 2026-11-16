Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794852463;
	b=ZvMZd0JVeOfDoCkexx6JmkFFvUrKuGJf/Lv9gAKsSjhnqKYfUaX9VJGVh2pE1vdHJHn0
	 lAwjvDGnQu8dcDxg5RcAEvabB5YXZiHqRGCyh54ENCp+dWuQsqPHtdsIdVtsn5uhMzgi7
	 KHOtvRUPSsGTBzmWNa+oM+LLKcb2C0fUQOV3OGISk8Nv68Jt26BAcKedZYc5DRcWXFfcl
	 +9RLxtKs/Q6derhN7QqhCnJCP2EkWi/wvzNVHye1S8R549s7Lg9obgofLysPCZ4Lmv1v4
	 pFmxKdb/a22JUd/W0nkOiQmZVn8GnnSLL45uQWgGebagk3Be4LpNruKiJBNKtuiOMig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794852463;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:From:In-Reply-To:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Language:
	 Content-Type:Content-Transfer-Encoding;
	bh=OqVahXsJIyKENucb4l7liSxwY6HhOQEQyPjsXhFMj9o=;
	b=W1iY2HccJSV7GZkai/me4WE7UH6U31XcGmsbbruKMTxfKplfQW6hmjN3l46XEoEwNZJQ
	 ZnkaxafCBxMrpzma5Be1w9yr6afLCCQl/E0pjm7OfRyI4vnV5vx3LN/X0ZkfnkWKOBdK2
	 rO2a4CnJUY0VTHj+rlg3TplrruSS2uSkQuCIrJ/6UL5GTyg5iaVYC0WPBea1GEtIb5n6o
	 qv0biFQr4PnU9rRd/xGWMiP2iz3yYmp4e+0p7aTD2fouRnufv9KQZfwXZGSBTSnT4EpTk
	 t9iAByU8Tqi1InXMQH/nHFM862rgY0c/uN5nsaKFISybag3LeMZ4JAMaHIKVVnjTIlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iHijyL5m;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8E6606A329
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 18:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A8E6606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iHijyL5m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794852461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OqVahXsJIyKENucb4l7liSxwY6HhOQEQyPjsXhFMj9o=;
	b=iHijyL5mHUMkUcU+3/uhEf+SOWoaGKkMzyJpNv3tF9z1HFYt8oqTO1XJN/NT8r5MLHYoMc
	fojGA7kSi5Ik+zu4yaqkPZZGEHcCgJIObkpELdVoD6mSBeoZ+uSzIZ9iTESAPTfCw0+Ji9
	TLUGCyBtt2c/B76WTGHCZl6AK8KvZ9w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-s255eg04O9KYFLVL6lxXDw-1; Mon, 16 Nov 2026 13:07:39 -0500
X-MC-Unique: s255eg04O9KYFLVL6lxXDw-1
X-Mimecast-MFC-AGG-ID: s255eg04O9KYFLVL6lxXDw_1794852459
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a0284121c6so23910005e9.3
        for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 10:07:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794852458; x=1795457258;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OqVahXsJIyKENucb4l7liSxwY6HhOQEQyPjsXhFMj9o=;
        b=bByPiMS8+hdAZmy9jqwrrBJnrayTtwuYgMAuvfW7vYKk7+K1LGBUjiUcDRV0SRiS5z
         nvrWFlLLamh+8MCTYIRQRHXn8KAYIiezsU0NyWFowGx5uVTVIqmPBzVQG2BQhduY/ekY
         dxhZy/vJQlMdI/ikWtxMxSy1HnOQNSOK8SCktL2XxTTSUUPUgFdnAZrHigmm7wqxL/Kb
         qe8X5imBE4rFBJarn/AhuAVpm5XU44W/QwoaPpMz/3baqDmD/nYqKwKf8QAeP4bs74AY
         GMF7aT0mtvYbgZyRiBvEUoI46cO/noFStQsNRosrAidZ/1Tc1MJ89LjIuBFReVKOfOWA
         WjNw==
X-Forwarded-Encrypted: i=1; AL+hErGKVgvIah6pRCdW/CH/dHmFP5UvMTGroI7s1ytYimjzfYLKDwaEHp5e6XT0uVrcLJseNycMYQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/dbuvLrSC1r8a8S8C3OljlZ4Rk0okFJg1zUpjBGacbTDcu468u
	n4Q6r6CevmQafrMMyqULU++o6Ctw3F4s9SlF8lA2BGQUelwwmQsZiDaXUpf3Jjc2vLAlqdfouz2
	faM5LeMidOl23P9hU+9GWf9o5C7jUskAIl0/mUD+qyteJPzsN7LzE9CDd
X-Gm-Gg: AYBFou19VeiXxkhhSWcuisQvmmTTBSo0Bjl3rTAQIYsli6Fi0rYjVP8QPRQuPJ7kGjs
	foCBayF2DjOR9RZBtYks7Kk0j8yAy3v0A3+d753ilBoyIeNQyQ0bb/I+kMscH2HAR+m9uYb8adt
	KKz94fPmf+3h8FVZURQrR+i7YgystvkVwLmss5n+OGbpTq/QU1ARzjdGc6fqoFx8zKDSKpQiTyc
	HtzE+6yDQlqXJxe/hh9+z6Zkz9ya+RCQlJvI8/kom2on7jbLr4uCNqoZB30FlyBaQO6flSuyklB
	xO3YF6JEFgaybbwr5I2BJWIZhL+LuWioVy7Aq/QJUKumlpfLr5XunLGs8dJHJn68b5gXrRoIX4I
	RqxnMfWdK4+A6st4QhzVfKyl1n2bLl/UObn4cAckqHjPygCmw2XkIDu6wJko8XVEs7+qealSsdw
	ldKe3rCD4S6fGVJLrW+RoMX1mqWISCwaR6x81cnry13Peu
X-Received: by 2002:a05:600c:8b8c:b0:4a1:fbd2:f689 with SMTP id 5b1f17b1804b1-4bb609ae053mr197199175e9.7.1794852458452;
        Mon, 16 Nov 2026 10:07:38 -0800 (PST)
X-Received: by 2002:a05:600c:8b8c:b0:4a1:fbd2:f689 with SMTP id 5b1f17b1804b1-4bb609ae053mr197198415e9.7.1794852457966;
        Mon, 16 Nov 2026 10:07:37 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c8d286480sm42199354f8f.7.2026.11.16.10.07.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 10:07:37 -0800 (PST)
Message-ID: <01c4e295-14b8-414e-9bf1-2be350466fe0@redhat.com>
Date: Mon, 16 Nov 2026 19:07:35 +0100
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 3/8] tcp: Stop collapsing if not bloated.
To: Matthieu Baerts <matttbe@kernel.org>, Eric Dumazet <edumazet@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>
Cc: Mat Martineau <martineau@kernel.org>, Neal Cardwell
 <ncardwell@google.com>, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
 MPTCP Linux <mptcp@lists.linux.dev>
References: <20261114040101.1043546-1-kuniyu@google.com>
 <20261114040101.1043546-4-kuniyu@google.com>
 <CAL4Wiipd9jDp+rVAo44-JDVtXrGR_0cubE3yaZ5Qb6w8-s+6Zw@mail.gmail.com>
 <3d9efe33-f11d-4541-8000-01906197d2d1@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <3d9efe33-f11d-4541-8000-01906197d2d1@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0-qtUY9gyuLIR8OgqMTWsGC-T6pQFtaYczxAeYDea9c_1794852459
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/16/26 17:15, Matthieu Baerts wrote:
> Hi Eric, Kuniyuki, Paolo,
> 
> (+cc MPTCP ML)
> 
> On 14/11/2026 16:35, Eric Dumazet wrote:
>> Le sam. 14 nov. 2026 à 05:01, Kuniyuki Iwashima <kuniyu@google.com> a écrit :
>>>
>>> Even when a skb is not bloated, tcp_collapse() starts collapsing
>>> if the next skb has overlapping data.
>>>
>>> Also, tcp_collapse() does not stop until it reaches the tail or
>>> unmergable skb (SYN/FIN, unreadable frags).
>>>
>>> Assume we detect a low-density skb followed by fully-packed 4K-MSS
>>> GRO skbs:
>>>
>>>               skb->len  truesize  scaling_ratio
>>>    skb    #1      1448      2944      125 (49%)
>>>    skb    #2     65536     66432      252 (98%)
>>>    skb    #3     65536     66432      252 (98%)
>>>    ...
>>>    skb    #9     65536     66432      252 (98%)
>>>    --------------------------------------------
>>>    total                  534400
>>>
>>> Then, even the high-density skbs are repacked into lower-density
>>> skbs, and we end up consuming much more memory.
>>>
>>>               skb->len  truesize  scaling_ratio
>>>    nskb   #1      3776      4352      222 (86%)
>>>    nskb   #2      3776      4352      222 (86%)
>>>    ...
>>>    nskb #139      3776      4352      222 (86%)
>>>    nskb #140       872      2304       96 (37%)
>>>    --------------------------------------------
>>>    total                  607232 (+72832!)
>>>
>>> Even if we find a collapsible skb, we should not collapse
>>> subsequent skbs with scaling_ratio >= TCP_COLLAPSE_SCALING_RATIO.
>>>
>>> Conversely, even if tp->scaling_ratio is smaller than
>>> TCP_COLLAPSE_SCALING_RATIO, we should repack skbs once we
>>> start collapsing, which results in higher-density skb.
>>>
>>> Let's remove the next skb condition in the first loop,
>>> search for collapsible bloated skb range, and repeat
>>> collapsing for each range.
>>>
>>> Note that even when the next skb is not bloated, we must
>>> collapse it for OOO rbtree if it has overlapping data.
>>>
>>>          if ((list || !before(TCP_SKB_CB(n)->seq, sub_end)) &&
>>>              !tcp_collapse_skb_bloated(n, sub_end,
>>>                                        TCP_COLLAPSE_SCALING_RATIO))
>>>
>>> For example, bloated skb_1 and non-bloated skb_2 have overlapping
>>> data and only skb_1 is collapsed to nskb_1 and nskb_2.
>>>
>>>     skb_1 = [1000, 5000]
>>>     skb_2 = [2000, 66000]
>>>
>>> Then, nskb_2 will be inserted after skb_2 in rbtree, wrongly
>>> setting tp->ooo_last_skb to 5000.
>>>
>>>    nskb_1 = [1000, 4776]
>>>     skb_2 = [2000, 66000]
>>>    nskb_2 = [4776, 5000]
>>>
>>> This case is still inefficient, but a later patch handles this.
> 
> Thank you for working on that!
> 
>>> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
>>> ---
>>>   net/ipv4/tcp_input.c | 66 +++++++++++++++++++++++++-------------------
>>>   1 file changed, 37 insertions(+), 29 deletions(-)
>>>
>>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
>>> index e07f43347409..5bd42a74c6f5 100644
>>> --- a/net/ipv4/tcp_input.c
>>> +++ b/net/ipv4/tcp_input.c
>>> @@ -5839,7 +5839,7 @@ static struct sk_buff *tcp_collapse_one(struct sock *sk, struct sk_buff *skb,
>>>   }
>>>
>>>   /* Collapse contiguous sequence of skbs head..tail with
>>> - * sequence numbers start..end.
>>> + * sequence numbers start..sub_end.
>>>    *
>>>    * If tail is NULL, this means until the end of the queue.
>>>    *
>>> @@ -5848,15 +5848,18 @@ static struct sk_buff *tcp_collapse_one(struct sock *sk, struct sk_buff *skb,
>>>    */
>>>   static void
>>>   tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
>>> -            struct sk_buff *head, struct sk_buff *tail, u32 start, u32 end)
>>> +            struct sk_buff *head, struct sk_buff *tail, u32 start)
>>>   {
>>>          struct sk_buff *skb = head, *n;
>>>          struct sk_buff_head tmp;
>>>          u8 scaling_ratio;
>>> +       u32 sub_end;
>>>
>>>          scaling_ratio = min(tcp_sk(sk)->scaling_ratio,
>>>                              TCP_COLLAPSE_SCALING_RATIO);
>>>
>>> +       __skb_queue_head_init(&tmp);
>>> +
>>>          /* First, check that queue is collapsible and find
>>>           * the point where collapsing can be useful.
>>>           */
>>> @@ -5872,38 +5875,48 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
>>>
>>>                  /* The first skb to collapse is:
>>>                   * - not SYN/FIN and
>>> -                * - the unread portion starting from "start" is bloated, or
>>> -                *   overlaps to the next one and mptcp allow collapsing.
>>> +                * - the unread portion starting from "start" is bloated.
>>>                   */
>>> -               if (!skb_frags_readable(skb) ||
>>> -                   TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN))
>>> -                       goto skip_this;
>>> -
>>> -               if (tcp_collapse_skb_bloated(skb, start, scaling_ratio))
>>> -                       break;
>>> -
>>> -               if (n && n != tail && skb_frags_readable(n) &&
>>> -                   tcp_skb_can_collapse_rx(skb, n) &&
>>> -                   TCP_SKB_CB(skb)->end_seq != TCP_SKB_CB(n)->seq)
>>> +               if (skb_frags_readable(skb) &&
>>> +                   !(TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN)) &&
>>> +                   tcp_collapse_skb_bloated(skb, start, scaling_ratio))
>>>                          break;
>>>
>>> -skip_this:
>>>                  /* Decided to skip this, advance start seq. */
>>>                  start = TCP_SKB_CB(skb)->end_seq;
>>>          }
>>>
>>>          if (!skb || skb == tail)
>>> -               return;
>>> +               goto end;
>>>
>>> -       __skb_queue_head_init(&tmp);
>>> +       /* Second, find consecutive collapsible skb. */
>>> +       sub_end = TCP_SKB_CB(skb)->end_seq;
>>> +
>>> +       for (n = tcp_skb_next(skb, list); n && n != tail; n = tcp_skb_next(n, list)) {
>>> +               if (!skb_frags_readable(n) ||
>>> +                   TCP_SKB_CB(n)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN) ||
>>> +                   !tcp_skb_can_collapse_rx(skb, n))
>>> +                       break;
>>
>>
>> Adding MPTCP maintainers.
> 
> Thank you!
> 
>> Before this patch, each candidate was tested against the current new
>> skb:
>>
>>          !tcp_skb_can_collapse_rx(nskb, skb)
>>
>> and nskb is the result of mptcp_skb_ext_move(nskb, skb), done with
>> the skb that was being copied when nskb was allocated.
>>
>> Now all candidates are tested against the first skb of the range,
>> before any extension has been moved.
>>
>> mptcp_ext_matches() is not symmetric (a 'from' skb without extension
>> matches anything), so the two are not equivalent when the range needs
>> more than one new skb. For instance:
>>
>>    skb1 (ext A, 6000 bytes), skb2 (ext A)
>>
>> nskb1 gets ext A, nskb2 is allocated while skb1 is still being
>> copied and gets no extension. Before the patch, skb2 was not merged
>> into nskb2 (to_ext == NULL, from_ext != NULL). Now it is, and its
>> extension is dropped.
>>
>> This might be fine since skb2 has the same mapping as nskb1, but
>> I would like MPTCP folks to confirm, and the changelog should
>> mention it.
> 
> This looks fine to me for MPTCP, and this series should make collapsing
> work better for MPTCP. If, by chance, Paolo has the opportunity to
> confirm this, that would be nice as he worked on this part for MPTCP.
> (But feel free to move on.)

The above scenario looks fine to me, too. Also the in-tree implementation
sends DSS (which get ext on the RX side) for each packet, so it should be
the most common scenario.

I spent some time trying to generate evil sequences of ext/noext that could
lead to bad results but I could not find any.

In any case, definitely +1 for me to mention the functional change in the
changelog.

Thanks,

Paolo

