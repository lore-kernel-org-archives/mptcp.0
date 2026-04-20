Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CAB946C
	for <mptcp@lists.linux.dev>; Mon, 20 Apr 2026 21:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776719262; cv=none; b=LasoV7t5+BJcc4ET3CCJuBNnTgk+FDU6uENl0xi1bt8xjaMtimMB2b2xWOSpdbqr8E4ncApFBxOoF7Nf5nUDKT1laWQMcFYUpF/JIBQTCLRvBQ0l+ArhkRCP/xrjjfLVQoLBsptSAxRAvvym5Ur+iW5pS5s16XWesmrppIJaEnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776719262; c=relaxed/simple;
	bh=WSAgtKAWSEy7aUl8LgDPiOi2X9HiFe9KQdixZaDbPwc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qQ/6STrujKqfeha0a0ybZ0xKQVft9Pb4AGDlvFtHO5uklrsbWRCUojVnj/Pztder3cf7LprY5c6yGgegGyl+/X78xh+0215Ues1wXFLanOFAz1PIhub6k7mvvsYCdBw0BRfJnTeA1D68Q9mrUvfoJjYLZgqiQhF9+J29m+bK1+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXdlQ7PM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXdlQ7PM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66EC1C19425;
	Mon, 20 Apr 2026 21:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776719262;
	bh=WSAgtKAWSEy7aUl8LgDPiOi2X9HiFe9KQdixZaDbPwc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=XXdlQ7PMc7OP232LeJVbEb+5zgkWNQBuSg0QSd+5+zSooqqA2QJCrt9MFq7Ng8SFg
	 aw9IcKpCJ9RVKIWYJdiEXpJtqQfA6fVgGPli0kkXJreixQlhcAbd42zxhiKCJa+0vV
	 aPIdIjHbgr/2DwFmPEKqoQnAQWqSL9wdrgFUndMA+3nDpti+77SPtA9m1Y2Bh7xGvU
	 B+DUYDGo8zvrWpAItMvfY2btK2pSwGtJb2UKclyPYoVJgd+M4QYh/qIUFWT+v45+a9
	 dPD+xgg57WXsa8WJNdnInwAs/SwaV8hrrQrSuSCUPzdt9SYJcv94McmqlVEp9LbpH6
	 aGg23vfFc4d7Q==
Date: Mon, 20 Apr 2026 14:07:41 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
cc: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-net v5 07/20] mptcp: pm: ADD_ADDR rtx: skip inactive
 subflows
In-Reply-To: <bad500fc-31cc-4ef3-831e-6159e6f17d5d@kernel.org>
Message-ID: <43736f87-1d40-ea45-96a2-539496cd786c@kernel.org>
References: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org> <20260415-mptcp-inc-limits-v5-7-e54c3bf80e4e@kernel.org> <632253e0-5a82-3594-ad77-df344e71cccb@kernel.org> <bad500fc-31cc-4ef3-831e-6159e6f17d5d@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-2107310592-1776719262=:14764"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-2107310592-1776719262=:14764
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 20 Apr 2026, Matthieu Baerts wrote:

> Hi Mat,
>
> On 18/04/2026 20:09, Mat Martineau wrote:
>> On Wed, 15 Apr 2026, Matthieu Baerts (NGI0) wrote:
>>
>>> When looking at the maximum RTO amongst the subflows, inactive subflows
>>> were taken into account: that includes stale ones, and the initial one
>>> if it has been already been closed.
>>>
>>> Unusable subflows are now simply skipped. Stale ones are used as an
>>> alternative: if there are only stale ones, to take their maximum RTO and
>>> avoid to eventually fallback to net.mptcp.add_addr_timeout, which is set
>>> to 2 minutes by default.
>>>
>>> Fixes: 30549eebc4d8 ("mptcp: make ADD_ADDR retransmission timeout
>>> adaptive")
>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>> ---
>>> v2: restore accidentally deleted icsk->icsk_rto > max check
>>> ---
>>> net/mptcp/pm.c | 17 ++++++++++++-----
>>> 1 file changed, 12 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
>>> index bc5168831085..22ba75fa876c 100644
>>> --- a/net/mptcp/pm.c
>>> +++ b/net/mptcp/pm.c
>>> @@ -306,20 +306,27 @@ static unsigned int
>>> mptcp_adjust_add_addr_timeout(struct mptcp_sock *msk)
>>>     const struct net *net = sock_net((struct sock *)msk);
>>>     unsigned int rto = mptcp_get_add_addr_timeout(net);
>>>     struct mptcp_subflow_context *subflow;
>>> -    unsigned int max = 0;
>>> +    unsigned int max = 0, max_stale = 0;
>>>
>>>     mptcp_for_each_subflow(msk, subflow) {
>>>         struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
>>>         struct inet_connection_sock *icsk = inet_csk(ssk);
>>>
>>> -        if (icsk->icsk_rto > max)
>>> +        if (!__mptcp_subflow_active(subflow))
>>> +            continue;
>>> +
>>> +        if (unlikely(subflow->stale)) {
>>> +            if (icsk->icsk_rto > max_stale)
>>> +                max_stale = icsk->icsk_rto;
>>> +        } else if (icsk->icsk_rto > max) {
>>>             max = icsk->icsk_rto;
>>> +        }
>>>     }
>>>
>>> -    if (max && max < rto)
>>> -        rto = max;
>>> +    if (max)
>>> +        return max < rto ? max : rto;
>>>
>>> -    return rto;
>>> +    return max_stale && max_stale < rto ? max_stale : rto;
>>
>> I'd find this more readable as
>>
>> if (max)
>>         return min(max, rto);
>> else if (max_stale)
>>         return min(max_stale, rto);
>> else
>>         return rto;
> Good idea! I will switch to that, but without the 'else', if that's OK.

Sure, that's even better.


- Mat

--0-2107310592-1776719262=:14764--
