Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A3534A777
	for <mptcp@lists.linux.dev>; Thu, 23 Oct 2025 17:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761241416; cv=none; b=PhC4RL5lo+3GYP2mE2qRl1fDo3HffjAb5z+D46Uq7f8O033TdJnDezIvfMtrIPS3jI9J1GFSvLtVSuZPX/gTv53mXH2LvQrV8FpxYwfropWQLh4X8Y39d68JdfexlnrYltuPwFkJ8MUb3ASoyZvGVGUEcZMBAl6dckRBWuwOHh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761241416; c=relaxed/simple;
	bh=x6pP27kZSEZ6+lrACdnnTVbaNxch+DTIW+n4R9zENC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iR7Eih+F9LkMckcf5hrjxHoKpLgDYq61KfiGrDuGGk9uvB3M/ZkAly5v2O5LcQWktF3O45ikeDMxlYVNfzEsg8WOjhLvWjdOCP5HqFYIUx35cD4f9J16b4DACs7WzWN2RyADstORzNUYrxYJXpwIx3g7FP+nuXY4FjO5kz8WNzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBsi331R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBsi331R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D366C4CEE7;
	Thu, 23 Oct 2025 17:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761241416;
	bh=x6pP27kZSEZ6+lrACdnnTVbaNxch+DTIW+n4R9zENC8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mBsi331RWB3r3Oc0+UFh9r7RMUzI1HFW2jDiGW8sTaUWx2Ts9s1tleU679AH+Wwsb
	 0f3Dc/dTjF5BbnpSJoL3NSYDQc0xNMVwS0ISt54h8RHGUu6yzfcKJHjsQmp/3On6T6
	 +N0wHU2AJoD+4qTNI38zN4XYk/yG9kl/Oh6QuEeJcujG0sGe+OPcWn/4ZTOvsLY+km
	 VdCrwZOk/5zgLqsdcyxTAeHe3fTbRFrfl7s9dhYlp+o/6aN74LvcPvLn/BRAWuFHyS
	 C8xiQ+vglbNhBVyCMw9fz0euJG6Acr9qJs64Y31HizNhT+qUy57Kf308KZYW5UGpaC
	 cQJFvQl9dFiBA==
Message-ID: <0d2669ee-4625-4551-96e9-22171a406f8c@kernel.org>
Date: Thu, 23 Oct 2025 19:43:33 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 mptcp-next 11/11] mptcp: leverage the backlog for RX
 packet processing
Content-Language: en-GB, fr-BE
To: Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <cover.1761142784.git.pabeni@redhat.com>
 <2201f259d2176bca0ad37500a352658f7ef5a1f0.1761142784.git.pabeni@redhat.com>
 <3feb8c2a-2098-4626-8bf2-edd66f679463@redhat.com>
 <34f90baa-72ff-4c00-917a-a0d65ff0e608@kernel.org>
 <4d70359f-20bb-4575-b6c5-8e862c2547e3@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <4d70359f-20bb-4575-b6c5-8e862c2547e3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat, Paolo,

On 23/10/2025 19:02, Mat Martineau wrote:
> On Thu, 23 Oct 2025, Matthieu Baerts wrote:
> 
>> Hi Paolo, Mat,
>>
>> On 23/10/2025 17:11, Paolo Abeni wrote:
>>>
>>>
>>> On 10/22/25 4:31 PM, Paolo Abeni wrote:
>>>> When the msk socket is owned or the msk receive buffer is full,
>>>> move the incoming skbs in a msk level backlog list. This avoid
>>>> traversing the joined subflows and acquiring the subflow level
>>>> socket lock at reception time, improving the RX performances.
>>>>
>>>> When processing the backlog, use the fwd alloc memory borrowed from
>>>> the incoming subflow. skbs exceeding the msk receive space are
>>>> not dropped; instead they are kept into the backlog until the receive
>>>> buffer is freed. Dropping packets already acked at the TCP level is
>>>> explicitly discouraged by the RFC and would corrupt the data stream
>>>> for fallback sockets.
>>>>
>>>> Move the conditional reschedule in release_cb() to take action only
>>>> after the first loop iteration, to avoid rescheduling just before
>>>> releasing the lock.
>>>>
>>>> Special care is needed to avoid adding skbs to the backlog of a closed
>>>> msk and to avoid leaving dangling references into the backlog
>>>> at subflow closing time.
>>
>> (...)
>>
>>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>>> index 5a1d8f9e0fb0ec..0aae17ab77edb2 100644
>>>> --- a/net/mptcp/protocol.c
>>>> +++ b/net/mptcp/protocol.c
>>
>> (...)
>>
>>>> -static bool __mptcp_move_skbs(struct sock *sk)
>>>> +static bool mptcp_can_spool_backlog(struct sock *sk, u32 moved,
>>>> +                    struct list_head *skbs)
>>>>  {
>>>> -    struct mptcp_subflow_context *subflow;
>>>>      struct mptcp_sock *msk = mptcp_sk(sk);
>>>> -    bool ret = false;
>>>>
>>>> -    if (list_empty(&msk->conn_list))
>>>> +    if (list_empty(&msk->backlog_list))
>>>>          return false;
>>>>
>>>> -    subflow = list_first_entry(&msk->conn_list,
>>>> -                   struct mptcp_subflow_context, node);
>>>> -    for (;;) {
>>>> -        struct sock *ssk;
>>>> -        bool slowpath;
>>>> +    /* Borrowed mem could be zero only in the unlikely event that
>>>> the bl
>>>> +     * is full
>>>> +     */
>>>> +    if (likely(msk->borrowed_mem)) {
>>>> +        sk_forward_alloc_add(sk, msk->borrowed_mem);
>>>> +        msk->borrowed_mem = 0;
>>>> +        sk->sk_reserved_mem = msk->backlog_len;
>>>
>>> With the above I intended to prevent the fwd memory handling from
>>> releasing backlog_len bytes. Re-reading the relevant code, it does not
>>> allow that (experimentation confirmed), see:
>>>
>>> https://elixir.bootlin.com/linux/v6.18-rc2/source/include/net/
>>> sock.h#L1593
>>>
>>> and:
>>>
>>> https://elixir.bootlin.com/linux/v6.18-rc2/source/include/net/
>>> sock.h#L1580
>>>
>>> This will need some more care. Also patch 2 will require some
>>> significant rework.
>>
>> Thank you for looking at this complex part, and for having spot that!
>>
>>> @Mat, @Matttbe: could you please consider merging patches 1,3-9?
>>>
>>> I think they should be pretty uncontroversial, would make the series
>>> more manegeable for future iterations (and would alleviate my
>>> frustration to make this thing work correctly).
>>
>> It makes sense, fine by me. I will wait for Mat's review before applying
>> them (patch 1 is for 'net' I suppose).
>>
> 
> Applying 1,3-9 to our tree(s) makes sense to me. Maybe patch 5 to -net
> too? (just sent email about that before I saw this message).

Good catch! (I will wait for Paolo's reply before applying the patches.)

> Matthieu do you want me to reply to each so the RvB tag is in patchwork,
> or does this suffice for patches 1 & 3-9:
> 
> Reviewed-by: Mat Martineau <martineau@kernel.org>

No, that's fine, I can do a copy-paste. (Note that you can also send it
as a reply to the cover-letter, then I simply only apply the mentioned
patches.)


Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

