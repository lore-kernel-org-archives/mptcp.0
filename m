Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76EC204570
	for <mptcp@lists.linux.dev>; Mon, 16 Dec 2024 11:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734347499; cv=none; b=QN88wahjfbk6XUK33pFsw0pT7OJl0+kKoATg7rpJNyErFYdHbB7eAPBk4Y7oI6lxlJkuLc9U9tFgbB/JNGKsYRzDhd1sLCbLQm3RCrqNQHy1xAlZUy2LtmI265qLB9ZklDTmAiuzRkz7hxqseicEwHV5YtawwBCatDY1mE8Au4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734347499; c=relaxed/simple;
	bh=MHcL0ZvZMRu+ylpjeT4f8BvAyzeqsWIrlniQh96IdI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iYLvmX9a1Wbn7GuUTO+g18EShfTn6weajaLlC2+euViW05/w8XabPg8TnlqEIF7KPWsgg1Fxmzmlo7YhQQ3uY9rxkAsy36C+6ifbcmRxOufSM2MTHxErZGDWAmuPKaGnA47H1T5r1OeTXaMZv48atJN02ch4mcQ1bqILy1qH57Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8h2t+IM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8h2t+IM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46896C4CED0;
	Mon, 16 Dec 2024 11:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734347499;
	bh=MHcL0ZvZMRu+ylpjeT4f8BvAyzeqsWIrlniQh96IdI8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X8h2t+IM0vlZ34kf7RV7gf39Z7Xr0NF/VHMhvRGhnFx5yWB6lSE2KQLOXb3rP+L/j
	 aKY6WJNjJ3kPzWjZZ5DT9TfXiQiu/PrVeLYaAT0fZsc+GmyJ/2DpEmD3Gm17YjuoKZ
	 YXWU7Q/bjcedu9Vc+eEncLeE++ygr70xNAt6y2wQEv/PnNF1afwLHHTnYQ/B4sSJ3T
	 Y5HQeIxx8veE5/JJy9oBGEDdeksUp/4TMfDty+3HhUJbJZ5TYxC5W1s28rxwov1WMe
	 TM+4prO4YMQrl4DZpkSPArwR5gZnvrE/FPccijko/hIiY2b7ARcAQmJgfKBaV0WvZ8
	 aVKCePlQouasw==
Message-ID: <d9d05508-02ec-4394-8dbe-4ed8da8facce@kernel.org>
Date: Mon, 16 Dec 2024 12:11:36 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [mptcp-next] mptcp: fix invalid addr occupy 'add_addr_accepted'
Content-Language: en-GB
To: Gang Yan <gang_yan@foxmail.com>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>
References: <tencent_0FE3ED0442E69C9D86C0AEEE338A49F90305@qq.com>
 <902d0bec-abca-4e7c-be43-be2fa1c6ce02@kernel.org>
 <tencent_943B1CC15D1D5654BEB20306FB499F0C3106@qq.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <tencent_943B1CC15D1D5654BEB20306FB499F0C3106@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Gang,

On 16/12/2024 10:05, Gang Yan wrote:
> On Mon, Dec 16, 2024 at 5:00:03PM +0800, Gang Yan wrote:
> 
> Hi Matthieu,
> 
> Happy to receive your reply!
>> On Thu, Dec 12, 2024 at 07:23:02PM +0100, Matthieu Baerts wrote:
>> Hi Gang Yan,
>>
>> Thank you for this patch!
>>
>> I have a few suggestions below. Do you mind sending the next version(s)
>> to the MPTCP list only, no need to include the netdev ML and the net
>> maintainers for the moment I think.
>>
> 
> OK,  sorry for this. I'll be careful next time.

For (urgent/small/occasional) fixes, that's fine to send them directly
to netdev. For new features, I think it is better to reduce the audience
first, and suggest something reviewed to netdev maintainers.

>> On 11/12/2024 10:03, Gang Yan wrote:
>>> From: Gang Yan <yangang@kylinos.cn>
>>>
>>> This patch fixes an issue where an invalid address is announce as a
>>> signal, the 'add_addr_accepted' is incorrectly added several times
>>> when 'retransmit ADD_ADDR'. So we need to update this variable
>>> when the connection is removed from conn_list by mptcp_worker. So that
>>> the available address can be added in time.
>>>
>>> In fact, the 'add_addr_accepted' is only declined when 'RM_ADDR'
>>> by now, so when subflows are getting closed from the other peer,
>>
>> Does it mean that in this case, the counter will be decreased twice:
>> when the RM_ADDR is received, and when the subflow is closed, no?
>>
>> I guess no because you hooked this in a different path, right?
> 
> Yes, the counter will not be declined twice.  The RM_ADDR will invoke
> mptcp_pm_nl_rm_addr_or_subflow() in pm_netlink.c, which will ignore
> the subflow of state '(TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 | TCPF_CLOSING | 
> TCPF_CLOSE)' ,  the subflow of these states will turn into 'TCPF_CLOSE'
> and finally closed in __mptcp_close_subflow() because of mptcp_worker.

Thank you for having checked.

