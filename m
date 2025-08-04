Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497F22040A8
	for <mptcp@lists.linux.dev>; Mon,  4 Aug 2025 17:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754329084; cv=none; b=fiqA7AV9NbQDxHWRmm3PclRBhgMlAfofYHyyUR+YzO5Y1T9NUFhrLBrNRo+kmHJJ0Wx0NDHWYDIDh8b7NWj06MVyzdR+D3oYAeMhb0/q3LXU01xMVurxdb54W7l4qFDGtHJTkp6PduwtbzGVJS5YkjXviOxio5aCQDKRONkSyFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754329084; c=relaxed/simple;
	bh=Ta2jtRqzATFs0LbAN59ws+gYu9UI661jix3zQ7x06cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFk+Se6rLc9AXBsx5vfDcYlOziRpyKWfWGRK8l0g0i7ilCXvMmvqbHjLdCRRigDQ60vzeqA6rRjeIJIhfJTgopm+tTxlBnvNBgmE/OHnpIpbAv5Xqq73+R6rrU4/SKOzpMTbWbvKGqmN6g2MtDzYfjTaPgDWO5jao1X6IHBXdXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oElE58wX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oElE58wX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC470C4CEE7;
	Mon,  4 Aug 2025 17:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754329083;
	bh=Ta2jtRqzATFs0LbAN59ws+gYu9UI661jix3zQ7x06cg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oElE58wXAlfZqBBgo+wgDvof/LvFE5S4h8XRnIOeeoCxvbE5hDMn47p9/6f47Fojb
	 uq2IwuBnicsB9BW2BbE5xxz24Olc1rSASggavVOSJXbJ7cZlORqBjGCgyT+sBZwDMV
	 qorWzYzP4ZY1FbZVyjVbMmLd0LdjZHW6c+MSNxMZggL+Hp784xYDRaWXWQo2g6NOwo
	 cZedTl7v5oxWINDmjcEabGwPRHYQ91Mia4sSLhEhVwOEEvd6FHpyjHkTXlhVQeS4yl
	 ON8lMqXEQD3547vUmsSmst+T7j6lD+Twpn2xNworA36N/cyR6ZW0uHYoE7q/CHo83V
	 e2432SzE05lOQ==
Message-ID: <f1882de4-a03f-4955-84cc-3ddd34e430a6@kernel.org>
Date: Mon, 4 Aug 2025 19:38:00 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 1/2] mptcp: Add support for SO_MAX_PACING_RATE
Content-Language: en-GB, fr-BE
To: Christoph Paasch <cpaasch@openai.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
References: <20250802-b4-mptcp_setsockopt-v1-0-50d4905a4c2b@openai.com>
 <20250802-b4-mptcp_setsockopt-v1-1-50d4905a4c2b@openai.com>
 <f15385c8-cbec-4434-9dcb-5a0e71581314@kernel.org>
 <CADg4-L9n4YeoTPU05rsNLqSW3+Q5aY-1xOSburpvi02uHbPQAA@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CADg4-L9n4YeoTPU05rsNLqSW3+Q5aY-1xOSburpvi02uHbPQAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Christoph,

Thank you for your reply!

On 04/08/2025 19:05, Christoph Paasch wrote:
> On Sun, Aug 3, 2025 at 5:01 AM Matthieu Baerts <matttbe@kernel.org> wrote:
>>
>> Hi Christoph,
>>
>> Thank you for looking at that!
>>
>> On 03/08/2025 01:52, Christoph Paasch via B4 Relay wrote:
>>> From: Christoph Paasch <cpaasch@openai.com>
>>>
>>> Add support for SO_MAX_PACING_RATE. It will limit the rate of each
>>> individual TCP subflow to the specified rate.
>>
>> Applying the same rate for each subflow seems easier, but should we do that?
> 
> I guess the arguments can go both ways...
> 
>> I mean: if I have an app and I set SO_MAX_PACING_RATE at 1Mbps, at the
>> end, data will be sent at 1Mbps * number of subflows. Is it not strange?
>> On the other hand, implementing it globally with all the subflows might
>> be quite complex I guess as currently, this rate limit is done by TC I
>> think, no?
> 
> Yes, it is done by the fq-sch qdisc (which is the most efficient), but
> can also be done by TCP itself if fq is not present.

