Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792941146;
	b=xnxZe/g0BVWqmR6ClTgdaX4Mgrwbz/MxSyuuQuWNZy9GQWP5x6eVE/nNUbd6haQlT3iH
	 mAPb0TSDiwP6OORYugYlYPDynFvO0/028/7NtuInRKj8bq8QCylSlaoecbZrSjQrtWVwZ
	 EoK4Rs5veXPDPHupv2V2Jfltt2Cx7fmCjpQNie56pUFghuT2HySJ8zRvQvigfkH+wwhOB
	 5dSAnU+Gq79GrXWy/+5QXROTGdJc+/MPKKADzF4cEGd3dHm4E9AEaC7I9yutxgFHXHW6b
	 VlN67FDBUtxuCwzvIxjn18b3R1Eh4v/47eES4TfcyKtZPmgdo3njxhzGSYDNPaJSESA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792941146;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=vaNa7aNsyuGbWys8c3YAUqrzkr+8XFTTZYz0MDqNKUU=;
	b=SSoPreA3KdCyn6ixOWXemWDpyBod1qkHZ4tH50klbZi8oNcIesceZlPz5LoMvH3KlSGo
	 mSkaa+NUYAz2iTR70OKWvsdBqpwX57eCDZHNa397Lgt4d49qFl/Em+XB2Ay0g48DSGFq9
	 6Zz9223s5xTqht77QRRvux+63hgKJuhS24v55zEmejSHIZLTxrNeNcyxWqRXuPPx/fM8s
	 tOIn89LnrVlEg24MD93wZ88MAzVFkRhzTZdltjR0m2tt6VWnavyBUNqGCvUvjGifN7tIm
	 7sc0A38W5qy2A0tLQrYUTh0ZHgAKizKT7m85Uh++wytvqQl1KFnm0+XdsuIP7FM0FRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GLi2RU+u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB85606A31A
	for <mptcp@lists.linux.dev>; Sun, 25 Oct 2026 15:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GLi2RU+u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67351F01825;
	Sun, 25 Oct 2026 15:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792941146;
	bh=vaNa7aNsyuGbWys8c3YAUqrzkr+8XFTTZYz0MDqNKUU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GLi2RU+uK5LyctJB0dF+6ws8/avb4t6ACYrCBFABPTH5VHc8pG3LoEJKWzmQcaIja
	 B0h0RSuJdOsyMW5L9NbqSYtRER0YJwL5DXD7foVgvCAKp8tVpqyK2YXGy4fdhOUr53
	 /UC/t4ZP9vWKPqqm69brIAmXISVEYE9eQ0A+g3AUe3ZE8ns3+dONnlGTdtSPEv2y9y
	 S6NKo/WCkfhc3P13VVsicmlW8gpOIorgZWb525uRHn8jlt01bOK24SYAqerrUOuaMh
	 p9Or8wEXKnjDfX8erowley2gsYEKaMMMna7KvzBfLmO/M2YRlvsDO7x3RQU+eQP+bd
	 cbfq+l8k0Ee2A==
Message-ID: <5e0ccd66-205f-4055-8ab3-4d300e83fd48@kernel.org>
Date: Sun, 25 Oct 2026 16:12:21 +0100
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH mptcp-next 0/1] mptcp: opportunistic reinjection on an
 idle subflow
Content-Language: fr
To: Abdul Wasey <w453y.me@gmail.com>, mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Shardul Bankar <shardul.b@mpiricsoftware.com>
References: <20261025134643.1537069-1-w453y.me@gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20261025134643.1537069-1-w453y.me@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Abdul,

(+cc Shardul)

