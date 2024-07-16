Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9641C6A4
	for <mptcp@lists.linux.dev>; Tue, 16 Jul 2024 08:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721119457; cv=none; b=GWMOdgCXDSNhyiAMvojDfrFoa2QRv7eOEGSoFYU50+pRjqqixgxDsW5tvVxQyA1zpxXSK1bmvLv5vz+/ZAS4hB5AGqY8PBNhFyEen9lvOyejsJlttbrS9I7HBSDsEjhMrvtzemDqETiDOneH8b19I7t3WpxUfHASzLf0hZAhCXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721119457; c=relaxed/simple;
	bh=9uGt9Z44Mxl/cFhlHHXCsK7ZNsrYMJXPfLfUqpYHWsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dUnJVt22a1g8cmI0mc4qi55+QvEScV4TFQc/uGHWqzlD/hBskE74Lq6XCABpuLw5DPNkqVctDagT3JNZGCMHmt4He8dBydQabJHJYf7/IwTuByNkhqwy5OEvi6NBsjONqkNZDY4KoY7Eilhd1sHFLwf1zBATk8knRcM72rVx8pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPNIFXYe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPNIFXYe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E23EC116B1;
	Tue, 16 Jul 2024 08:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721119457;
	bh=9uGt9Z44Mxl/cFhlHHXCsK7ZNsrYMJXPfLfUqpYHWsQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LPNIFXYeASCz124Hz4LgOPDS2oUG3r13HVZ18thaQ/EQdGnZDH98E+QhVHCST/goH
	 UzkdPB8CCOSASX65MINbLgrjL4LxJyoq+dVqGmPTtLknZG+uP/XLQN6pOP7HX42GUt
	 NfHYUtue51QpXSC4KXL6bwxRlIbkabwV2OycKo2RSdZZrM3Udz95lIqdLoVlDQusGk
	 8eTv3so0NR2BGCm9zKaYsJdI+t5BfM9ADfD/WHZlO9JzV1aPuUS6MttAhsk7/JTRUE
	 n4eiqDnzbq5a4iaFzOi743fwGXMYVdyInGESBt0Y6oTYwCkXnPM0gcD2/9HldZhLxL
	 DlaxU6EHtEvpw==
Message-ID: <09ef3bcc-bf53-42f9-beeb-a9b74d6a7799@kernel.org>
Date: Tue, 16 Jul 2024 10:44:13 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net 1/6] mptcp: sched: check both directions for
 backup
Content-Language: en-GB
To: Mat Martineau <martineau@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20240711-mptcp-backup-mpj-v1-0-d45506182a9e@kernel.org>
 <20240711-mptcp-backup-mpj-v1-1-d45506182a9e@kernel.org>
 <f0a2146bc7c556c5abbbfa25ce4dd9d3d7db801c.camel@redhat.com>
 <8908adb9-d9fa-4abb-838c-b437800090e7@kernel.org>
 <41a09798-9142-2ffa-7900-481ae7b92506@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <41a09798-9142-2ffa-7900-481ae7b92506@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

Thank you for the review!

On 16/07/2024 07:37, Mat Martineau wrote:
> On Fri, 12 Jul 2024, Matthieu Baerts wrote:
> 
>> Hi Paolo,
>>
>> Thank you for your review!
>>
>> On 12/07/2024 16:53, Paolo Abeni wrote:
>>> On Thu, 2024-07-11 at 17:38 +0200, Matthieu Baerts (NGI0) wrote:
>>>> The 'mptcp_subflow_context' structure has two items related to the
>>>> backup flags:
>>>>
>>>>  - 'backup': the subflow has been marked as backup by the other peer
>>>>
>>>> - 'request_bkup': the backup flag has been set by the host
>>>>
>>>> Before this patch, the scheduler was only looking at the 'backup' flag.
>>>> That can make sense in some cases, but it looks like that's not what we
>>>> wanted for the general use, because either the path-manager was setting
>>>> both of them when sending an MP_PRIO, or the receiver was duplicating
>>>> the 'backup' flag in the subflow request.
>>>
>>> According to rfc 8684 section 3.3.8, setting the B (backup) bit in the
>>> MPJ header """indicate to its peer that this path should be treated as
>>> a backup path to use only in the event of failure of other working
>>> subflows (i.e., a subflow where the receiver has indicated that B=1
>>> SHOULD NOT be used to send data unless there are no usable subflows
>>> where B=0)."""
>>>
>>> I read the above as the path manager should only look at the 'backup'
>>> field?!?
>>
>> (I guess you wanted to talk about the packet scheduler that is being
>> modified here, right?)
>>
>> That's two different things to me: the RFC says here that in the MPJ,
>> the B flag is to tell the other peer that this subflow should be
>> considered as a backup one, but it doesn't say anything about how the
>> current host and its packet scheduler should consider this subflow.
>>
> 
> Hi Matthieu -
> 
> I agree with your interpretation here. The RFC is talking about the
> meaning of the B bit in the headers, but that's not the only
> consideration for the packet scheduler and for our netlink API.
> 
>> Typically, one side knows that one path is more "costly", and should be
>> used only if needed. Then, if this hosts told the other peer to consider
>> this path as a backup one, it makes sense to do the same, no? (anyway,
>> that's what we always did apparently :) )
>>
>> If someone wants a different behaviour for a specific use-case (backup
>> path only on one direction), it can use a different packet scheduler :)
>>
> 
> I suppose someone could be interested in a "half backup" use case if one
> or more links have asymmetrical data rates (like many DOCSIS
> connections). To properly support that we would want to be able to set
> the "backup" and "request_bkup" flags separately using 'ip mptcp' and
> our netlink API, but the netlink API doesn't make that distinction.

Yes, if there is a use-case, the scheduler can be modified to support
this behaviour. This control can be also done via a new sysctl knob,
similar to other scheduler options we have, or via BPF when this feature
will be supported.

> It is important to be able to change the behavior of the outgoing packet
> scheduler by the local host, so I think your fixes are the correct thing
> to do.

Thanks!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

