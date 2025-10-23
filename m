Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E011333F8DF
	for <mptcp@lists.linux.dev>; Thu, 23 Oct 2025 17:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761238945; cv=none; b=ZOf2WhzbQBDbC1IqLWMONQ2qlZx066471t+XO/A8KdTlqxoPCDRVV1VoGYjxAaN/RiWXSVwVJDmqDWOWVgwy+TpM51k6gbT4E+K7DmQMyrjW0vyeKpi53RopcuzSTo/BbXRrvwfxUL2ClBTqDuXpsVETYP6rfQjuCIdISuInGYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761238945; c=relaxed/simple;
	bh=6/ylDpvOf4kAZtryFBS/cFNARGgkS+e0TZy7nzAYqOQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TsLIqr1Mz7aXAQ3PIp+Skxa4YTgqU54dCXfaxQPsMsatLCiVNdwhYVQCUralh2zaqYx56HTbREKSJgav8mcgfNHMskGZ2sDdriDkAoPSwcQxSt6/TN0SNtbNtLO1NWyr4RQ4I1DmYb8ANfUfNaLOSh28VwO9Oa5dGytW3mr1/B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQ1Tldfb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQ1Tldfb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62CD0C4CEE7;
	Thu, 23 Oct 2025 17:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761238944;
	bh=6/ylDpvOf4kAZtryFBS/cFNARGgkS+e0TZy7nzAYqOQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=GQ1TldfbvjHArnNpFu0XD2kYdCzCYxfP/qPIIISg3hbRQWI042V/QqvsrBrzVppho
	 2wg91Wnx5cdtM3Jzrx+vQxvfuIk97qa84gNV4U2/LHisk2zOJIxgkr48O0XoaZh/cH
	 7omfq6CeQgbkeek/FDHfdG84V43IxKr29SfxSv8dkI17e7vYhTovLQ/mT0jorDB7cn
	 qpTzx3KHcWc0PKQAadeXj90YkOQM5NRY8HWDWpmdeWItF5HIFsbflq4rGhyIW1TQGf
	 VuvhjtkongfyRuNtkgYqbJxtD5UXaQWWwGxN51t4WCq2p2A57nFXTV06w9HqfSKKod
	 FtN6BdmxAHb1g==
Date: Thu, 23 Oct 2025 10:02:23 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>, Geliang Tang <geliang@kernel.org>, 
    mptcp@lists.linux.dev
Subject: Re: [PATCH v6 mptcp-next 11/11] mptcp: leverage the backlog for RX
 packet processing
In-Reply-To: <34f90baa-72ff-4c00-917a-a0d65ff0e608@kernel.org>
Message-ID: <4d70359f-20bb-4575-b6c5-8e862c2547e3@kernel.org>
References: <cover.1761142784.git.pabeni@redhat.com> <2201f259d2176bca0ad37500a352658f7ef5a1f0.1761142784.git.pabeni@redhat.com> <3feb8c2a-2098-4626-8bf2-edd66f679463@redhat.com> <34f90baa-72ff-4c00-917a-a0d65ff0e608@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 23 Oct 2025, Matthieu Baerts wrote:

> Hi Paolo, Mat,
>
> On 23/10/2025 17:11, Paolo Abeni wrote:
>>
>>
>> On 10/22/25 4:31 PM, Paolo Abeni wrote:
>>> When the msk socket is owned or the msk receive buffer is full,
>>> move the incoming skbs in a msk level backlog list. This avoid
>>> traversing the joined subflows and acquiring the subflow level
>>> socket lock at reception time, improving the RX performances.
>>>
>>> When processing the backlog, use the fwd alloc memory borrowed from
>>> the incoming subflow. skbs exceeding the msk receive space are
>>> not dropped; instead they are kept into the backlog until the receive
>>> buffer is freed. Dropping packets already acked at the TCP level is
>>> explicitly discouraged by the RFC and would corrupt the data stream
>>> for fallback sockets.
>>>
>>> Move the conditional reschedule in release_cb() to take action only
>>> after the first loop iteration, to avoid rescheduling just before
>>> releasing the lock.
>>>
>>> Special care is needed to avoid adding skbs to the backlog of a closed
>>> msk and to avoid leaving dangling references into the backlog
>>> at subflow closing time.
>
> (...)
>
>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>> index 5a1d8f9e0fb0ec..0aae17ab77edb2 100644
>>> --- a/net/mptcp/protocol.c
>>> +++ b/net/mptcp/protocol.c
>
> (...)
>
>>> -static bool __mptcp_move_skbs(struct sock *sk)
>>> +static bool mptcp_can_spool_backlog(struct sock *sk, u32 moved,
>>> +				    struct list_head *skbs)
>>>  {
>>> -	struct mptcp_subflow_context *subflow;
>>>  	struct mptcp_sock *msk = mptcp_sk(sk);
>>> -	bool ret = false;
>>>
>>> -	if (list_empty(&msk->conn_list))
>>> +	if (list_empty(&msk->backlog_list))
>>>  		return false;
>>>
>>> -	subflow = list_first_entry(&msk->conn_list,
>>> -				   struct mptcp_subflow_context, node);
>>> -	for (;;) {
>>> -		struct sock *ssk;
>>> -		bool slowpath;
>>> +	/* Borrowed mem could be zero only in the unlikely event that the bl
>>> +	 * is full
>>> +	 */
>>> +	if (likely(msk->borrowed_mem)) {
>>> +		sk_forward_alloc_add(sk, msk->borrowed_mem);
>>> +		msk->borrowed_mem = 0;
>>> +		sk->sk_reserved_mem = msk->backlog_len;
>>
>> With the above I intended to prevent the fwd memory handling from
>> releasing backlog_len bytes. Re-reading the relevant code, it does not
>> allow that (experimentation confirmed), see:
>>
>> https://elixir.bootlin.com/linux/v6.18-rc2/source/include/net/sock.h#L1593
>>
>> and:
>>
>> https://elixir.bootlin.com/linux/v6.18-rc2/source/include/net/sock.h#L1580
>>
>> This will need some more care. Also patch 2 will require some
>> significant rework.
>
> Thank you for looking at this complex part, and for having spot that!
>
>> @Mat, @Matttbe: could you please consider merging patches 1,3-9?
>>
>> I think they should be pretty uncontroversial, would make the series
>> more manegeable for future iterations (and would alleviate my
>> frustration to make this thing work correctly).
>
> It makes sense, fine by me. I will wait for Mat's review before applying
> them (patch 1 is for 'net' I suppose).
>

Applying 1,3-9 to our tree(s) makes sense to me. Maybe patch 5 to -net 
too? (just sent email about that before I saw this message).

Matthieu do you want me to reply to each so the RvB tag is in patchwork, 
or does this suffice for patches 1 & 3-9:

Reviewed-by: Mat Martineau <martineau@kernel.org>

- Mat

