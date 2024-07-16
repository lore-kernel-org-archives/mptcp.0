Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585CF1799D
	for <mptcp@lists.linux.dev>; Tue, 16 Jul 2024 05:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721108241; cv=none; b=M29Ws8ylUyot5YdACqi3E4KVTOo/qhqVS7yDTFpNtdp3syxzM6h1qupOOoJsDfBCxoEisIBmeB6nvyazAjjHGlL85OIy+U5PqRmIMLpFrfjrPcZA8aNvtozObAFlzblDxZnyC/MPHU0ubvUyDpXu1zBkqr3itCh8EXvt3eTqzMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721108241; c=relaxed/simple;
	bh=5iGcl7uzvUDfGFKk2TXWb4cBd7ZzsQjM989OyJZ5Omw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jjYjFO4Ry6+VwwsMbZeLh1l9AWIxh/yAc+mzAZKLyQQDP5FdpHahy5pJPH8Ul1O4fvfIbP4XKueL4OJut4UcmOwGQSAlTDST+Jod3uQ80GhWiMMuu4IX7kne9zwaSTSN8U+Lmb151XYRiZAb7xSr5HtvwrSQ+x2tKzueTK4kLGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1/S9Hou; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1/S9Hou"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C082EC116B1;
	Tue, 16 Jul 2024 05:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721108240;
	bh=5iGcl7uzvUDfGFKk2TXWb4cBd7ZzsQjM989OyJZ5Omw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Y1/S9Hou5wE0BS65IEBhmhmAHFD5JKF5sajY1XlFhr/OzJPMEH0FLUiqRjUtEHFkH
	 mhZ27PkhPknrtYCO2j9uvS4slFK0vUMzsml/cILO9CwJAv+NbnkXnLqcjOGHk1Rfkt
	 D4VU/JPV1KSq+mFvuUIGoLKxvVxwTcfwBbjfanGgxFGFeNZ1EcirmpAw/9CAtWm9ea
	 olOI0/akfiHDUpvf6sljfH5U8mMa/OSKBxkzroM9G7gWYXD4sWFbdgcy0g7kapTtzq
	 h1dfv4OgxVfnnq7wPJyfAfU93LKqYvpTRddDbLOEk9sJDmhDPbZ0g8Oy6Eu5Hn9ODW
	 s1xcZAYyHFw8g==
Date: Mon, 15 Jul 2024 22:37:20 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net 1/6] mptcp: sched: check both directions for
 backup
In-Reply-To: <8908adb9-d9fa-4abb-838c-b437800090e7@kernel.org>
Message-ID: <41a09798-9142-2ffa-7900-481ae7b92506@kernel.org>
References: <20240711-mptcp-backup-mpj-v1-0-d45506182a9e@kernel.org> <20240711-mptcp-backup-mpj-v1-1-d45506182a9e@kernel.org> <f0a2146bc7c556c5abbbfa25ce4dd9d3d7db801c.camel@redhat.com> <8908adb9-d9fa-4abb-838c-b437800090e7@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 12 Jul 2024, Matthieu Baerts wrote:

> Hi Paolo,
>
> Thank you for your review!
>
> On 12/07/2024 16:53, Paolo Abeni wrote:
>> On Thu, 2024-07-11 at 17:38 +0200, Matthieu Baerts (NGI0) wrote:
>>> The 'mptcp_subflow_context' structure has two items related to the
>>> backup flags:
>>>
>>>  - 'backup': the subflow has been marked as backup by the other peer
>>>
>>> - 'request_bkup': the backup flag has been set by the host
>>>
>>> Before this patch, the scheduler was only looking at the 'backup' flag.
>>> That can make sense in some cases, but it looks like that's not what we
>>> wanted for the general use, because either the path-manager was setting
>>> both of them when sending an MP_PRIO, or the receiver was duplicating
>>> the 'backup' flag in the subflow request.
>>
>> According to rfc 8684 section 3.3.8, setting the B (backup) bit in the
>> MPJ header """indicate to its peer that this path should be treated as
>> a backup path to use only in the event of failure of other working
>> subflows (i.e., a subflow where the receiver has indicated that B=1
>> SHOULD NOT be used to send data unless there are no usable subflows
>> where B=0)."""
>>
>> I read the above as the path manager should only look at the 'backup'
>> field?!?
>
> (I guess you wanted to talk about the packet scheduler that is being
> modified here, right?)
>
> That's two different things to me: the RFC says here that in the MPJ,
> the B flag is to tell the other peer that this subflow should be
> considered as a backup one, but it doesn't say anything about how the
> current host and its packet scheduler should consider this subflow.
>

Hi Matthieu -

I agree with your interpretation here. The RFC is talking about the 
meaning of the B bit in the headers, but that's not the only consideration 
for the packet scheduler and for our netlink API.

> Typically, one side knows that one path is more "costly", and should be
> used only if needed. Then, if this hosts told the other peer to consider
> this path as a backup one, it makes sense to do the same, no? (anyway,
> that's what we always did apparently :) )
>
> If someone wants a different behaviour for a specific use-case (backup
> path only on one direction), it can use a different packet scheduler :)
>

I suppose someone could be interested in a "half backup" use case if one 
or more links have asymmetrical data rates (like many DOCSIS connections). 
To properly support that we would want to be able to set the "backup" and 
"request_bkup" flags separately using 'ip mptcp' and our netlink API, 
but the netlink API doesn't make that distinction.

It is important to be able to change the behavior of the outgoing packet 
scheduler by the local host, so I think your fixes are the correct thing 
to do.

- Mat

> PS: note that the ip-mptcp man page is saying this about this subject:
>
>> backup: If this is a subflow endpoint, the subflows created using this
>> endpoint will have the backup flag set during the connection process.
>> This flag instructs the peer to only send data on a given subflow when
>> all non-backup subflows are unavailable. This does not affect outgoing
>> data, where subflow priority is determined by the backup/non-backup
>> flag received from the peer
>
> Which was not the current behaviour, and doesn't make sense for
> "typical" use-cases where the two peers are not controlled by the same
> user. That's how I started to investigate, found out that if the backup
> flag was set only from one side -- what we do in our selftests -- the
> scheduler on both side were treating the path as backup as I was hoping.
> Then I looked at the packet scheduler code, and was surprised to see it
> was only looking at the 'backup' bit, and not 'request_bkup', which led
> me to the other patches :)
>
> Cheers,
> Matt
> -- 
> Sponsored by the NGI0 Core fund.
>
>
>
