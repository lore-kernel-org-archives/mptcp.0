Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607F34A1A
	for <mptcp@lists.linux.dev>; Tue, 23 Jan 2024 01:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705972878; cv=none; b=i9h9ISraJ96YpzPRA6y4dnXWiGGQrzG74fbPdms8mWGgBagwBMJDxTCZkof72ttfPOpbkAEAFDNfzsBtH+Y6FACJEoxYXn9ZWVUrnbdqPkKNW7mDVYpaCCeRJkivTqPOu5NoV4n6IxTWiMI6XSOZVAU+qwJjoOVXEYbL7FTBYwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705972878; c=relaxed/simple;
	bh=GjVpVNFN7AjYTJwa8vssZuntChXv3stMU2iXQ4B8Mas=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=S7HrrKf57Bg+tVJEjzaHFzUj3LhfOHxUIQZwhbW/tE5TtFTWRmHU9LCKuNVD9f5zwKdv4ek2DP8SqHEbuPWlLyvyXkPPDImcy5KnavmcYwcMz4YZCTVg1F4yMjq5T7CKYACbFW/j9MaGapEPtaozox9c4NRZJYATsvWMDJ/LLJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXYOjOC1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXYOjOC1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9471C433F1;
	Tue, 23 Jan 2024 01:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705972877;
	bh=GjVpVNFN7AjYTJwa8vssZuntChXv3stMU2iXQ4B8Mas=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=XXYOjOC1NZGxqpa32skOpFdAlQGumUoA9vEmgc9Ed4lnQ417iX33Db94WQ1/SA7Sp
	 jaFucXxB+Lv9hYx8KQLxtVyYdzk8Xar3d6nGDLzMBq1O8lpRs+SKBiPTm9E/PKd0tc
	 jTE6tl4M3QSLzhxl07Xu6y1+3Vv1Yp1mg5YRbqscV49Vf7Ygy6xlZLZDP+g6vHRgNh
	 ChYfbhjfaTmPAR/JVqnbTENNU0a3b3W+MQOIwgvTZ7E0g6bLj7SCHuJSzpJTKbSGea
	 tMY1/X5SWzvwfabdfjbBac4pvpFji9ebmOWxqlIUIUz4QJreZD2XHzeCGBziLj6gHB
	 UckZAOUTWUrXA==
Date: Mon, 22 Jan 2024 17:21:17 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 2/5] mptcp: annotate lockless access for the
 tx path
In-Reply-To: <9c7547095ed8aadab3cff658519f37cacf0269c2.camel@redhat.com>
Message-ID: <918a10e2-208b-3831-cd3e-90e7cb38aeb4@kernel.org>
References: <cover.1705427537.git.pabeni@redhat.com> <92930a7b962611507f4bb87671d97f526ece5952.1705427537.git.pabeni@redhat.com> <348ef69e-3d3f-fb7d-2388-174ef14e3209@kernel.org> <063e86ef8d80ed39d8f257f9cca3651f9b46d500.camel@redhat.com>
 <9c7547095ed8aadab3cff658519f37cacf0269c2.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 22 Jan 2024, Paolo Abeni wrote:

> On Sun, 2024-01-21 at 22:47 +0100, Paolo Abeni wrote:
>> On Thu, 2024-01-18 at 17:03 -0800, Mat Martineau wrote:
>>> On Tue, 16 Jan 2024, Paolo Abeni wrote:
>>>
>>>> The mptcp-level TX path info (write_seq, bytes_sent, snd_nxt) are under
>>>> the msk socket lock protection, and are accessed lockless in a few spots.
>>>>
>>>> Always mark the write operations with WRITE_ONCE, read operations
>>>> outside the lock with READ_ONCE and drop the annotation for read
>>>> under such lock.
>>>>
>>>> To simplify the annotations move mptcp_pending_data_fin_ack() from
>>>> __mptcp_data_acked() to __mptcp_clean_una(), under the msk socket
>>>> lock, where such call would belong.
>>>>
>>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>>> ---
>>>> net/mptcp/options.c  |  2 +-
>>>> net/mptcp/protocol.c | 14 ++++++--------
>>>> net/mptcp/protocol.h |  2 +-
>>>> 3 files changed, 8 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>>>> index cebbd0bc32aa..51b00d7e7c89 100644
>>>> --- a/net/mptcp/options.c
>>>> +++ b/net/mptcp/options.c
>>>> @@ -1061,7 +1061,7 @@ static void ack_update_msk(struct mptcp_sock *msk,
>>>> 		msk->wnd_end = new_wnd_end;
>>>>
>>>> 	/* this assumes mptcp_incoming_options() is invoked after tcp_ack() */
>>>> -	if (after64(msk->wnd_end, READ_ONCE(msk->snd_nxt)))
>>>> +	if (after64(msk->wnd_end, snd_nxt))
>>>
>>> Is it ok to remove this READ_ONCE()? The snd_nxt local is stored before
>>> the data_lock is acquired.
>>
>> You are right, READ_ONCE is required here. This is outside the msk
>> socket lock. I'll send a v2.
>
> Oops, sorry I was too hasty. After a better re-read I think this patch
> is correct.
>
> We don't need to re-read snd_nxt inside the data_lock:
> - the 'new' value will still _not_ be any more accurate, as the lock
> protecting such lock is the msk _socket_ lock.
> - we don't have any data dependency with others msk fields
>
> The READ_ONCE annotation is there just to make the fuzzer happy and
> avoid reporting data races, we don't need to issue the read operation
> multiple time.
>
> Please let me know if the above makes sense to you!
>

Yeah, that makes sense. Also, the only (incredibly rare) consequence of a 
stale snd_nxt here could be an unnecessary call to __mptcp_check_push(), 
which is not a problem.

- Mat

