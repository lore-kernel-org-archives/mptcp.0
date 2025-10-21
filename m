Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED99525B30E
	for <mptcp@lists.linux.dev>; Tue, 21 Oct 2025 23:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090815; cv=none; b=giMFkiwbu7jToe1KXngg3HFF32xvxxXuqnPtVV91L8hifsnaSP5iQcNccrW54DCJ4nOOG2lLIYA+a5bQzgeSmu6STn1c6YK/VOAhNhsRWK3qwE445RN2JPMZVbUeAXHfkGfJ8TdvaniwYhydNncMxAIM4Fpa2JGTZzfFujmm48k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090815; c=relaxed/simple;
	bh=Y7vr/YYsEFa2ZbMd2TgJSP0aQc1web4QHiKEaBaaJYU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AV9SqEjQCNGTv+3dZQUPxyr3fJyg3kbA+K5U4YsPcsLQCy+h0uvS01OfiSe+KN8ymVMfnEpRDtJ/R1sUgFcjPKZ2/pFJOcB1pb5ESQLe073FXCLesbf3PsL6twT54RY6OD/DshENzncq5wGXJsxxR+5RTY1ZTYwTRjSO9c+TAaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oip4zqn+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oip4zqn+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76FEFC4CEF1;
	Tue, 21 Oct 2025 23:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761090814;
	bh=Y7vr/YYsEFa2ZbMd2TgJSP0aQc1web4QHiKEaBaaJYU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Oip4zqn++q+b7nDhb4aJA82gwEyfnkG3RyzGAA71xx2DqU90/dvArobR9RxjFzyVU
	 9ioI/5RQWSMIThum7WvohbzCyPSUJI3vrbzJBVBlbT2ivi50JrQSpjYXhMLn6SNQcF
	 JyUDtMUy6JBukVRD2fTOxGFC1WZ8aYhJiKoEypm2WW5yEkkmhUjuTqrpzVgQ5c7+kq
	 MqJl8n96UQicZJSHmJVukDGT93l38zh1gFNUtKZ9YHDEXW1YfyrIzPUFY58wtwHnDD
	 g05ndMD0i7o7uIweNd7I2eMlWtgz3pawLWo6UgPrbNIn20QiBJuOS0B77dHxt2k06p
	 FQVv4n+rAfUug==
Date: Tue, 21 Oct 2025 16:53:33 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v5 mptcp-next 10/10] mptcp: leverage the backlog for RX
 packet processing
In-Reply-To: <69af34f2-5a75-4a02-a183-9609cad4abae@redhat.com>
Message-ID: <0c2291ba-6876-e67b-1607-a56203164ec6@kernel.org>
References: <cover.1759737859.git.pabeni@redhat.com> <1cb19d6e65591b81610cc0dd8ef5d0a38605b3f1.1759737859.git.pabeni@redhat.com> <156d60d8-ee80-49fb-8b8e-d0be56f7a02a@kernel.org> <69af34f2-5a75-4a02-a183-9609cad4abae@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 21 Oct 2025, Paolo Abeni wrote:

