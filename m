Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C48E37CD20
	for <mptcp@lists.linux.dev>; Mon,  6 Jul 2026 15:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783350469; cv=none; b=IgOmVX/gVVz2Swdz61ZrkUEFWShdzdZlFSf77imQF03xdgRTI9KMt5KdMuifRiAxtoTc5LFbYl1OZGLzzvzFH/w/i/bID45C5y2KjfAsTA3wCLPvLkWSftyrg3jfdkWaj+Ub6cCBX91x1ZsxD0slMIfbzuXbuXIInXJkqJTDET0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783350469; c=relaxed/simple;
	bh=dagzFoxf2pMZVfGjGf0T46LtGX3Rtygp8nZpz3V1zQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l1ZQGEq3aJENr8DeDq8dZJzojCc5Mcj//0AW4yi+Ee8enaguUP5ysDjt3iA6f6OzsQY37OHN1XUbii9tgzZb/L7KReZjSk8jtMgsYe3J/ra55Qb4WDSdZAXglfIL4ky9o6Q7l5/7t7ATnP5oCEtTBHV6m1OXYBePYelpbFLJrdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kk/uXFCO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kk/uXFCO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0A41F000E9;
	Mon,  6 Jul 2026 15:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783350467;
	bh=X1QgJqjjS3k0ii9I4cU9Inqo6zzrbVmibV/P46QbOuU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Kk/uXFCOw3WhR9Tz/gJp2Nc8NyE9xcfMZADgfPEHtk+v227QS81J9lY8VYfv/zN/F
	 stwC9fxVe1U3K3/vaEZShYlfHqqOnvJleO6KpP2lvZcgg5Z8wbuGen8ubvM919bUzL
	 WkByuEn4EelP8RLyLcQXZJN5OOo7uYnG1gfrwHjBKPreWxkXbjS+faOm5BeGDr6GGu
	 CPa8XkPeyApiZJ0YrHQRvXKtgpd9umjmnnlk2eHYc82jxAbUlPuyxGFQkAdcr3ibPm
	 FwL/X/ZZX5Kxab5cIqbT5bhzfwlGcL+l7WxKnyOWX0kQGz2jY9yqWXOP78ohsOJLj/
	 UZZuMd3N7mAWA==
Message-ID: <775e5b9e-2f00-4316-a5a2-5a333c44ae20@kernel.org>
Date: Mon, 6 Jul 2026 17:07:44 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2] mptcp: fix extra_subflows leak on failed
 passive join
Content-Language: fr
To: Geliang Tang <geliang@kernel.org>,
 Chenguang Zhao <chenguang.zhao@linux.dev>, mptcp@lists.linux.dev
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>
References: <20260630095432.1340629-1-chenguang.zhao@linux.dev>
 <20260701032011.358940-1-chenguang.zhao@linux.dev>
 <86e9b7f9ac5d630a0bb7b127652544176921a491.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <86e9b7f9ac5d630a0bb7b127652544176921a491.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang, Chenguang,

On 01/07/2026 08:32, Geliang Tang wrote:
> Hi Chenguang,
> 
> Thanks for this v2. However, if there are no code changes, there is no
> need to send a v2; we can just reply to the email thread on v1 to
> discuss it. 

Indeed. Also, it is easier if you start a new thread with a link to the
previous version, than replying to a previous version.

> On Wed, 2026-07-01 at 11:20 +0800, Chenguang Zhao wrote:
>> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
>>
>> mptcp_pm_allow_new_subflow() increments extra_subflows
>> before __mptcp_finish_join() on the passive MP_JOIN path.
>> On synchronous join failure the subflow is dropped without
>> calling mptcp_close_ssk(), so the counter is not rolled back.

What do you mean by saying "On synchronous join failure"? When I look at
the packetdrill test, we are not talking about synchronous MP_JOIN (SYN
+ MP_JOIN packets in both directions), right?

>> Call mptcp_pm_close_subflow() when the join completion fails.
>>
>> Fixes: 3e5014909b56 ("mptcp: cleanup MPJ subflow list handling")
>> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
>> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> v2:
>>  Hi Matthieu,
>>  Thanks for the review.
>>  - I spotted this by reading the code. I don't have a reproducer
>>    yet. I also see we already have a Packetdrill test for
>>    synchronous connect failure (simult_connect.pkt), but not for
>>    synchronous join failure. I'll add a similar Packetdrill test
>>    for that case and send it in a follow-up patch.
>>  - Add Fixes and Reviewd-by tag.
>>  - I looked again at the history, and I think the Fixes tag
>>    should point to 3e5014909b56 ("mptcp: cleanup MPJ subflow list
>>    handling"), not 10f6d46c943d ("mptcp: fix race between MP_JOIN and
>> close"). 
> 
> The Fixes tag is incorrect and should be 10f6d46c943d ("mptcp: fix race
> between MP_JOIN and close"), because that commit introduced the call to
> mptcp_pm_allow_new_subflow. There is no need to send a v3, as this can
> be updated when applying.

+1

> I have changed the status of v2 to "Queued" and v1 to "Superseded".
I will wait to get the packetdrill test ready before applying this patch.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

