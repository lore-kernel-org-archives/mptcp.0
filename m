Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290F53BCD15
	for <mptcp@lists.linux.dev>; Mon, 17 Aug 2026 11:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786964847; cv=none; b=fUIPgC90ZSsvYYrP/V0fFJvUqwXnCInJv+yABqCm/hfA2qk1lwIloAZL9MYF6U8w3AUY2MLqFSOm73tQ8+vZYPa5C/xLzsFESWetyHB5HInsZp3fhm6EiigSWksGcy2xPn4DLf7lNKFYpFtrbWQl+nTEehdt0H/WUWkVoURW92I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786964847; c=relaxed/simple;
	bh=zrVyvn/mCM1Qm17BIcTtC3cEaZe46WXOncuAwXpj+FM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uki5Beebsvd+TCxJx/1ZjGme0HzDUdOYVgooGxYlHOO/wMQh4chbUUJcMCoEjSHtG7oHIQQ8L+YP0ezxHOuwid8RZz3W4GcwG+v0pDnFHhfaHuW/xZZgBqkeO/krnxH6AMWOYCEikOMhPK9ALYHePiWw4LPg0GVLar8xlEX73gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mM0yFF00; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mM0yFF00"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDDA91F000E9;
	Mon, 17 Aug 2026 11:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786964846;
	bh=pEB9/e/jLaToIpAulcetkdxTBJa0VX6kc/CDit1TTwQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mM0yFF00AF2gWDBLynmr2c7Q0+LiJBHObQqvbu6c3KJSutkjdq0dg2lyvABjNtkc1
	 HYeUre95UG1myNwFcp6Jw+1Dfqxna8bkN8+7dkKaa7vw6rY9dzA2+3bnqyTTvzVbvK
	 iquFssEJiS5Q4xBuAiLc52OLK7eRcLY0owlN6/Pn22LW1XK7tz1MSlEDDijUwR3fVs
	 k2Vh/M8gWig9aIQ8Xu2Y2sWx1j3YfrGiTzIPs+xlkzYgcQtXcr2Kawz64p/tGOeWKi
	 WjSHk+HTJ3vISUgj9tc9ycxoEbgChHM1SFhZ9t9axJQfYc/DxHFqyZPNEeTlP8gR9M
	 WO2tZ86l63RPQ==
Message-ID: <2e2b6eff-0d2c-40b9-b66c-f650bb5d1104@kernel.org>
Date: Mon, 17 Aug 2026 13:07:22 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next RFC 3/3] mptcp: pm: kernel: skip operating on
 closing connections
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>, MPTCP Linux <mptcp@lists.linux.dev>
Cc: Chenguang Zhao <chenguang.zhao@linux.dev>, gang.yan@linux.dev
References: <20260814-mptcp-reset-mpj-early-v1-0-3ca3260f9474@kernel.org>
 <20260814-mptcp-reset-mpj-early-v1-3-3ca3260f9474@kernel.org>
 <d1a6a67f-41c0-4650-b62e-6a4476bab86b@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <d1a6a67f-41c0-4650-b62e-6a4476bab86b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo,

On 17/08/2026 09:39, Paolo Abeni wrote:
> On 8/14/26 8:31 PM, Matthieu Baerts (NGI0) wrote:
>> When iterating over each MPTCP connection after having manipulated MPTCP
>> endpoints, there is no need to operate on closing (or not ready)
>> connections.
>>
>> We can then safely skip those.
>>
>> Note that mptcp_nl_add_subflow_or_signal_addr() was already checking the
>> fully_established state, but it is better to check the connection state,
>> which is what mptcp_is_fully_established() is doing.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>>  net/mptcp/pm_kernel.c | 16 +++++++++++-----
>>  1 file changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
>> index d3014bf57bf3..c185e53fe42b 100644
>> --- a/net/mptcp/pm_kernel.c
>> +++ b/net/mptcp/pm_kernel.c
>> @@ -969,7 +969,7 @@ static int mptcp_nl_add_subflow_or_signal_addr(struct net *net,
>>  		struct sock *sk = (struct sock *)msk;
>>  		struct mptcp_addr_info mpc_addr;
>>  
>> -		if (!READ_ONCE(msk->fully_established) ||
>> +		if (!mptcp_is_fully_established(sk) ||
>>  		    mptcp_pm_is_userspace(msk))
>>  			goto next;
> 
> I'm a little double-minded here.
> 
> The add/removal operations are issued by the user space to update
> subflows, as a consequence of endpoint addition/removal.
> 
> Possibly removing the subflow even for not fully established connections
> could be the right thing to do, I'm not 110% sure either way. Possibly
> worth to call this out with a comment?

Indeed, I'm also not sure. Initially, I only converted this
READ_ONCE(msk->fully_established), also because later in
mptcp_pm_create_subflow_or_signal_addr(), mptcp_is_fully_established()
is used.

Probably best to stick to this one.

On the other hand, I just noticed that there is no check for "fallback
done" here: so the operations leading to a notification (ADD_ADDR,
RM_ADDR) will send a dup-ACK (pure ACK without MPTCP options), and
adding an MPTCP endpoint will lead to... the creation of a new subflow,
even after a fallback, e.g.

-------------------------- 8< --------------------------
C > S: Flags [S], seq 0, win 65535, options [mss 1460,sackOK,nop,nop,nop,wscale 6,mptcp 4 capable v1], length 0
S > C: Flags [S.], seq 2252073282, ack 1, win 65535, options [mss 1460,nop,nop,sackOK,nop,wscale 8,mptcp 12 capable v1 {0xb80fe7957527e1f7}], length 0
C > S: Flags [.], ack 1, win 2048, options [mptcp 20 capable v1 {0x200000000000000,0xb80fe7957527e1f7}], length 0
C > S: Flags [P.], seq 1:501, ack 1, win 2048, options [mptcp 22 capable v1 {0xb80fe7957527e1f7,0x200000000000000},nop,nop], length 500: HTTP
S > C: Flags [.], ack 501, win 1049, options [mptcp 12 dss ack 13263177308786789273], length 0

// Here, the client receives the ACK without MPTCP options due to middleboxes → fallback

S > C: Flags [P.], seq 1:101, ack 501, win 1049, options [mptcp 26 dss ack 13263177308786789273 seq 14591534807969507511 subseq 1 len 100,nop,nop], length 100: HTTP
C > S: Flags [.], ack 101, win 2048, length 0

// fallback on the server side

C > S: Flags [P.], seq 501:601, ack 101, win 2048, length 100: HTTP
S > C: Flags [.], ack 601, win 1049, length 0

// Data OK
// Adding a new subflow endpoint now:

S2 > C: Flags [S], seq 618398320, win 65535, options [mss 1460,sackOK,TS val 3041525989 ecr 0,nop,wscale 8,mptcp 12 join id 1 token 0xd86e8112 nonce 0x6cca79f5], length 0
-------------------------- 8< --------------------------

Oops. Still, not a big deal, but probably better and safer to avoid
that, no?

Maybe patch 1 (reset fully_estab after a fallback) and this patch here
but only looking at READ_ONCE(msk->fully_established) is enough?
Patch 2 would be for -next.

> Also the asymmetry with the user-space PM is a bit strange. I can't
> recall why it was needed in the first place?!?

Are you talking about all the mptcp_pm_is_userspace() checks? If yes,
they are required because the pm_type sysctl could be changed, and we
could end-up with a mix of msk handled by different PMs in the same
netns.

It would be better to do the opposite I guess:

  if (!mptcp_pm_is_kernel(msk))
      goto next;

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