> On 10/21/25 1:32 AM, Mat Martineau wrote:
>> On Mon, 6 Oct 2025, Paolo Abeni wrote:
>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>> index 2d5d3da67d1ac..a97a92eccc502 100644
>>> --- a/net/mptcp/protocol.c
>>> +++ b/net/mptcp/protocol.c
>>
>> ...
>>
>>> @@ -3509,23 +3519,29 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
>>>
>>> #define MPTCP_FLAGS_PROCESS_CTX_NEED (BIT(MPTCP_PUSH_PENDING) | \
>>> 				      BIT(MPTCP_RETRANSMIT) | \
>>> -				      BIT(MPTCP_FLUSH_JOIN_LIST) | \
>>> -				      BIT(MPTCP_DEQUEUE))
>>> +				      BIT(MPTCP_FLUSH_JOIN_LIST))
>>>
>>> /* processes deferred events and flush wmem */
>>> static void mptcp_release_cb(struct sock *sk)
>>> 	__must_hold(&sk->sk_lock.slock)
>>> {
>>> 	struct mptcp_sock *msk = mptcp_sk(sk);
>>> +	u32 delta = 0;
>>>
>>> 	for (;;) {
>>> 		unsigned long flags = (msk->cb_flags & MPTCP_FLAGS_PROCESS_CTX_NEED);
>>> -		struct list_head join_list;
>>> +		LIST_HEAD(join_list);
>>> +		LIST_HEAD(skbs);
>>> +
>>> +		sk_forward_alloc_add(sk, msk->borrowed_mem);
>>> +		msk->borrowed_mem = 0;
>>> +
>>> +		if (sk_rmem_alloc_get(sk) < sk->sk_rcvbuf)
>>> +			list_splice_init(&msk->backlog_list, &skbs);
>>>
>>> -		if (!flags)
>>> +		if (!flags && list_empty(&skbs))
>>> 			break;
>>>
>>> -		INIT_LIST_HEAD(&join_list);
>>> 		list_splice_init(&msk->join_list, &join_list);
>>>
>>> 		/* the following actions acquire the subflow socket lock
>>> @@ -3544,7 +3560,8 @@ static void mptcp_release_cb(struct sock *sk)
>>> 			__mptcp_push_pending(sk, 0);
>>> 		if (flags & BIT(MPTCP_RETRANSMIT))
>>> 			__mptcp_retrans(sk);
>>> -		if ((flags & BIT(MPTCP_DEQUEUE)) && __mptcp_move_skbs(sk)) {
>>> +		if (!list_empty(&skbs) &&
>>> +		    __mptcp_move_skbs(sk, &skbs, &delta)) {
>>> 			/* notify ack seq update */
>>> 			mptcp_cleanup_rbuf(msk, 0);
>>> 			sk->sk_data_ready(sk);
>>> @@ -3552,7 +3569,9 @@ static void mptcp_release_cb(struct sock *sk)
>>>
>>> 		cond_resched();
>>> 		spin_lock_bh(&sk->sk_lock.slock);
>>> +		list_splice(&skbs, &msk->backlog_list);
>>> 	}
>>> +	WRITE_ONCE(msk->backlog_len, msk->backlog_len - delta);
>>
>> Hi Paolo -
>>
>> Given the possible multiple calls to __mptcp_move_skbs() and that the
>> spinlock is released/reacquired (and the cond_resched) in the middle,
>> would it make sense to update msk->backlog_len for each iteration of the
>> loop so __mptcp_space() and mptcp_space() don't under-report available
>> space and mptcp_cleanup_rbuf() can make incremental progress?
>>
>> I know we don't want to WRITE_ONCE() more than necessary, but it seems
>> like there won't typically be more than one loop iteration. In the cases
>> where it does repeat the loop that means data is arriving quickly and
>> reporting mptcp_space accurately will be important.
>
> That WRITE_ONCE() is intentionally out of the loop, but not as an
> optimization, but for a functional goal, similar to:
>
> https://elixir.bootlin.com/linux/v6.17.4/source/net/core/sock.c#L3190
>
> without it, in exceptional situation, the loop could run for an
> unbounded amount of time.
>
> Given this is MPTCP-level, and packets went already through the TCP
> subflow possibly such scenario is even more unlikely, but I think it's
> still possible and serious enough we want to avoid it.
>

Ah, I think I see where that could happen if the received packets get 
discarded and don't get counted against the rcv buffer limits.  "Double 
counting" the most recently moved packets using backlog_len creates the 
temporary appearance of no buffer space in that "wild producer" scenario. 
Still applies at the MPTCP level, I agree.

> WRT the receive buffer utilization, it should not change much, as either
> on the backlog or in the receiver buffer, the skb should be accounted
> for the whole truesize.

My concern is mostly that the moved skbs are accounted twice until the 
loop is finally exited, so in the non-adversarial case where packets are 
accepted there would be an impact on the behavior of the rx window during 
high speed transfers.

If the overall delta was used for the purpose of exiting the loop, the 
backlog_len could be updated on each loop iteration while still keeping 
the loop bounded.

Taking into consideration the expected case of high-throughput behavior 
vs. an unexpected/infrequent "wild producer" scenario, does it still seem 
best to keep the above code as-is? I'll see what you decide in v6 :)

- Mat

