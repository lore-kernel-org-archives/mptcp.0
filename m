Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE8F4A4F0F
	for <mptcp@lists.linux.dev>; Mon, 12 Oct 2026 17:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791826059; cv=none; b=sqLR2Be5bOLOjNB/zb9j3+LOFXktUHxW1gwwGxCZo2C7ctB4WupW83QhUqVviVBoWDVCPThCkATYQB/KX3x00HK4AZVBjiEB5x3hYxcSqOI24fP3Sn91zre6Tl2bcbl2mG9ul88IBC82Lqx4iyDSOyuKnr9muZCmB3WecDnhV0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791826059; c=relaxed/simple;
	bh=l1DN3AVt6+5z9FAciybadbD/Lgb/nOu0u/tNGFIza0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qjnN7hJ3n1HUuQVz6upWi5B83L97E57Bku5tR38rCHtYMX3eLNXGyREKb1YsekkBQVKyyHas98vcRxz+oCXne4kOsRVmmOsf/9hWYLSw52qX9Wi+WhUx6kGHA9+9FOiJoKiQVMKP3r8it7E+wsBO0vL6wfkenlWALKtgRaAddjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTsLtdUC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTsLtdUC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514441F0089B;
	Mon, 12 Oct 2026 17:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791826057;
	bh=QlOorQ8KuSPQTAHIlQlG6dG5mVSs/A71eI4SofobY3A=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=nTsLtdUCILbAUFxQdKNi+/pEPX3zlBr2UPhVmA2nUdxMYPXHSTmMDBStGi83jLQm5
	 ygHf3274sS1NL8Hxq5YNxK0rPbpfTuTKFlfeDqaduxX+VLtZFzMGWfKw4FikxNpSze
	 BWZBpI/8lQ1BmE3A4eSWkKs7iMcHCvkX5sdfNWGGa6AD5pvMSEODKBmZ/MkAs9KnXJ
	 UwrAFk53E6k21w3mte7nSEcw4IUJk2S0w4cNi1eZAuiRq+na6TKPP4sqxl71LFNZfo
	 ph9V2UT3jXPnHf349JUVy1T1esK+81glrjlWtSQRHa+qpDp+1JlqcuPDdRumqcY8Xd
	 gOPFYM/Cgu+EA==
Message-ID: <b487095f-b583-4388-8274-d8ea5c3851f3@kernel.org>
Date: Mon, 12 Oct 2026 19:27:35 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH mptcp-next 0/3] mptcp: pm: kernel: retry subflows
 closed after an error
Content-Language: fr
To: Anil Kaushik <anilkaushikwireless@gmail.com>, mptcp@lists.linux.dev
References: <20261012171740.464517-1-anilkaushikwireless@gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20261012171740.464517-1-anilkaushikwireless@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Anil,

On 12/10/2026 19:17, Anil Kaushik wrote:
> With the in-kernel PM, a subflow closed after an error is never
> re-created, even once the path is back (#440). For example, with fiber
> as main link and Starlink as backup, connections never return to the
> fiber after an outage.

Thank you for looking at that. Here is a quick review (based on the
preview you sent earlier). I might not have the opportunity to do more
before November.

> Patch 1 fixes a selftest flake: write() can return EAGAIN after POLLOUT
> when a subflow closes.

When did you see this? With the other patches applied or before? Just
wonder if this is worth backporting this, but I don't think I saw the
issue before (or maybe it was very rare). Maybe we would need a Fixes tag?

(The "Assisted-by" tag is only used on this patch, did you want to add
it on the other ones as well?)

> Patch 2 adds an opt-in sysctl, net.mptcp.subflow_retry_timeout, to
> re-create such subflows with an exponential backoff.
> Patch 3 adds the selftests.
> 
> Questions:
>  - sysctl, or an endpoint flag?

I still need to think if this should be a per-endpoint setting, or a per
netns one. I guess people might want to use it by default, and disable
it in some cases. Possibly this would need to be disabled per endpoint
with a flag, I don't know. We might not want to dynamically react when
the flag is changed, (except if this is really needed): that caused
enough issues in the past.

With a sysctl, it is a bit "strange" because we have in-kernel PM
options that are all configurable via netlink (ip mptcp). An alternative
is to have general settings per netns configurable via netlink, similar
to how the limits are configured. (In fact, that can also be an extra
limit in fact). Maybe later, we could have a flag to disable retries per
endpoint.

>  - the re-created initial subflow counts in the subflows limit, OK?

The "subflows" limit is for the extra subflows. So yes, if you have 2
paths with 1 extra one and the initial one is recreated, it now counts
as an extra one.

>  - should retries stop after some attempts?

I guess this should be similar to what TCP is doing with the "retrans"
parameters: set a maximum number of attempts. No?

We usually try to reduce the amount of data stored/copied here. I'm not
a fan of these new entries: here, a re-connect will already retry a few
times before giving up (depending on syn_retries). We will need to deal
with two ongoing timers, that doesn't look good. Can we not instead only
deal with subflow sockets and their timers? If an attempt fails (and the
socket creation timer is stopped), retry later with the same socket?

Now, regarding the code, if it is specific to the in-kernel one, it
should go exclusively to pm_kernel.c: pm.c is for shared code between PMs.

For the selftests, maybe better to use netfilter to block links instead
of TC? Maybe can you have a single test where there is a failure on the
extra subflow, then on the initial one? Try to have a "quick" test, it
is not clear how long this one takes, but it would feel better to run a
very long connection in the background, test what you need to test with
the 'wait_*' functions as you did, then stop it, similar to what you can
see in many tests from "endpoint_tests".

Regarding the tests, just in case, there is a docker image to help you
there:

  https://github.com/multipath-tcp/mptcp-upstream-virtme-docker

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

