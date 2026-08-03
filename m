Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED6235E94E
	for <mptcp@lists.linux.dev>; Mon,  3 Aug 2026 17:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785778503; cv=none; b=tAJWATiatiFPxCkP3IVPBUo/68lD7Fi0MJ3sbpOGjIkeFnKzeApywStzP7ZO8KuzArzlw4HgzfNdrYC4JMsia88JS3iBnVuMw7lakXs2kgqOVJIBqoyCPvsMMD5kFxPRj3RR1YLlm9iK295+3HD1MfXHeVv6qM6uR/ScwqtvFE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785778503; c=relaxed/simple;
	bh=QxPvw7Nijm3Qi3YEMTi+zGw28LL6ynttElpeoxIIhIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IILFuHUhzXqTXeDixx+rM2r0D79z6RxPcZG9kSRvlVzzkwIGrtjYr3xM+x9IBuxqYIRdeE8b0RKcifT7fDmrjVTknyoJD8ncMiNY8nhPi4MBa6kuy5h9rF3dJz0pA9EUMpwjddNFps026PtuH4JY4F45zLbfpAhY37CTktZtaK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g72Eg/oq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g72Eg/oq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6701F000E9;
	Mon,  3 Aug 2026 17:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785778502;
	bh=OvrwhJv1F+iQDn8JGmzHLxFVvv+pqHUnf6c82vFn8ko=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=g72Eg/oq9JhK/GscLCKzLJNJ3M4qKMpFgNnbP91v8EWiYPGEenWeC28As/bEFIvAv
	 +ESitiKz4OiBdzCgq1Dh0II33PlNZfQs+RMJIz/4dSOJB3XpYAh57yUzBN2Ul9qlX1
	 5AaqBE6L+QFlNS6MTZyXeSWyOZbMFD9RX04sEEqoEG3g5DcwLvXWEsfwdq1dL+wgIn
	 5kLkzHd19t+2htBpQnyzTAspEi1G7HxNqyvWhZ304UWB1SETU1wOpoZWO9xjuULzDr
	 Sjx9WIrJQAoYejcEpVlozHowcRmjikgXMg7YvIxGAaSNCC/pY0a9G+IQPiv4tdttp6
	 An+1vH4zYh20A==
Message-ID: <b47803d8-d192-46bd-97de-da4baa74fbc0@kernel.org>
Date: Mon, 3 Aug 2026 19:34:58 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3] mptcp: honour configured min/max RTO in
 retransmit paths
Content-Language: fr
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>,
 mptcp <mptcp@lists.linux.dev>
Cc: martineau <martineau@kernel.org>, pabeni <pabeni@redhat.com>,
 "shardul.b" <shardul.b@mpiricsoftware.com>, janak <janak@mpiric.us>,
 kalpanjani009 <kalpanjani009@gmail.com>, Lixiasong1 <lixiasong1@huawei.com>
References: <20260617114508.253716-1-kalpan.jani@mpiricsoftware.com>
 <19fc5f77283.636e19ae49491.8985382660057875751@mpiricsoftware.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <19fc5f77283.636e19ae49491.8985382660057875751@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Kalpan,

On 03/08/2026 06:52, Kalpan Jani wrote:
> Hi all,
> 
> Gentle ping on this v3, sent on 2026-06-17:-
> 
>   https://lore.kernel.org/all/20260617114508.253716-1-kalpan.jani@mpiricsoftware.com/

Sorry, thank you for your patience. The priority is on the fixes, and we
are trying to go through all patches when we can. But I admit is way
longer than usual.

> I didn't get any CI results or review comments on it, so I want to
> make sure it didn't get lost somewhere. As far as I can tell it was
> sent to the right list with the right prefix.

It looks like the CI didn't manage to send the notification. I restarted it.

It looks like the AI review was available:


https://sashiko.dev/#/patchset/20260617114508.253716-1-kalpan.jani%40mpiricsoftware.com

I guess at least the commit message should be updated, because the MPTCP
sockets do not perform routing lookups. It could only do it when a
subflow has been selected, which is not the case in the cases you
modified. Same for the socket option: it is not available yet.

Also, maybe better to directly use icsk_rto_{min,max} to avoid
confusions, no? By doing that, you can remove the exception for "ip
route ... rto_min 0" that doesn't influence anything here anyway from
what I understood.

> Happy to rebase and resend as v4 if that is easier, or to rework it
> if this isn't the approach you'd like for issue #618.

It would be good to have a validation for this. Because it is
time-sensitive, the easier would be to do it with Packetdrill. Here, no
need to create a new one, simply extend existing ones, e.g.
mptcp/dss/dss_fin_retrans_* → we could set the tcp_rto_max_ms sysctl to
have a shorter time, no? If at least one test is modified to validate
your modifications in mptcp_set_datafin_timeout(), that would be good.

WDYT?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

