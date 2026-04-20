Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8056039E19A
	for <mptcp@lists.linux.dev>; Mon, 20 Apr 2026 17:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776705534; cv=none; b=Vm4Dcq5SKBsQOIcoaUpb5uN2z46k883SSq5q2EXBARsGDdCrFyhnxMs/wnxMj1DNjO6ed1zFb0yyWS98g3F/saWaRN42NuNH0YQX4gR851GWrtZ9d4YfaQR5UFh/QhVNonPwETb+a2s1JhwL8BzRqlsfvIZqXMsMXz/2gecRRUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776705534; c=relaxed/simple;
	bh=E6WGQy8qWjjdbhKBn5NH3TmROGHfxbsxf1okDjCtyxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O04wV+YmvZMhIH+hGD2tHFAPutVgFsZC4N5RGeelLgDkInzKkTQazDqcjok2YJ4mdH/yRx3XdxJnnZonJkI/U0YWzrElngL4Zfa5X6Z7jMxdWFb/FgliZocMYqR3VCQ1UJtDstYJZKSZc1AljMRXSWRVtvuU2TAhkIeS0lGG4YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYLhgnCq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYLhgnCq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7209FC19425;
	Mon, 20 Apr 2026 17:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776705534;
	bh=E6WGQy8qWjjdbhKBn5NH3TmROGHfxbsxf1okDjCtyxs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RYLhgnCqzI04cAE7JKn3JfkHU2xNrDmM1qqZYiqv9fpDvJjhOXlh6DrDCfGRDgnup
	 5ALdYyxXbLNG4/O4I1/JmnQr8pENMvub9hdUvQgxzKu+LFMX+pe+wiHVz/Ox+/t1W1
	 KDwsa/1ySpQqy8VqWv1FWS1AEapkQ14etRKo/O63ePy9X827kSpKTIjy8IQtB8JV9z
	 vQ+c4ubGvzMGxjllQPWcfqpY4gr2glqwEv/1I0mcB6MBD7S9xVA47LUPCs+diHSkDJ
	 J2sVltcvEvqmDQWgmQeqXnCzKEjGPyKSyPzl7HIYN1UKEHJqhBAtbG33AxHcUbeyb0
	 OBG5q18BuWUIQ==
Message-ID: <bad500fc-31cc-4ef3-831e-6159e6f17d5d@kernel.org>
Date: Mon, 20 Apr 2026 19:18:51 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v5 07/20] mptcp: pm: ADD_ADDR rtx: skip inactive
 subflows
Content-Language: fr
To: Mat Martineau <martineau@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
References: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org>
 <20260415-mptcp-inc-limits-v5-7-e54c3bf80e4e@kernel.org>
 <632253e0-5a82-3594-ad77-df344e71cccb@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <632253e0-5a82-3594-ad77-df344e71cccb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 18/04/2026 20:09, Mat Martineau wrote:
> On Wed, 15 Apr 2026, Matthieu Baerts (NGI0) wrote:
> 
>> When looking at the maximum RTO amongst the subflows, inactive subflows
>> were taken into account: that includes stale ones, and the initial one
>> if it has been already been closed.
>>
>> Unusable subflows are now simply skipped. Stale ones are used as an
>> alternative: if there are only stale ones, to take their maximum RTO and
>> avoid to eventually fallback to net.mptcp.add_addr_timeout, which is set
>> to 2 minutes by default.
>>
>> Fixes: 30549eebc4d8 ("mptcp: make ADD_ADDR retransmission timeout
>> adaptive")
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> v2: restore accidentally deleted icsk->icsk_rto > max check
>> ---
>> net/mptcp/pm.c | 17 ++++++++++++-----
>> 1 file changed, 12 insertions(+), 5 deletions(-)
>>
>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
>> index bc5168831085..22ba75fa876c 100644
>> --- a/net/mptcp/pm.c
>> +++ b/net/mptcp/pm.c
>> @@ -306,20 +306,27 @@ static unsigned int
>> mptcp_adjust_add_addr_timeout(struct mptcp_sock *msk)
>>     const struct net *net = sock_net((struct sock *)msk);
>>     unsigned int rto = mptcp_get_add_addr_timeout(net);
>>     struct mptcp_subflow_context *subflow;
>> -    unsigned int max = 0;
>> +    unsigned int max = 0, max_stale = 0;
>>
>>     mptcp_for_each_subflow(msk, subflow) {
>>         struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
>>         struct inet_connection_sock *icsk = inet_csk(ssk);
>>
>> -        if (icsk->icsk_rto > max)
>> +        if (!__mptcp_subflow_active(subflow))
>> +            continue;
>> +
>> +        if (unlikely(subflow->stale)) {
>> +            if (icsk->icsk_rto > max_stale)
>> +                max_stale = icsk->icsk_rto;
>> +        } else if (icsk->icsk_rto > max) {
>>             max = icsk->icsk_rto;
>> +        }
>>     }
>>
>> -    if (max && max < rto)
>> -        rto = max;
>> +    if (max)
>> +        return max < rto ? max : rto;
>>
>> -    return rto;
>> +    return max_stale && max_stale < rto ? max_stale : rto;
> 
> I'd find this more readable as
> 
> if (max)
>         return min(max, rto);
> else if (max_stale)
>         return min(max_stale, rto);
> else
>         return rto;
Good idea! I will switch to that, but without the 'else', if that's OK.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

