Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC243EDAD3
	for <mptcp@lists.linux.dev>; Wed,  6 May 2026 13:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778074046; cv=none; b=mPHHQwxc94hP1WbTREETHveBKTVlF7nJd6MPtQDcdhy22oUnIgwhCwYUKLp9dvsYxxsRdxC8wLOpdZTNZl6C27M2jJBpYc952syCHARRSWzDKFgwFFnzFHDLnuVMyVZ/X0fWtVv2PKYtzzbY4zkr1oSJMZVnce3oR5v15Y2C6D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778074046; c=relaxed/simple;
	bh=QFqJBwCgBiSzO/KD0l2aNtWf4dwvNvY/LUA9OMrUapM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WwB7Po5uDX2rl7NQOvBxpRpMlrB0BSOSIqTsZ/GtAvTWeRXpuMvFDTPpCzXDEau7qpY8UfzVdZDUykNsyI/dncfPuCHQ1Ed3Ev3KzO0pngi8a52ohzsWXeTbxYwDEa+DI0vd0cZHMaCJdeggLmt5ecYhoonpxTC6By5F/4a+Ivo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=tjcGq+k3; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="tjcGq+k3"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=sLeebekImrTGqdUhdzh6GLhOFMzUSJ/Ha7Dr/siyfyE=;
	b=tjcGq+k3t+zaw0fv5S5plTg0d39XYnRCAOQQ8bXOiujUXf/QxYk0i2ynCC4CslERTMYvdBaJn
	sWNHDsLwkxXMX4iyuriEueXrjT1ad8WqvNeDM/Wtu7kRot3rM9eaOv4Eaj0wsMt0QASlg1WtLDE
	99MPuLRzmI5B0myIHqIlfjA=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4g9bb96Jq1zcZyK;
	Wed,  6 May 2026 21:20:05 +0800 (CST)
Received: from kwepemj500018.china.huawei.com (unknown [7.202.194.48])
	by mail.maildlp.com (Postfix) with ESMTPS id AA3DC40561;
	Wed,  6 May 2026 21:27:14 +0800 (CST)
Received: from [10.174.178.79] (10.174.178.79) by
 kwepemj500018.china.huawei.com (7.202.194.48) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 6 May 2026 21:27:14 +0800
Message-ID: <3245a905-81a8-46fb-8eac-8c42d259bb58@huawei.com>
Date: Wed, 6 May 2026 21:27:13 +0800
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net v2 1/2] mptcp: pm: fix ADD_ADDR timer infinite
 retry on option space insufficient
To: Matthieu Baerts <matttbe@kernel.org>
CC: "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>, "weiyongjun (A)"
	<weiyongjun1@huawei.com>, yuehaibing <yuehaibing@huawei.com>, zhangchangzhong
	<zhangchangzhong@huawei.com>, <xiasong.lee@gmail.com>
References: <20260430112026.343691-1-lixiasong1@huawei.com>
 <20260430112026.343691-2-lixiasong1@huawei.com>
 <177755524215.1566930.3209225574765644709.b4-review@b4>
 <0430cd33-4d2e-4659-be1e-fada67bb9c6d@gmail.com>
 <4792fa80-2485-47bc-9c50-0526c2f23484@kernel.org>
From: Li Xiasong <lixiasong1@huawei.com>
In-Reply-To: <4792fa80-2485-47bc-9c50-0526c2f23484@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemj500018.china.huawei.com (7.202.194.48)

Hi Matt,

I’m currently preparing the v3 update for this fix.

In mptcp_pm_add_addr_signal(), when TCP option space is insufficient, we
cancel the ADD_ADDR retrans timer via mptcp_pm_del_add_timer(). During
analysis, I found a race window that can lead to one extra ADD_ADDR send
attempt, so I’d like to confirm the intended semantics before posting v3.

I see two race cases:

Case 1: cancel state applied first (handled by existing counter check)

CPU0 (cancel path)                          CPU1 (add_timer callback)
--------------------------------------      -----------------------------------
option space insufficient                   callback already running
call mptcp_pm_del_add_timer()               ...
acquire pm.lock                             ...
set retrans_times = ADD_ADDR_RETRANS_MAX    ...
release pm.lock                             ...
stop timer                                  ...
                                            acquire pm.lock
                                            check retrans_times <
                                              ADD_ADDR_RETRANS_MAX ?
                                            false -> skip announce/send
                                            release pm.lock