Oh nice, I thought SO_MAX_PACING_RATE could only work with fq.

>> I guess the scheduler could set sk_max_pacing_rate for each
>> subflow, but how to distribute it amongst all subflows? Equally? It
>> depends on the limit of each subflow I guess.
> 
> I think that would be tricky to get right. I think a better approach
> would be what I outline below.
> 
>> At the end, what's the "common" use case with SO_MAX_PACING_RATE? If the
>> goal is just to apply a "vague" max limit to avoid abuses, that's maybe
>> OK with a limit per subflow. If the goal is to limit at a precise value,
>> that's possibly strange like that, e.g. using iperf3 with --fq-rate and
>> seeing more than expected.
> 
> AFAICS, there are a few use-cases:
> - For things like streaming media where one knows the bitrate of the
> video/audio and one can reduce TCP burstiness by using
> SO_MAX_PACING_RATE (there is a netflix paper about that -
> https://brucespang.com/papers/sammy.pdf?utm_source=chatgpt.com)

(I wonder what source you are using :-D )

Funny, this paper was mentioned recently at the IETF:

https://datatracker.ietf.org/meeting/123/materials/agenda-123-iccrg-01

> - When one wants to literally slow down the data-transfer speed in
> order to intentionally avoid competing with other flows along the
> paths (that's my use-case).
> 
> I guess the question is what is the intention of SO_MAX_PACING_RATE ?
> I guess you are right that it is mostly about limiting the entire
> MPTCP-connection. Maybe it is even possible to implement it in such a
> way at the qdisc layer, but so that tcp_update_skb_after_send() takes
> information at the MPTCP-layer into account and/or __tcp_transmit_skb
> uses MPTCP-info when calling skb_set_delivery_time(). That's a whole
> new endeavour :-)

That would be great to have such support at the qdisc layer!

> Back to my use-case. I can see why we don't want to use
> SO_MAX_PACING_RATE for that, if that's what we (the community) agree
> on.
> In that case, I guess it needs to be a new MPTCP-specific option ?

I guess we can support both behaviours: one to limit per MPTCP
connection, and the other one per subflow.

One would be set via setsockopt(SOL_SOCKET, SO_MAX_PACING_RATE), and the
other one with setsockopt(SOL_MPTCP, XXX). I guess SO_MAX_PACING_RATE
should be for the whole MPTCP connection, no? In this case, I guess we
should not change the behaviour: not doing a limit per subflow when
using SO_MAX_PACING_RATE in some versions, then switching to a limit per
connection, right?

If so, would it be OK to limit per subflow via something like:

  setsockopt(SOL_MPTCP, MPTCP_SUBFLOW_MAX_PACING_RATE)

WDYT?

Or directly implement SO_MAX_PACING_RATE? :)
>>> Signed-off-by: Christoph Paasch <cpaasch@openai.com>
>>> ---
>>>  net/mptcp/sockopt.c | 31 ++++++++++++++++++++++++++++++-
>>>  1 file changed, 30 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
>>> index 2c267aff95bec90d341de9f9e136b9d2df9b8e13..a79dfeb54a3fe0d8c26a1836ae5dda9fd2fdddea 100644
>>> --- a/net/mptcp/sockopt.c
>>> +++ b/net/mptcp/sockopt.c
>>> @@ -308,6 +308,7 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
>>>
>>>               ret = sk_setsockopt(ssk, SOL_SOCKET, optname, optval, optlen);
>>>               if (ret == 0) {
>>> +                     /* Record the option at the msk for subsequent subflows */
>>
>> (unrelated: maybe not needed?)
> 
> Just wanted to improve the readability of the code here :)

