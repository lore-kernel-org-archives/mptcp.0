Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2827142E439
	for <mptcp@lists.linux.dev>; Fri, 16 Oct 2026 08:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792140210; cv=none; b=ESgB6Pwv+Z7I32J4Abt5aGmMNrA367RquceT7pLdmgIvKb3zriEdLJAOzRc/kdhL3QxDK5IcY1o2siDpkGeuaajzA4l1vsUoEv1s40GKKgJj9Lfr6Zkd9Ld+kb4EktyuIwB6g3eZbtOE77SLd3THgLW2P8JSGyi4SE+/rauJioc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792140210; c=relaxed/simple;
	bh=nZvxVSODBqHrufMD1ojJ+6J/tIRS1ZEkFbtesCvQ974=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h1Jjn1uRqMQUaOKx79Htl3Jm96Y1m8orGw352IJfcsNa/m9LSNHhn/CaRVzwxRF4TPxcpfHbMFA00K8gCyvcn33Du0DE6Ie7OA1gu/efQUqBeEy/OcDNUa1Mam3k2xuwBXHKFM5ELwNUK6DkJW1ImoOjBRXmKY9JvbZT/f23Lqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsugGjHG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsugGjHG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D441F000C4;
	Fri, 16 Oct 2026 08:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792140208;
	bh=r4gsxa/gLaE/ll56SCjbEWGVtoYzo/Wfy3FZv+WFPl0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gsugGjHGyjmG0zQLEjaVznvU1WIDrtrlxBrdnaTWAjoEHgMU8/8NJgSYr69rJqHur
	 SDdAX78Yi6jUMUG/qxh0tk7fNPe8Pyx0R947qUkk/cQcZVmSimoprgArZILsowqjWS
	 Qjsx9NCLE9F+2G+Uj0u65KeRmFSXIntUp43R9ZBqznl65PZrWdF6kJ+qLP9R3HR3hR
	 gsbmFGghHiJq4QXy4qVI4InkXwRA9ltPgkp9MDri6RM8v/2C0ksZelwopBDAR2fgKI
	 SoJvl1tsoKds03qnrPWT9bxEg9BzLsg4TPS4X4VdIvAAiKSkfxjjd9zCs6dklOfLJw
	 kvvrMudN0C4sg==
Message-ID: <7c7308c5-c150-41a1-9d84-9981acfb5962@kernel.org>
Date: Fri, 16 Oct 2026 10:43:25 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH mptcp-next v3 2/3] mptcp: pm: kernel: retry subflows
 closed after an error
Content-Language: fr
To: Anil Kaushik <anilkaushikwireless@gmail.com>
Cc: mptcp@lists.linux.dev
References: <20261014143349.768138-1-anilkaushikwireless@gmail.com>
 <20261014143349.768138-3-anilkaushikwireless@gmail.com>
 <b150dde6-05f1-4e7b-9440-360b7ce17eff@kernel.org>
 <CAG0Mgm_uj70o=R5HnEb0GkTy4FTQK6cy6GHWuO7y2FitzwnucA@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CAG0Mgm_uj70o=R5HnEb0GkTy4FTQK6cy6GHWuO7y2FitzwnucA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Anil,

Thank you for your reply.

On 16/10/2026 07:49, Anil Kaushik wrote:
>> Add a sensible default value (what do you recommend?)
> 
> 15 SYN retries: about 20 minutes with the 120s max RTO.

I guess it could even be longer, no? With an exponential backoff, it's
not spamming the network too much.

I wonder if we shouldn't get something similar to tcp_retries2. But
here, with the syn, we also need to tcp_syn_linear_timeouts into
account. Either we keep it to 15 by default and, (if not 0), we add
tcp_syn_linear_timeouts, or we initialise it to 19.

>> modify icsk_syn_retries instead [...] WDYT?
> 
> Good idea, I will do that: one new subflow per failure, with its SYN
> retries set from the new netlink limit, 0 = disabled. It also removes
> the socket reuse, the retries counter and the 60s check.
> 
> One point to think though, If ICMP unreachable stops the SYN at once.
> I would not retry
> again then. Is that OK?

Good point. In your specific case, what do you observe?

To me, the best is to have the network manager (something from
userspace) removing the MPTCP endpoints when they are not "usable", but
here it can be specific to the destination. I would then say to look at
this case later. In this case, we could eventually disconnect the
subflow, and add a timer to retry later. But that's also more prone to
bugs, so if we can avoid that, probably better to!

>> Do we have other similar ones? [...] ss -Mte, would that work?
> 
> I will drop the MIB counter. The test can use the MPJ counters and the
> netlink events.

Thanks! You can expose the new limit in "struct mptcp_info", instead of
"reserved".

>> Is it specific for your case?
> 
> No, it came from a Sashiko review: a dead subflow waiting to be closed
> could be re-created after its endpoint or the peer's address was
> removed. I will try to move it to pm_kernel.c.

What did you end-up doing for this?

>> can we not check why it failed instead?
> 
> With your idea it is not needed: only one retry, nothing to count.

Good

>> what error do you get when the issue is detected via TCP Keepalive?
> 
> ETIMEDOUT, so it is retried.

Thanks!

>> Why can we not always re-used?
> 
> A subflow that carried data needs the full close cleanup. With your
> idea we always create a new subflow, so there is only one path.
> 
> For the rest: OK. I will go through pm.c, avoid struct holes and
> duplicated connect code, drop the RFC tag, add a changelog per patch,
> and test closing the connection while retrying plus the netlink events.
> I will wait for the netdev Sashiko review before sending.

Thanks! BTW, it is easier if you reply inline here below, to keep the
context:

https://subspace.kernel.org/etiquette.html#do-not-top-post-when-replying

> On Wed, Oct 14, 2026 at 11:43 PM Matthieu Baerts <matttbe@kernel.org> wrote:
(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

