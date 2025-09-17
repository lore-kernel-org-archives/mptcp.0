Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89F3249F9
	for <mptcp@lists.linux.dev>; Wed, 17 Sep 2025 04:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758082666; cv=none; b=UYfbtMD0Uc393/q/zRGnseOji6SnlKBzujhOyh9jjXg393cEhAgJCPJX+gV2JxXGyJDTkTHalE+sn97FLd7OK4xrsJ2rG3B11ILfb/JEhIX+Ujf2AmbGK5qMW+/nxwEZiIx9KyybKqhwjtrdsoevAGJ0QVr9mWZwgqSKxE4T0Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758082666; c=relaxed/simple;
	bh=2KCWRlNBJZlEWMUpW1OGLzvsLbUZa2PAmLLy2QQTOPY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PSQ/Sp7QzNUokKusLP4djdrlzCmMLwiBDndaZAGNlakaI6p+sBPM9YY495F8WTHEaoQY4bKPsbK5tsdVkbHAAVWWj7PMZ/KfnoLBgrYvou4V9chVnXgm6ybkhhFE9f55w6wBdWoOk9TkvWq/riPZRN7+e7IlgwOCTGDjKyf4dp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSVBw/pr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSVBw/pr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD1AC4CEF0;
	Wed, 17 Sep 2025 04:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758082666;
	bh=2KCWRlNBJZlEWMUpW1OGLzvsLbUZa2PAmLLy2QQTOPY=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=cSVBw/prAMxfowwlm7MM4e3k3+a1ZqK0AZRjSwpIMOs0g7K39J8+girq2ZqcymPyB
	 FjEpsxQqwVt9fZMxeGqrI/R7jSo0XF27/6HMtloXPM1O8mFj94t5unAwfTygBJVj96
	 YhLItJkLu4q/l4EFVMGBYe4qruu4IkOUbChkL++hbXKTkg5cdT1Er0BmCbEmZIwoF7
	 KiCQOETwy7tts40dM9+7aYnYtPnAz1+hJNjHZ8eQdYqFHoq2mZm54JV1+SSyzGrizV
	 XaTH2ZKTKB1Q30W09Bf4+aN8TJY9eDNzXQkfrJGwecjXAkCg9dgvsrktYztwYxhfJI
	 yhh2BVXhggMGg==
Message-ID: <fba801e3874a756a2498ae073dab4ce1c5106ee3.camel@kernel.org>
Subject: Re: [MPTCP next 00/12] mptcp: receive path improvement
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Date: Wed, 17 Sep 2025 12:17:42 +0800
In-Reply-To: <cover.1758039775.git.pabeni@redhat.com>
References: <cover.1758039775.git.pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2025-09-16 at 18:27 +0200, Paolo Abeni wrote:
> This series includes several changes to the MPTCP RX path.
> 
> The main goals are improving the RX performances _and_ increase the
> long term maintainability.
> 
> Some changes reflects recent (or not so) improvements introduced in
> the
> TCP stack: patch 1, 2 and 3 are the MPTCP counter part of skb
> deferral
> free and auto-tuning improvements.
> 
> Note that patch 3 could possibly fix issues/574, and overall such
> patch
> should protect from similar issues to arise in the future.
> 
> All the others patches are aimed at introducing the socket backlog
> usage
> to process the packets received by the subflows while the msk socket
> is
> owned. That (almost completely) replace the processing currently
> happening in the mptcp_release_cb().
> 
> The actual job is done in patch 9, while the others are cleanups
> needed
> to make the change tidy and more follow-up cleanups.
> 
> Sharing earlier with known issues (at least on fallback socket) to
> raise
> awareness about this upcoming work.

Great! Thanks Paolo. Patch 3 "mptcp: rcvbuf auto-tuning improvement"
also fixes issue #487 "send() fails with EAGAIN in blocking IO mode"
that's been bothering me for quite a while. Therefore, please also add:

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/487

Meanwhile, I think this series closes issue #559 as well:

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/559

-Geliang

> 
> Paolo Abeni (12):
>   mptcp: leverage skb deferral free
>   tcp: make tcp_rcvbuf_grow() accessible to mptcp code
>   mptcp: rcvbuf auto-tuning improvement
>   mptcp: introduce the mptcp_init_skb helper.
>   mptcp: remove unneeded mptcp_move_skb()
>   mptcp: factor out a basic skb coalesce helper
>   mptcp: minor move_skbs_to_msk() cleanup
>   mptcp: cleanup fallback data fin reception
>   mptcp: leverage the sk backlog for RX packet processing.
>   mptcp: prevernt __mptcp_move_skbs() interferring with the fastpath
>   mptcp: borrow forward memory from subflow
>   mptcp: make fallback backlog aware
> 
>  include/net/tcp.h    |   1 +
>  net/ipv4/tcp_input.c |   2 +-
>  net/mptcp/ctrl.c     |   2 +
>  net/mptcp/mib.c      |   2 +
>  net/mptcp/mib.h      |   4 +
>  net/mptcp/protocol.c | 338 ++++++++++++++++++++++++-----------------
> --
>  net/mptcp/protocol.h |   8 +-
>  net/mptcp/subflow.c  |  24 +--
>  8 files changed, 220 insertions(+), 161 deletions(-)