For this case, gating send by
`retrans_times < ADD_ADDR_RETRANS_MAX` prevents stale send.


Case 2: callback takes lock first and sends before cancel applies

CPU0 (cancel path)                          CPU1 (add_timer callback)
--------------------------------------      -----------------------------------
option space insufficient                   callback already running
call mptcp_pm_del_add_timer()               acquire pm.lock
try acquire pm.lock -> blocked              check send conditions
                                            announce/send ADD_ADDR  <- send
                                            retrans_times++
                                            release pm.lock
acquire pm.lock                             ...
set retrans_times = ADD_ADDR_RETRANS_MAX    ...
release pm.lock                             ...
stop timer                                  ...


I’d like to discuss which semantic target is better for v3:

A) best-effort cancel:
   race may still allow at-most-one extra send attempt and `ADDADDRTXDROP`
send-failure statistics may be incremented one extra time.

B) strict cancel semantics:
   once cancel is decided, no further ADD_ADDR send action

My current understanding:
- Case 1 can be covered by the existing retrans_times gate.
- Case 2 is the key trade-off between complexity and strictness.

Happy to hear your thoughts on which direction is preferable.
I can prepare v3 accordingly.

Thanks for the guidance.

Best regards,
Li Xiasong

On 5/1/2026 11:13 PM, Matthieu Baerts wrote:
> Hi Li,
> 
> On 01/05/2026 17:03, Li Xiasong wrote:
>> On 4/30/26 9:20 PM, Matthieu Baerts wrote:
>>> On Thu, 30 Apr 2026 19:20:25 +0800, Li Xiasong <lixiasong1@huawei.com> wrote:
> 
> (...)
> 
>>>> @@ -881,24 +889,47 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
>>>> [ ... skip 26 lines ... ]
>>>> +			goto out_unlock;
>>>> +
>>>> +		if (*echo) {
>>>> +			MPTCP_INC_STATS(net, MPTCP_MIB_ECHOADDTXDROP);
>>>> +		} else {
>>>> +			skip_add_addr = true;
>>>
>>> Even if I don't think we would have space issues with the echo, should
>>> this variable also be set also in case of ADD_ADDR echo?
>>>
>>> (In this case, the variable could also simply be called 'skip', or
>>> 'drop', similar to the MIB counters here.)
>>>
>>
>> My current understanding is that the skip marker is only required for
>> the non-echo ADD_ADDR path, because that is the one tied to the local
>> ADD_ADDR retransmission timer flow.
>>
>> For the echo case here, it looks more like a reply path to a received
>> peer ADD_ADDR, so on option-space shortage, clearing the signal bit and
>> accounting the drop might be sufficient.
>>
>> But I may be missing something in this area — if you think echo should
>> also go through the same skip handling, I can align with that in v3.
> 
> Indeed, you are right, I mixed thing up: when an ADD_ADDR echo is
> received, the timer for the linked ADD_ADDR is stopped, but no timer
> needs to be stopped when sending the ADD_ADDR echo. So no need to change
> anything here.
> 
>>>> [ ... skip 13 lines ... ]
>>>> +	/* On pure-ACK option-space exhaustion, stop retrying this ADD_ADDR:
>>>> +	 * clear the signal bit, cancel the matching retransmission timer, and
>>>> +	 * let the PM state machine progress.
>>>> +	 */
>>>> +	if (skip_add_addr)
>>>> +		mptcp_pm_add_addr_skip(msk, addr);
>>>
>>> If you have to modify something else, maybe the new helper is not
>>> needed, and the code can be added here directly? I know I suggested the
>>> introduction of this helper, but now that I see the code, I think it
>>> would be easier to understand the new comment above without it, and to
>>> backport this patch.
>>>
>>
>> Agreed. I'll likely inline that logic to keep the change simpler and
>> easier to backport.
>>
>> FYI: I’m replying from my personal address during the holiday period, as
>> I currently don’t have access to my corporate mailbox. I’ll keep
>> following up on this patchset and send v3 shortly.
> 
> All good, no hurry here.
> 
> Cheers,
> Matt