On 25/10/2026 14:46, Abdul Wasey wrote:
> This is an attempt at issue #332, the "opportunistic retransmission" of
> section 4.2 of the NSDI 2012 paper, which the out-of-tree kernel had.
> 
> I found it from a multi-WAN router: a fast link next to a slow one gets
> much less than the fast link alone, because data sent on the slow link
> holds back the DATA_ACK until the receive window or the send buffer is
> used up. With the default tcp_rmem, a 400 Mbit link next to a
> 15 Mbit/240 ms one gave 67-82 Mbit in total with BBR, and 30-142 with
> CUBIC. With this patch it is 320-345, and uploads gain the same.
> 
> When a DATA_ACK shows that no new data can go out and an active subflow
> is idle, the data the slower subflows hold is resent on it: the ranges
> from the DSS mappings in their queues, not everything from snd_una. It
> only does so when the copy can arrive at least one RTT of the idle
> subflow sooner, and no more than the idle subflow can send in that time.
> Without these limits it cost about 1% on simult_flows.sh's unbalanced
> cases, and even waking the worker for nothing showed there, so the
> decision is made before scheduling it.
> 
> A subflow that had a retransmission timeout and no progress since is
> left alone: the copies would keep the MPTCP-level timeout from firing,
> and with it the stale detection (mptcp_join.sh's "multiple flows,
> signal, link failure" caught that).
> 
> Tested in netns on the current export, against the same kernel without
> the patch: nine 2-path cases with BBR and CUBIC, 6 and 32 MB tcp_rmem,
> uploads and downloads, 3 runs each and 16 for the slow lossy path.
> mptcp_connect.sh, mptcp_join.sh (twice) and simult_flows.sh (16 runs)
> pass as they do without the patch. The 2-path cases, mptcp_connect.sh
> and simult_flows.sh also ran on a KASAN + lockdep kernel, with no
> report, and on a KCSAN one, whose reports are the same data races in
> mptcp_subflow_get_send() and mptcp_subflow_active() that it shows
> without the patch.

Thank you for working on this.

That's indeed something we need to improve.

Before replying to the questions below, I think it would be good if you
rebase your work on top of Shardul's one:


https://lore.kernel.org/20260911-mptcp_penalise_send_v2-v4-0-820f2be4a8fe@mpiricsoftware.com

Note: this work looks good to me, but I was waiting for external reviews
(because I helped a bit) before applying it (and other urgent fixes/work
kept us busy...)

> Questions, since this is an RFC:
> - It is in the core, for every scheduler. Should it rather be a
>   scheduler hook (#344), with the default scheduler using it?

Yes, I think it should (and moved to sched.c), but having a wait for
others schedulers to re-use that. At the end, that's a decision a
scheduler can take depending on the use case. But we want that by default.

When discussing #332 with Shardul, it was clear that the current MPTCP
packet scheduler API is not flexible enough to stop sending on one
subflow and force a reinjection on another subflow. I think it would be
best to take over the following old series, rebase it, address the
comments, and validate it:


https://lore.kernel.org/all/20240527-sched_per_packet-v1-0-09a41d405f7c@gmail.com/t/#u

Once it is there, I think it should be easier to modify the scheduler to
force a reinjection, e.g. set a flag to stop pushing, then find a way to
force using another subflows (e.g. the stale flag or another one). WDYT?
Also, if this work is in place, it would help to add BPF support for the
MPTCP packet scheduler.

Note that I don't know if Shardul is still looking at that. (BTW, sorry
for delaying the work you did with #345 ... note that, in between, I
managed to get Clashiko (Netdev Sashiko) doing reviews not to be blocked
when upstreaming them: so probably we should also check what Clashiko
thinks about this series by resending the last version, to "be prepared"
or to fix issues if any we missed during dev/review).

> - The rules (slower, one RTT of gain, budget) come from my tests. Is
>   there a better signal to use here?

I guess imitating what the old fork was doing is a good starting point.

> - mptcp_oppr_check() runs on each DATA_ACK and reads the other
>   subflows' queues and RTTs without their locks: is that acceptable as a
>   heuristic, or should it be done differently?

Was the fork not limiting this to once per RTT? In any cases, it will be
needed to measure the impact on high perf transfers.

> - I could not find a short simult_flows.sh case where the stock kernel
>   is clearly slower: the stall needs a few seconds of traffic to build
>   up. Would a counter based test (OppReinject moving on a lossy slow
>   path, with the data checked) be enough?

I'm (still :( ) working on a perf lab that might help to measure the
behaviour in different conditions. Would that help here? I don't think
we can have such tests in the selftests: stability needs to be measured
on long runs and in "stable" environments I guess.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

