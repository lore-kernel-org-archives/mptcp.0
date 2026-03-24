Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C426D3AF67C
	for <mptcp@lists.linux.dev>; Tue, 24 Mar 2026 06:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774333438; cv=none; b=Pepk4FuRikeTos2XUyeUeDi7aQ1JOxJMs5tkSm8YPTC0L76mHClKf6BiBa7KrBUfFbsaDgnwcsd73zZrmTfr6EeV7tu6cMY2PO+PT3vgug+dtph6VkjDI1FVsdIUM8ZVgUtKZuXevJFiT/q207XIOuiAN5ccTsZ4jAXGLmjEvhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774333438; c=relaxed/simple;
	bh=Ww1LYz6+dAyn9Ygnq9ZklhqaBGzWYysR4aHscbI0cPM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NBiK9rXVwgv8owMjRumEB//A9W15q+jeR0uSLFcpuQViRPFrLjOsLqC+QJL+tMGFI5QAE6N2OwZJxM6AVYkn0cSZRVsZ2bDBCaBEJilTKrcU5wLQQWr9fZgs5Y8wAJ/1x5f+Zv9WrAYR2Ezz/j3C4C0xUrDWw7ZGbKcpawHddXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TugVrnfS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TugVrnfS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE43C19424;
	Tue, 24 Mar 2026 06:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774333438;
	bh=Ww1LYz6+dAyn9Ygnq9ZklhqaBGzWYysR4aHscbI0cPM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=TugVrnfSxo9GcVQpWurlXuByOmxvbSMqgbt7nlOizdcSZOSgNtKTzfxv3z+/bGNXq
	 9OLcz1bNEz+xrCaq9gU3aWyl7j7r/mkJ4Y/pMnMBxVHNfA6dHrs5tPQ5rOEPRbJ8d7
	 yFD2jgABKZ+PMnGeMf6+MAkzTSH/35VRZlMyl//1sIrl9YfwkJRejVqLaocbRETx9B
	 ew4MZmOmH47XZTlhujeuDDvMlMAa1etChFEelWweLms94uski8UKI3pAYqz7OqgzRo
	 lIYuXVyTSLeNZp2swyBZeVFYNzh0zKwOj1+dwmP0iWlMLtbsDneIBnr2S6jD541PsN
	 FG+jyrOevdjZw==
Message-ID: <132c61dfc174923d270fd73fdd11739292b5730c.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v3 0/3] mptcp: fix stall because of data_ready
From: Geliang Tang <geliang@kernel.org>
To: Gang Yan <gang.yan@linux.dev>, mptcp@lists.linux.dev
Cc: pabeni@redhat.com, Gang Yan <yangang@kylinos.cn>
Date: Tue, 24 Mar 2026 14:23:53 +0800
In-Reply-To: <cover.1773735950.git.yangang@kylinos.cn>
References: <cover.1773735950.git.yangang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Gang,

After testing, I found that with this set applied, the TLS test still
fails occasionally.

On Tue, 2026-03-17 at 16:36 +0800, Gang Yan wrote:
> From: Gang Yan <yangang@kylinos.cn>
> 
> Hi Paolo,Matt:
> 
> The patches have replaced the original backlog_list with an rb-tree
> based
> 'backlog_queue', and resolved the existing transmission stall issues
> by using
> the new backlog_queue infrastructure.
> 
> Looking forward to your comments and feedback.
> 
> Thanks
> Gang
> 
> Gang Yan (3):
>   mptcp: replace backlog_list with backlog_queue
>   mptcp: fix the stall problems using backlog_queue
>   mptcp: fix the stall problems with data_ready

As we discussed, in patch 3 we should pass "delta" to
mptcp_backlog_spooled(), not "moved". Additionally, it would be better
to extract this logic into a separate helper rather than embedding it
directly in move_skbs_to_msk().

For patch 2, I suggest putting

	sk_rmem_alloc_get(sk) > sk->sk_rcvbuf &&
	!skb_queue_empty(&sk->sk_receive_queue)

into a helper, e.g., mptcp_recvbuf_is_full().

I've changed the status of this set to "Changes Requested".

Thanks,
-Geliang

> 
>  net/mptcp/protocol.c | 93 +++++++++++++++++++++++++++++++++++++-----
> --
>  net/mptcp/protocol.h |  2 +-
>  2 files changed, 81 insertions(+), 14 deletions(-)
