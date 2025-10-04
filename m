Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D117A944
	for <mptcp@lists.linux.dev>; Sat,  4 Oct 2025 01:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759541176; cv=none; b=gmMBpBjSDN82OihRW+UmPci3S1WvORdtnjqsSK81HaJIoAL3rg0GzSYbi9Ut5DawUcCIGf00D4MHiYkhopWn6sSonQrsSXsl1wEQPox7ClUrYF+uW/prpAcgJobFi2ZoOY7cxR8ixj4BDvkZRDMhswEC0xEQEukqi8A9tvNCY4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759541176; c=relaxed/simple;
	bh=phgu6v8Ad8QgEmrbV2p47Bm7uau4pqK0ogpBkynjbZU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h13x2lfJlJRztr9Yf+5DtfbG114slOajo7/dLVj2sQbdlRchFxxt19etYGSHUwK96g0lbhg17QQf0vgCkwhVp+Uu9fkMGTA93B9mmGbB1a7O4ObUwVksDKjgBxqmb31WpOTPAIA0Q+kjRO2XeVGhUIyHGf9S6xuVK1EijdaAjuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E33zNCWZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E33zNCWZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A09EC4CEF5;
	Sat,  4 Oct 2025 01:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759541176;
	bh=phgu6v8Ad8QgEmrbV2p47Bm7uau4pqK0ogpBkynjbZU=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=E33zNCWZKtVhMiE/gd3gYHlTXg5XK0sccupks2XXEL/oy6DowhifMzkXBwqKUCwq3
	 Ftpau0p3M9sT7cHjr8AjD7aFtgt/7njiWBgfUu0pOf9P+5BSAVcCMBA2ldno17fuST
	 wsVwdD8EIa7I16NVzKwEW51uYrhxTCnPb54G/hUmvg5bzffJVDzcQuCcCg26ViCX7d
	 h37pdlx99MeQapniPhRDtV9Fb/TmcsyXNvsdKRDnbMlIYJ4PG9X+nj4q5jIFgl6wOg
	 +Wi2Q0jA3DM0owp42hUViR0M5gxZlBZHtAJOe7s3HlCZ5mhNyoGFLQaerCha5E9n+X
	 jMIzha76+4sIQ==
Message-ID: <e45ab0530c97d65761acf0b9e23503cef08dedd1.camel@kernel.org>
Subject: Re: [PATCH v4 mptcp-next 0/8] mptcp: introduce backlog processing
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Date: Sat, 04 Oct 2025 09:26:13 +0800
In-Reply-To: <cover.1759499837.git.pabeni@redhat.com>
References: <cover.1759499837.git.pabeni@redhat.com>
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

Thanks for this v4.

On Fri, 2025-10-03 at 16:01 +0200, Paolo Abeni wrote:
> This series includes RX path improvement built around backlog
> processing
> 
> The main goals are improving the RX performances _and_ increase the
> long term maintainability.
> 
> Patches 1-3 prepare the stack for backlog processing, removing
> assumptions that will not hold true anymore after backlog
> introduction.
> 
> Patch 4 fixes a long standing issue which is quite hard to reproduce
> with the current implementation but will become very apparent with
> backlog usage.
> 
> Patches 5 and 6 are more cleanups that will make the backlog patch a
> little less huge.
> 
> Patch 7 is a somewhat unrelated cleanup, included here before I
> forgot
> about it.
> 
> The real work is done by patch 8. There are significant changes vs
> the
> previous iteration, as it turned out we can't uset the sk_backlog, as
> the mptcp release callback can also release and re-acquire the msk-
> level
> spinlock and core backlog processing works under the assumption that
> such event is not possible.
> 
> Other relevant points are:
> - skbs in the backlog are _not_ accounted. TCP does the same, and we
>   can't update the fwd mem while enqueuing to the backlog as the
> caller
>   does not own the msk-level socket lock nor can acquire it.
> - skbs in the backlog still use the incoming ssk rmem. This allows
>   backpressure and implicitly prevent excessive memory usage for the
>   backlog itself
> - [this is possibly the most critical point]: when the msk rx buf is
>   full, we don't add more packets there even when the caller owns the
>   msk socket lock. Instead packets are added to the backlog. Note
> that
>   the amount of memory used there is still limited by the above. Also
>   note that this implicitly means that such packets could stage in
> the
>   backlog until the receiver flushes the rx buffer - an unbound
> amount
>   of time. That is not supposed to happen for the backlog, ence the
>   criticality here.
> 
> This survived a few hours of selftest iterations in a loop: should
> address all functional issues observed in previous iterations (and
> possibly includes different ones ;)

This set looks good to me!

Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> 
> Paolo Abeni (8):
>   mptcp: borrow forward memory from subflow
>   mptcp: cleanup fallback data fin reception
>   mptcp: cleanup fallback dummy mapping generation
>   mptcp: fix MSG_PEEK stream corruption
>   mptcp: ensure the kernel PM does not take action too late
>   mptcp: do not miss early first subflow close event notification.
>   mptcp: make mptcp_destroy_common() static
>   mptcp: leverage the backlog for RX packet processing
> 
>  net/mptcp/pm.c        |   4 +-
>  net/mptcp/pm_kernel.c |   2 +
>  net/mptcp/protocol.c  | 306 +++++++++++++++++++++++++++-------------
> --
>  net/mptcp/protocol.h  |   7 +-
>  net/mptcp/subflow.c   |  12 +-
>  5 files changed, 215 insertions(+), 116 deletions(-)
> 

