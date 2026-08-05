Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931B814A4F0
	for <mptcp@lists.linux.dev>; Wed,  5 Aug 2026 10:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785924846; cv=none; b=cALiH7IG3JoLC0QqWLDftjMzZnEYAovJ3jFJHUXHkXnu6iOMfS9O9ZN8kPydnLQAuzsxTM03pL26SDJj8MlZjt402UPmYNp1dQKttEtnx/3CgsyOyekGsMu/u3VY3xT80zSoxro8sttfyvKqN4V5HQcK2jYk8UMGir7F2bp6KaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785924846; c=relaxed/simple;
	bh=2HDx2logOiqRR6DL3sl8lLzk1Ngng7CtW+Uiwmiw33k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QdFPsquYdKyexgqOQmirkloY99HNyf3skEYOB05qw9rNXP/KpMZGgBfBl2a2YrlzMyYLTj/uqnr72Tc4uN66kRo0yIB3rR9Q1r5fDO8tqPk3l1QSXse0fQlNZXIfCaOR0SHMqiG2G16L9NvW+kv0jMBu/dWxnuf9RaRe/KaXUDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A99jD6rm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A99jD6rm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991791F000E9;
	Wed,  5 Aug 2026 10:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785924845;
	bh=oIyhFDrY1v4ntVivnpgCKKDABNTc4nsVznbhN1FohhY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=A99jD6rm/gqC+9Zh29fYz0fHaGos/fC+wEgtqrQj38KyMaot4aAuW8xhEC88f7re6
	 5ufYOgtm5+nkfZclXzPcogsaiVGsByzQrfYtYgRJXX4IiIoZI/cQcQp1FwKbopJAxP
	 N4PJuszV5CndGskVNGHFredHBcKEPbGzzyAPVm4GvNyvOjCC9jWuizCvfOjsQTT5Ay
	 LHvkdd3su/PWYDpQe3VP93N5qBio6B//dI0FPnR6ozOK8zdzgbD49CruyS42+ao8Eh
	 jIQIw+w2dqvzFSy80oDctSZaVR/FYTtQMIS99mJNbLiz2K753NB8EhdjEH5S5C/Oin
	 tRcaIMuSUItZQ==
Message-ID: <4d1d85f2-7654-4e81-80f5-4955d3cd1e95@kernel.org>
Date: Wed, 5 Aug 2026 12:14:00 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v4] mptcp: honour configured min/max RTO in
 retransmit paths
Content-Language: fr
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>, mptcp@lists.linux.dev
Cc: martineau@kernel.org, pabeni@redhat.com, shardul.b@mpiricsoftware.com,
 janak@mpiric.us, kalpanjani009@gmail.com, Li Xiasong <lixiasong1@huawei.com>
References: <20260805063956.3052563-1-kalpan.jani@mpiricsoftware.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260805063956.3052563-1-kalpan.jani@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kalpan,

On 05/08/2026 08:39, Kalpan Jani wrote:
> The MPTCP-level retransmit timers (DATA_FIN retransmissions and the
> fallback timeout) used the hard-coded TCP_RTO_MIN / TCP_RTO_MAX
> constants, ignoring the tcp_rto_min_us and tcp_rto_max_ms sysctls.
> 
> Make them follow the sysctls instead: seed icsk_rto_min / icsk_rto_max
> on the MPTCP socket from the per-netns sysctls in __mptcp_init_sock()
> -- the msk does not go through tcp_init_sock(), so these fields would
> otherwise stay zero -- and read them directly where the constants were
> used:
> 
> - mptcp_set_datafin_timeout(): both the backoff cap computation and
>   the resulting timer_ival. The two sysctls are validated
>   independently, so rto_min > rto_max is a valid configuration; keep
>   a max_t() guard so ilog2() is never called with 0.
> 
> - __mptcp_set_timeout(): the fallback when no subflow timeout is
>   available.
> 
> The icsk fields are read directly instead of using the
> tcp_rto_min()/tcp_rto_max() helpers: the MPTCP socket does not perform
> routing lookups in these paths, so the rto_min route metric checked by
> tcp_rto_min() can never apply here. The TCP_RTO_MIN_US /
> TCP_RTO_MAX_MS socket options are not supported by MPTCP setsockopt()
> either; this can be revisited if they get supported on MPTCP sockets.
> 
> The remaining uses of TCP_RTO_MAX in net/mptcp/ctrl.c (default
> add_addr_timeout) and net/mptcp/subflow.c (MP_FAIL timeout) are
> intentionally left unchanged: they use the constant as a default
> duration, not as an RTO bound on a retransmit timer.
Now in our tree:

New patches for t/upstream:
- 3dcc47c54bb6: mptcp: honour configured min/max RTO in retransmit paths
- Results: 570d3b306aec..0715f5ba093a (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/810cb9f0a83e758a5e310b4dc7248b5d7cec76bc/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

