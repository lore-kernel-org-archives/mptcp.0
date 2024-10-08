Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C96A166F29
	for <mptcp@lists.linux.dev>; Tue,  8 Oct 2024 09:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728379785; cv=none; b=djaepHKOE5Tf06FVTVMldhjRiH2o5FItYHPIDICQVFkoja0WhzB5tK7oTdMGJOdIKBvebTpTewpIFHuJWYLFzC6nUL3tMOkmTIN4yoj762cIT/OkVMvNKlZygThvJ1prsgTTZs3nddK2QpuViv4AHST4L7hNWzfsgV5X4ePX/eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728379785; c=relaxed/simple;
	bh=8A1gjBD2R2gRuHi+H3t8G6O6VVM3a7AaafScXbm1cdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=GLHitQTVNt4Rr2FvIqQFVzZmPLNfy89IHy23wOP5RoJrxB0qSqv3i5k08lnRALyXUSTFAG4Z6qEKsq29MFJJOvr0a1so58CudTuxVGVZcGeYaBmQj7QHe157qYl0pNoMZbkiviOUCYMwOuYcCS1mo1/4PuPPJJtBSHR5KdZvXns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WinO01Dr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WinO01Dr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A2DC4CEC7;
	Tue,  8 Oct 2024 09:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728379784;
	bh=8A1gjBD2R2gRuHi+H3t8G6O6VVM3a7AaafScXbm1cdg=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=WinO01DrpYtA3vrXzlRsiZrUNdQ1SQ13T2r1K21XyAHZqsK5Zjyx2ZWKiyTb2GXqE
	 jgYH5kuBfytmfX68rBlD2cJ9gIxFXY5erP/gBPTzx/KslRa4K739IYEECZ3lqYCA1r
	 qjCeZRf+rETVMRhkz0ZmiC4UUIIV9qoP6T2UaVj5IDacFu6+TgO94xeLYBscWXZBay
	 wpHYI8Qo4lLDoMlKfsmLYUeOXis/em7Ard/k/G2t17mt3QsyViBMCI6k6X17xx1vN1
	 ZxW2EJsTjRY44366nqPvgUHYIk2yaCbtPGw4JHJIjuMBWrAajdnSF5C3XJINi9gAMx
	 6KhtQoHS8XNwQ==
Message-ID: <9ffd0d59-fe64-4155-b421-1de96edf77eb@kernel.org>
Date: Tue, 8 Oct 2024 11:29:42 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2 1/2] mptcp: prevent MPC handshake on
 port-based signal endpoints
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>
References: <20241007-mpc-hs-port-v2-0-0c9e7827bd0f@kernel.org>
 <20241007-mpc-hs-port-v2-1-0c9e7827bd0f@kernel.org>
 <5e4bcf88-58cb-4691-9c60-3fb0a9acbd48@redhat.com>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <5e4bcf88-58cb-4691-9c60-3fb0a9acbd48@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo,

(I guess you dropped the MPTCP ML from Cc by mistake, re-adding it)

On 08/10/2024 08:40, Paolo Abeni wrote:
> On 10/7/24 20:22, Matthieu Baerts (NGI0) wrote:
>> From: Paolo Abeni <pabeni@redhat.com>
>>
>> Syzkaller reported a lockdep splat:

(...)

>> Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port")
>> Reported-by: syzbot+f4aacdfef2c6a6529c3e@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=f4aacdfef2c6a6529c3e
>> Cc: Cong Wang <cong.wang@bytedance.com>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> Please add your co-dev tag instead here.

I only cleaned-up comments, etc. without changing the behaviour, I sent
the v2 mainly because I had the suggested changes on my side already
(when checking if comments could go on one line, checking shellcheck
with the other patch, etc.). I can add it on the other patch, because I
might have done more modifications changing a bit the behaviour, but I
can add my co-dev tag here as well if you prefer.

(...)

>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>> index
>> a1e28e1d8b4e39e14bc8f98164013d302d62595c..5958b63f84469b980bb1af472117643baf740713 100644
>> --- a/net/mptcp/subflow.c
>> +++ b/net/mptcp/subflow.c
>> @@ -132,6 +132,13 @@ static void subflow_add_reset_reason(struct
>> sk_buff *skb, u8 reason)
>>       }
>>   }
>>   +static int subflow_reset_req_endp(struct request_sock *req, struct
>> sk_buff *skb)
> 
> I used a different name because I was wondering about to re-using this
> helper in future patches for other req reset - passing explicitly reason
> and mib. I guess we can rename it as needed later.

Good point. But yes, probably better to rename it later on if we want
something more generic, taking different parameters.

> Side note: Jakub still strongly prefers not exceeding the 80 chars per
> column. A couple of comments and the above line are now above such
> threshold.

Mmh, I think we mostly followed the default 100 chars max per line in
our code. We don't abuse it though: we use more than 80 to improve the
readability, e.g. when the opening parenthesis is "too close" to the end
of the line, when each line needs a comment next to, most multilines
comments are under 80 chars, etc. In other words, if we want to enforce
the max of 80 chars per line, we might uniform that, but I don't think
that's worth it. Or do you think we should?

In this patch, only the comments are above 80 chars, but they are
aligned with the ones just above and below. I can still reduce them I see:

  /* Prohibited MPC attempted towards a port-based signal endp */
  /* Prohibited MPC towards a port-based signal endp */

  /* subflow is a listener managed by the in-kernel PM */
  /* a listener managed by the kernel PM? */

No hurry, I guess we can send this patch later on.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