ah ok :)

> 
>>>                       if (optname == SO_REUSEPORT)
>>>                               sk->sk_reuseport = ssk->sk_reuseport;
>>>                       else if (optname == SO_REUSEADDR)
>>> @@ -340,6 +341,25 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
>>>                                                               optval, optlen);
>>>       case SO_LINGER:
>>>               return mptcp_setsockopt_sol_socket_linger(msk, optval, optlen);
>>> +     case SO_MAX_PACING_RATE: {
>>> +             struct mptcp_subflow_context *subflow;
>>> +
>>> +             ret = sock_setsockopt(sk->sk_socket, SOL_SOCKET, optname, optval, optlen);
>>> +             if (ret < 0)
>>> +                     return ret;
>>> +
>>> +             lock_sock(sk);
>>> +             sockopt_seq_inc(msk);
>>> +
>>> +             mptcp_for_each_subflow(msk, subflow) {
>>> +                     struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
>>> +
>>> +                     sk_setsockopt(ssk, SOL_SOCKET, optname, optval, optlen);
>>> +             }
>>> +
>>> +             release_sock(sk);
>>> +             break;
>>
>> It might be better to move this block in a generic helper.
>>
>> (and we should probably refactor more code to use such helpers, similar
>> to what was suggested there:
>> https://patchwork.kernel.org/project/mptcp/list/?series=763505&state=*)
> 
> Yes - this entire file needs some love :-)

True! :)

>>> +     }
>>>       case SO_RCVLOWAT:
>>>       case SO_RCVTIMEO_OLD:
>>>       case SO_RCVTIMEO_NEW:
>>> @@ -373,7 +393,6 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
>>>        * explicitly the sk_protocol field
>>>        *
>>>        * SO_PEEK_OFF is unsupported, as it is for plain TCP
>>> -      * SO_MAX_PACING_RATE is unsupported, we must be careful with subflows
>>>        * SO_CNX_ADVICE is currently unsupported, could possibly be relevant,
>>>        * but likely needs careful design
>>>        *
>>> @@ -1532,6 +1551,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
>>>  {
>>>       static const unsigned int tx_rx_locks = SOCK_RCVBUF_LOCK | SOCK_SNDBUF_LOCK;
>>>       struct sock *sk = (struct sock *)msk;
>>> +     unsigned long max_pacing_rate;
>>>
>>>       if (ssk->sk_prot->keepalive) {
>>>               if (sock_flag(sk, SOCK_KEEPOPEN))
>>> @@ -1579,6 +1599,15 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
>>>       tcp_sock_set_keepcnt(ssk, msk->keepalive_cnt);
>>>       tcp_sock_set_maxseg(ssk, msk->maxseg);
>>>
>>> +     /* Keep pacing settings in sync as well. */
>>> +     max_pacing_rate = READ_ONCE(sk->sk_max_pacing_rate);
>>> +
>>> +     WRITE_ONCE(ssk->sk_max_pacing_rate, max_pacing_rate);
>>> +     if (max_pacing_rate != ~0UL)
>>> +             cmpxchg(&ssk->sk_pacing_status, SK_PACING_NONE, SK_PACING_NEEDED);
>>> +     if (READ_ONCE(ssk->sk_pacing_rate) > max_pacing_rate)
>>> +             WRITE_ONCE(ssk->sk_pacing_rate, max_pacing_rate);
>>
>> Would it not be easier for the maintenance to export some code from
>>
>>   net/core/sock.c
>>
>> doing the same, and calling it from there and here?
> 
> IMO the cleanest way in sync_socket_options() would be that for each
> option we reconstruct a sockptr_t and call sk_setsockopt().
> 
> WDYT ?

Yes, that would be excellent. I didn't have the chance to explore this.
Also, I don't know if we can call sk_setsockopt() for each supported
option (or maybe fine?), maybe we should limit to the ones that have
been modified, no?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