>>> the new signal is not accepted as well.
>>>
>>> We noticed there have exist some problems related to this.I think
>>> this patch effectively resolves them.
>>
>> Please add new test cases for these problems in the MPTCP selftests: to
>> better understand what is being fixed, and to avoid regressions later.
>>
> 
> Actually, I noticed this issue due to "./mptcp_join.sh 28" running failed in my
> machine, but passed in docker-virtme, and it can be reproduced very easily. 
> That's mainly because the status of  invalid_addr's tcp connection is different. 
> It is 'TCPF_SYNC_SENT' in virtme, but  'TCPF_CLOSE' in another.

Strange, do you know why? Is it due to a different kernel configuration?
Do you have more details about that?

> So the 
> differences  of states will cause a different return value of 
> lookup_subflow_by_daddr() in mptcp_pm_nl_add_addr_received() which will add 
> the counter twice when retransmit 'ADD_ADDR'.

Sounds like a bug that needs to be addressed first, no?

> Further, I'll add a new test for covering the specific scene.

Thanks!

>>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/498
>>> Signed-off-by: Gang Yan <yangang@kylinos.cn>
>>> ---
>>>  net/mptcp/protocol.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>> index 21bc3586c33e..f99dddca859d 100644
>>> --- a/net/mptcp/protocol.c
>>> +++ b/net/mptcp/protocol.c
>>> @@ -2569,6 +2569,10 @@ static void __mptcp_close_subflow(struct sock *sk)
>>>                     continue;
>>>  
>>>             mptcp_close_ssk(sk, ssk, subflow);
>>> +
>>> +           if (READ_ONCE(subflow->remote_id) &&
>>> +               --msk->pm.add_addr_accepted < mptcp_pm_get_add_addr_accept_max(msk))
>>> +                   WRITE_ONCE(msk->pm.accept_addr, true);
>> Mmh, I don't think it can be that simple: potentially, an accepted
>> ADD_ADDR can trigger multiple subflows (i.e. when the fullmesh flag is
>> used). In this case, the counter has been incremented once, not once for
>> each created subflow. So before decrementing the counter, it should then
>> be needed to check if no other subflows connected to the same remote ID
>> are still alive.
> 
> Thanks for your advice,  sorry for not considering the 'fullmesh' situations, 
> the check seems necessary.
> 
>> I think it is better not to decrement this counter in "unusual
>> situations" -- the situation before this patch -- than wrongly
>> decrementing it, and ended up with an underflow.
> 
> As the description beyond, the invalid address has caused not accepting
> an available address due to this counter, I think we should ensure the
> available address can be added at least. And an restrict condition can solve
> the underflow problem.

OK, there is maybe another issue to fix first. But what I meant is that:
if it is not possible to have a perfect solution, I think it is better
not to decrement the counter than wrongly decrementing it, and get other
issues.

>> Another thing is that subflows might have not been created upon the
>> reception of an ADD_ADDR: typically if you take the view of a server,
>> the subflows have been initiated by the client, and not because the
>> server got an ADD_ADDR. If I'm not mistaken, the counter would be
>> decremented here as well. We could restrict this by checking
>> "subflow->request_join" I suppose. Still, I'm wondering if that's
>> covering all cases, 
> 
> But does the subflow in server side have 'remote id'? if doesn't, the counter
> will not be declined in server side.

It can be >0, e.g. a client has two addresses (C1, C2), and the server
one (S1) → the client might open 2 subflows:

- C1-S1 → IDs: 0-0
- C2-S1 → IDs: 1-0

From the server side, the second subflow will have a remote ID of 1.

> For covering all cases, I suppose put the 
> patch code in '__mptcp_close_ssk', do you think so?

Could it be possible to have a hook from there? e.g.
mptcp_pm_subflow_closed_external() ("_external" to clarify that it has
been closed by an external factor: this hook will not be called when the
PM itself asks to close the subflow). Then each PM can do extra actions
if needed.

>> and if we should not track ADD_ADDR that are received:
>>
>>   https://github.com/multipath-tcp/mptcp_net-next/issues/496
>>
>> (which is more complex)
> 
> For the problem 1 and 3, I noticed there exists 'anno_list' in server side,
> and we have timer  for retransmitting 'add_addr', do you think we can 
> modify the two modules to fix these problems rather than add a new list.
> For the 'add_addr_accepted', I think  using a restrict condition to update 
> the counter is enough.

There are quite a few cases that are possible, I cannot say at 100% that
a restrict condition is enough. I think it is, but best to double-check:
with the in-kernel PM, in which cases can we have a subflow created to
an address announced by the server? (+ be careful with the "corner"
cases: what if the server sends a RM_ADDR for its first address (ID 0),
then re-announce it later on?)
Maybe enough to check for 'subflow->remote_id > 0' and
'subflow->request_join'?

Could we have concurrency issues here? e.g. the other host sends a
RM_ADDR, followed by the closure of the subflow: I guess it is fine
because the receiver will treat the RM_ADDR first, close the subflow,
then handle the closure from the other side. What if there is are
reordering: first the closure, then the RM_ADDR? Will the kernel discard
the RM_ADDR? (I didn't check, but I guess yes, I recently added a check
of the state: if it is closed/closing, ignore the RM_ADDR, no?)

>> Also, because this counter is specific to the in-kernel PM, I think it
>> would be cleaner f its manipulation is done in pm_netlink.c.

Something else to take into consideration: this counter will only be
incremented with the in-kernel PM. We should then not decrement it when
the userspace PM is used.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

