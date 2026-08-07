Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE7141DEE5
	for <mptcp@lists.linux.dev>; Fri,  7 Aug 2026 10:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786097618; cv=none; b=U32BJvyDGoZiZLx4t91a45yUajCkzqc5xSbq10BocXOg20ydrj9sBwNJEAbd6IlMa+I2AUWwbg4s1pGdrrw5+iTLGLFKSlFTohl438W7VzTumc78C5vnXt1oFlFoii4xarbfzmrvQAiOX+cJUmvciK5u0KPZRFQ1Buuk3umORpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786097618; c=relaxed/simple;
	bh=jIGrd5q+CVC9/cyiDU/FB0p9Dg2F101uoK2Tom+1G6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sm0u8hlRMscmCxLtMQZn/FPgD06r6sEX4fAQCSkv2PRKNpgABBw0naZhjl4jM3dssq9rdwYg0WN6/XSzwXGDlwLdYvAuCw+hiV49pNXYdjRJ5lFIg/p6E7GIhUz5P4G9JOY/nc5krsuH1S9owiuQnw3iXxyr4Sz1ZQ2IfYMdqyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWspbsm9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWspbsm9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D301F000E9;
	Fri,  7 Aug 2026 10:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786097611;
	bh=Kn1K9NoIPx6TObzihge1lBEmTIoir/jQJbFXDDLyh2Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JWspbsm9t6MP8t3VOT8ik+GeuaaK11EEqW0Iu3AzHyKy9HrCjYgulejn/lsiuizHm
	 yt8q1wHVSDYX8EhzTCRPq868eXruC8wVBfoFvwgpDAjBBl1994JC8sTFhAjSGhNRSO
	 jAgSO6uxWhMa5ClOg9sXJO/z2CYHrewxjZXX8KZeR+Esrj7yEFrY1gBnnsasgp6Pdb
	 DhiRhuOQF7Qo1JzJsjNLQ7s6NYNbqlNXsOviJ7gX7TEGB0pyZfrPNDEs+GUv9SCzPT
	 pBGJkRT+W3HMeAqByzVVQVBaaT5SFQuImrhz4LZkXA6nI0MKh2XUSrLX9mgsc9KLha
	 T/Z2q/llKf7HA==
Message-ID: <51c9e760-347f-4ecb-8661-ab32fc9f0c35@kernel.org>
Date: Fri, 7 Aug 2026 12:13:26 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v5 1/2] mptcp: pm: drop pending ADD_ADDR when removing
 id 0 endpoint
Content-Language: fr
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>,
 mptcp <mptcp@lists.linux.dev>
Cc: martineau <martineau@kernel.org>, pabeni <pabeni@redhat.com>,
 "shardul.b" <shardul.b@mpiricsoftware.com>, janak <janak@mpiric.us>,
 kalpanjani009 <kalpanjani009@gmail.com>, akshit <akshit@mpiricsoftware.com>,
 syzbot+55c2a5c871441261ed14
 <syzbot+55c2a5c871441261ed14@syzkaller.appspotmail.com>,
 Tao Cui <cuitao@kylinos.cn>
References: <20260630150632.899750-1-kalpan.jani@mpiricsoftware.com>
 <20260630150632.899750-2-kalpan.jani@mpiricsoftware.com>
 <19fdb1b1cdd.122b1f65587045.5393804019530024742@mpiricsoftware.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <19fdb1b1cdd.122b1f65587045.5393804019530024742@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kalpan,

On 07/08/2026 09:23, Kalpan Jani wrote:

> Sorry for the long silence on this.

Np, I was overloaded anyway (still am)
> The packetdrill test is now up at
> https://github.com/multipath-tcp/packetdrill/pull/201 - I rewrote it and this
> time validated it in the virtme-docker environment: 3 failing without the
> kernel fix, 3 passing with it, on export/20260622T173908. Your suggestion about
> the endpoint linked to the initial subflow is what unblocked it. Details and
> the limitations I hit are in the PR.

Thanks, I just send some minor fixes, then merged. I hope that's OK.

> Two things about v5 itself.
> 
> First, patch 1/2 is unchanged from what you have. I said I would rework the
> addr argument because the anno_addr copy looked fragile for endpoints with a
> port, but after re-checking I no longer think that case is reachable: the MPC
> endpoint cannot be a ported endpoint, since both __lookup_addr() and
> mptcp_nl_add_subflow_or_signal_addr() compare the port when the endpoint has
> one, and that would require it to match the initial subflow's local port -
> which mptcp_pm_nl_create_listen_socket() binding the same address:port makes
> unreachable in practice. So the entry reachable from
> mptcp_nl_remove_id_zero_address() always has port 0 and clearing it is correct.
> Tell me if you see a case I have missed.

Fine by me.

> Second, and I should have raised this earlier: please drop patch 2/2. The
> selftest does not exercise the fixed path. I used addr_nr_ns1=-1, which deletes
> the endpoint by its real ID via pm_nl_del_endpoint ${listener_ns} $id and
> therefore goes through mptcp_nl_remove_subflow_and_signal_addr() - the path
> that was already correct. Only -9 reaches mptcp_nl_remove_id_zero_address(),
> and the endpoint is 10.0.2.1, so the address check there would not have matched
> even with -9. The subtest passes identically with and without patch 1/2, which
> is why CI was green everywhere, and it largely duplicates the existing "remove
> single address" subtest. Sorry for not catching that before sending v5.
> 
> With the packetdrill test covering the same ground, I think patch 1/2 alone is
> the right thing to apply. Happy to send a corrected mptcp_join.sh subtest as
> well if you would rather have both.

Indeed, dropped.

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

> From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>

BTW, do you mind avoiding top-posting please, it is not recommended on
most ML:


https://docs.kernel.org/process/submitting-patches.html#use-trimmed-interleaved-replies-in-email-discussions


New patches for t/upstream-net and t/upstream:
- a6a9ee8fc58c: mptcp: pm: drop pending ADD_ADDR when removing id 0 endpoint
- Results: fb78b98bf563..4439056e6ccd (export-net)
- Results: 6f0836d81132..e8891858656d (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/420be436959ff2164ff3087f88e6a9756d485436/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/c808c1fcb72b4387c5d2193a4c69f387d5a7e881/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

