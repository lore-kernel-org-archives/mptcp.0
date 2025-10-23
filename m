Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDDF272E41
	for <mptcp@lists.linux.dev>; Thu, 23 Oct 2025 06:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761201472; cv=none; b=gRRl+feyZx0iRzV2rQ2HxxEZ6NwzBw65MnzVbMKEpkxnVHcPIrCXfMEpyZ2d0naZEz9F9kVtPsDD3jrmKVYFmvYHg9ljPsY4TdKwYm5n4Xfj+0/rV5ufb1qfKtl19jn4LKBIUGpA2O6vI/RKnfisjryCxdJZg0DIemsZFPhxhSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761201472; c=relaxed/simple;
	bh=gOpece4QF2WTj5W3bUKTztSQfGjYInO/U5VM0eCccoc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dVGUYtrB1fgmXZz+3dge9tZE46Su5B14Mi2ifx1rzw0osLIu8O+xe+XGgq53nfYuJjOl6dYh5RMcJXJu8XHysnZ9dww5OQcIfwegxwk9udwLIZEhgwGG2nAPY0Q8gM8f8VTeyTv4iSVSI1Nr5npo08xngc6dNYeU2Xf65nyhjD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmW7g5aP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmW7g5aP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B444C4CEE7;
	Thu, 23 Oct 2025 06:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761201471;
	bh=gOpece4QF2WTj5W3bUKTztSQfGjYInO/U5VM0eCccoc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=PmW7g5aPfpbskK1OHrZRSxwnXAr+JvaPptLuqxuQB2H72EiyvAk9Y5gKqFJKKu+ey
	 gUEqg7mS2uXUIlsbA6dEe/2jWOM3frgFwJKq83Q9lm+6jxezeQlUWhnPyM8foqfs51
	 30VC3u6b+utdoAuXZwcAenCozzkaJz4IaG79+BAfSogSPR7O1itcKSQ/1EVR6+n0x1
	 yXoPaOP/Fsgwr9KVXTzFo8OmBW5XHuBvB9+1yWMQ38prhAVR5eqB4TUoBX5uj/B7j/
	 g+NOw62E+TDpp0CpSuScd9HK0VqbrXglaHxKH0dJ5OSKtHZBnGzLhXxWyJZw8e8bST
	 f7oLcKcozDCpQ==
Message-ID: <d89dae3d99727ab3b48e07ad5bfdd30270898583.camel@kernel.org>
Subject: Re: [PATCH v6 mptcp-next 00/11] mptcp: introduce backlog processing
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>
Date: Thu, 23 Oct 2025 14:37:47 +0800
In-Reply-To: <cover.1761142784.git.pabeni@redhat.com>
References: <cover.1761142784.git.pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paolo,

Thanks for this v6.

On Wed, 2025-10-22 at 16:31 +0200, Paolo Abeni wrote:
> This series includes RX path improvement built around backlog
> processing
> 
> The main goals are improving the RX performances _and_ increase the
> long term maintainability.
> 
> Patches 2-4 prepare the stack for backlog processing, removing
> assumptions that will not hold true anymore after backlog
> introduction.
> 
> Patches 1 and 5 fixes long standing issues which are quite hard to
> reproduce with the current implementation but the 2nd one will become
> very apparent with backlog usage.
> 
> Patches 6, 7 and 9 are more cleanups that will make the backlog patch
> a
> little less huge.
> 
> Patch 8 is a somewhat unrelated cleanup, included here before I
> forgot
> about it.
> 
> The real work is done by patch 10 and 11. Patch 10 introduces the
> helpers
> needed to manipulate the msk-level backlog, and the data struct
> itself,
> without any actual functional change. Patch 11 finally use the
> backlog
> for RX skb processing. Note that MPTCP can't uset the sk_backlog, as
> the mptcp release callback can also release and re-acquire the msk-
> level
> spinlock and core backlog processing works under the assumption that
> such event is not possible.
> 
> A relevant point is memory accounts for skbs in the backlog.
> 
> It's somewhat "original" due to MPTCP constraints. Such skbs use
> space
> from the incoming subflow receive buffer, do not use explicitly any
> forward allocated memory, as we can't update the msk fwd mem while
> enqueuing, nor we want to acquire again the ssk socket lock while
> processing the skbs.
> 
> Instead the msk borrows memory from the subflow and reserve it for
> the backlog - see patch 3 and 11 for the gory details.
> 
> Note that even if the skbs can sit in the backlog for an unbounded
> time,
> 
> ---
> v5 -> v6:
>  - added patch 1/11
>  - reworked widely patch 10 && 11 to avoid double accounts for
> backlog
>    skb and to address the fwd allocated memory criticality mentioned
>    in previous iterations.

All tests have passed on my end. The only minor issues requiring
cleanup are in patch 2 and patch 9, which Matt or I can address in
subsequent revisions. All patches LGTM.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Tested-by: Geliang Tang <geliang@kernel.org>

> 
> Paolo Abeni (11):
>   mptcp: drop bogus optimization in __mptcp_check_push()
>   mptcp: borrow forward memory from subflow
>   mptcp: cleanup fallback data fin reception
>   mptcp: cleanup fallback dummy mapping generation
>   mptcp: fix MSG_PEEK stream corruption
>   mptcp: ensure the kernel PM does not take action too late
>   mptcp: do not miss early first subflow close event notification.
>   mptcp: make mptcp_destroy_common() static
>   mptcp: drop the __mptcp_data_ready() helper
>   mptcp: introduce mptcp-level backlog
>   mptcp: leverage the backlog for RX packet processing
> 
>  net/mptcp/mptcp_diag.c |   3 +-
>  net/mptcp/pm.c         |   4 +-
>  net/mptcp/pm_kernel.c  |   2 +
>  net/mptcp/protocol.c   | 363 ++++++++++++++++++++++++++++-----------
> --
>  net/mptcp/protocol.h   |  10 +-
>  net/mptcp/subflow.c    |  12 +-
>  6 files changed, 272 insertions(+), 122 deletions(-)
> 

