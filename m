Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793644642;
	b=JUE8k3mZTwJl+V2UUfdDw3fgqBffFlEkoWtXoDh4aVS4Q78YsfdVXD+kZemGI9P4UNm/
	 JbMQSlueynjFSvX6GJ61YvL2yjl5gTHHZc47uxo3CGDQUpnfstBQdV0tnH3tlQYmVjBSP
	 zIf2M4V7nzbVO7Ubu6nwK9wZW9lfPEIqSVpWwNNLQQ76j7Dt9Bw8Pkd24AulIoMWIsxFa
	 2/bLtCJJLM9DHDSEcwr0Z6SJazyZf7TNmjN7IQw8RnmQZLy8CHe8lzsyDZuKN4eUuP3sp
	 ueT0v+Z0WLYLwmC4uVBv9VlEg84AnI23+tk+2jgVtx4cNQLOT6eecqdWMKQ6oZJfN3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793644642;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=7Vj6VEkb09HDpE3bTc9wyTUrFrzv7GTaDWeqHSvwUYc=;
	b=HRLRdr7tHUBgVZBi/qlxOorFT4rvLACUljc2INYSxoYC7SB54NvyKjZHkLkOGoualuN9
	 iu4FWt/RXpnGwMwKDgX+eUmjJgv/jofmOmwqmTXUVru53SZdc46yibf5LfcINeq4dSvLk
	 ZLHmqn5L/lxWB56undOu6POdxdPGYhyWjHP4sJfIeqnFpShehTcglZIcZXLGSFwgPaBCw
	 kMjR3YVucGZz/AS+bbmCQOW/Qw+NUcdqlwIGVI/vO0FhoBhTVaTvdvLlqyMkg9+fdYjyO
	 PYw4wt4GZiKotL3qTKeyBgh2QEoBI56jjX9NOxpf9x9/M0ovGs8WDWFGfBTOSeTxExA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WDY2ujiH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0F0606A324
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 18:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WDY2ujiH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E19A1F00A16;
	Mon,  2 Nov 2026 18:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793644642;
	bh=7Vj6VEkb09HDpE3bTc9wyTUrFrzv7GTaDWeqHSvwUYc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WDY2ujiH9JzzyoaHvav+iHi6Pr7OByy82rZX725HRXX12Xfp1J1FXeM7b6+3ovqz3
	 GpKHB8Uw+uU8l3LPIkwiwG9dy+1eOKrzk5luaieGPfjHFhVQXnkg1gXUdnkrePU0Uv
	 L8VyxN3FdRR7AQXp56R0Ze7UOXrqhHhhQE6r7GKvaqDtUtYAW2hRi0jznIBqfTK2S4
	 ztOwwzq0Hv846496fHkE5t8jh7JuQQaFYnrojDlk6Rh0n5KeDRmSji8mUfZ0sBH+tH
	 0JrWxGnMeD6YuNGDdZaPkZvKOIjRzC/bgVUhVBB9ZmxqKIc5ZxompHZUEeQZwJT0fW
	 6+eb7re/Skmhg==
Message-ID: <7da5435c-bddf-4134-8fa7-1df661fa1046@kernel.org>
Date: Mon, 2 Nov 2026 19:37:19 +0100
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
Subject: Re: [PATCH mptcp-next v5 0/4] mptcp: sched: penalise a slow subflow
Content-Language: fr
To: Shardul Bankar <shardul.b@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev, Janak Patel <janak@mpiric.us>,
 Kalpan Jani <kalpan.jani@mpiricsoftware.com>,
 Shardul Bankar <shardulsb08@gmail.com>, Abdul Wasey <w453y.me@gmail.com>
References: <20261028-mptcp_penalise_send_v2-v5-0-32fb379ce117@mpiricsoftware.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20261028-mptcp_penalise_send_v2-v5-0-32fb379ce117@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Shardul,

On 28/10/2026 12:15, Shardul Bankar wrote:
> A subflow that is slow relative to the others can soak up connection
> resources and cause head-of-line blocking of the aggregate stream. This
> series lets the packet scheduler send less than such a subflow's
> congestion window by halving it, and leaves the congestion control to
> raise it again. It implements issue #345 [1]. This is a deliberately
> simple first form.
> 
> - Patch 1: a prerequisite fix. The scheduler truncates the pacing rate to a
>   u32, which skews subflow selection on fast paths (Fixes).
> - Patch 2: penalise a slow subflow by halving its cwnd, triggered on its
>   pacing rate and gated on the fast path being cwnd-limited.
> - Patch 3: skip the penalty when the transfer is receive-window-limited,
>   where it would otherwise slow the transfer.
> - Patch 4: MPTcpExt counters and a dedicated mptcp_subflow_penalise
>   tracepoint for observability.
> 
> Validation, baseline versus this series (test helper, its run_matrix.sh
> base-vs-patch driver, and run steps are in [2]):
> - No regression in the mptcp selftests.
> - No regression versus baseline across the buffer-limited transfers
>   (send-buffer, receive-window, both, sndbuf>rcvbuf): the two-path completion
>   time with the penalty enabled matches the unpatched kernel. Where the
>   slow subflow is beneficial (send-buffer-limited), the two-path transfer
>   stays faster than the fast path alone.
> - Patch 3's gate keeps the penalty from firing when receive-window-limited,
>   where halving cwnd would slow the transfer.
> - With a bufferbloated slow path, the penalty roughly halves the slow path's
>   queueing latency (subflow srtt), with the transfer time unchanged. It does
>   not reduce the aggregate out-of-order volume or move data off the slow
>   path; that is the role of issue #332 [3], and the two are complementary.
> - The conditions above do not catch one case: with the buffers left to
>   autotuning and a subflow that is slow because of latency rather than limited
>   bandwidth, penalising it costs throughput, and the cost grows as the added
>   delay grows.
> 
> Used LLM for design, review, coding assistance.
> 
> [1] https://github.com/multipath-tcp/mptcp_net-next/issues/345
> [2] https://github.com/shardulsdk-mpiric/linux/blob/e0f78406d921/tools/testing/selftests/net/mptcp/mptcp_sched_penalise.sh
>     (run_matrix.sh + runs.conf are alongside it in the same directory)
> [3] https://github.com/multipath-tcp/mptcp_net-next/issues/332
> 
> Changes in v5:
> - Rebased on the current export; no code change.
> - Dropped the Assisted-by tags, which the kernel docs no longer describe;
>   tool use is noted in this cover letter instead.
> - Collected Abdul Wasey's Tested-by, thanks:
>   https://lore.kernel.org/all/20261025192320.1831707-1-w453y.me@gmail.com/
> - Link to v4: https://patch.msgid.link/20260911-mptcp_penalise_send_v2-v4-0-820f2be4a8fe@mpiricsoftware.com

Thank you for the new version!

I just noticed that Abdul's v2 series that I recently sent [1] didn't
get reviewed by Clashiko because it doesn't support dependences yet
(Sashiko does) [2]. Just to avoid both working on the same thing: are
you already working on a new version addressing / rejecting the last
review comments sent here? No rush at all, but if you didn't start yet,
and you prefer me to look at it, I can try to do that this week. I would
then send a version including your patches with fixes (if I can) and the
ones I recently sent. Otherwise, there is no urgency, and I can wait.

[1]
https://lore.kernel.org/20261031-mptcp-sched-opp-retrans-v2-0-e9c4a30f6841@kernel.org
[2]
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261031-mptcp-sched-opp-retrans-v2-0-e9c4a30f6841@kernel.org

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

