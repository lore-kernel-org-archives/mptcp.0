Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05D317BB35
	for <mptcp@lists.linux.dev>; Tue,  4 Nov 2025 22:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762296632; cv=none; b=CIp8GjHlLeM06gOUXqkiH7CWvEi1JBGzs0CJQbs7R0GP5TwkPgLb4jjInodUWwFUxt++E9KSZJKByzU0yByu24Zqyqdqruz768H/UIOwddcjexh/CKnYbQZfP6pTRnigWYs6Ne57yWhELXcEwaTBNrtPXO4FEv5kVvpymPzG4vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762296632; c=relaxed/simple;
	bh=qydPjjM9GfMe1lCkfu664gIsG1DSrJTB6XnGiSw5xR8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SiXjBduK0+AgQzh65QURO6hZfrgJsmzA0E3c8WgE8sYeRGCC5gezIK1+aNztxSVmgH3Tjtc54a/mJ1Gv7U6pQjlcOwVOnhdKH2ptSyT4TdNicZR7i4Kwg7i/MJtTH5QTCIP21gRIxXA+eW4Dp2xXNKQiYUsIz98ccRPqUiLEpAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMyxNTB5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMyxNTB5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70096C4CEF7;
	Tue,  4 Nov 2025 22:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762296632;
	bh=qydPjjM9GfMe1lCkfu664gIsG1DSrJTB6XnGiSw5xR8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=iMyxNTB5QRJX+dammQn8eyMyOZmzwvk8BuFU0T6r75oXOQWIjtlzWXz77ZU5evTbw
	 jXRI0DO0iHlKwa4gF12TFYnUVUK/rb/g/HxvKbHrqhJKNxmAhgG9ux0pnx7G4wuJIT
	 wGj52l7pnqasjTY8OxY4yOv2BCNqUTQtIaoxYPTEbVWiLCa7p2GIzXsLBqyBsjdzef
	 BPKUwTCg5H1yuqicLEOrSqGIgl2W2vw9siuEHU3kCAvL1J3eAJ432JAnfmkOPib4fq
	 msZunImUhj9grQ69xRtkAECguqNc+UODG8rWuxPMAITkcrydDO+RTSRqOEnNqzD6RH
	 lL4ZxvnIHmC2w==
Date: Tue, 4 Nov 2025 14:50:31 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v8 0/4] mptcp: introduce backlog processing
In-Reply-To: <cover.1762271864.git.pabeni@redhat.com>
Message-ID: <1d2d6f02-868a-a367-069f-0c74c82c14a8@kernel.org>
References: <cover.1762271864.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 4 Nov 2025, Paolo Abeni wrote:

> This series includes RX path improvement built around backlog processing
>
> The main goals are improving the RX performances _and_ increase the
> long term maintainability.
>
> Patch 1 and 2 refactor the memory account logic in the RX path, so that
> the msk don't need anymore to do fwd allocation, removing possible drop
> sources.
>
> Patch 3 and 4 cope with backlog processing. Patch 3 introduces the
> helpers needed to manipulate the msk-level backlog, and the data struct
> itself, without any actual functional change. Patch 4 finally use the
> backlog for RX skb processing. Note that MPTCP can't use the sk_backlog,
> as the mptcp release callback can also release and re-acquire the
> msk-level spinlock and core backlog processing works under the
> assumption that such event is not possible.
>
> A relevant point is memory accounts for skbs in the backlog.
>
> It's somewhat "original" due to MPTCP constraints. Such skbs use space
> from the incoming subflow receive buffer, but are fwd memory accounted
> on the msk, using memory borrowed by the subflow.
>
> Instead the msk borrows memory from the subflow and reserve it for
> the backlog - see patch 2 and 4 for the gory details.
> ---
> v7 -> v8:
>  - only minor changes: typos, added warn_on().
>  - notably no BL loop limiting, as discussed on previous iteration
>

Thanks for the clarifications Paolo, v8 LGTM:

Reviewed-by: Mat Martineau <martineau@kernel.org>

> Paolo Abeni (4):
>  mptcp: handle first subflow closing consistently
>  mptcp: borrow forward memory from subflow
>  mptcp: introduce mptcp-level backlog
>  mptcp: leverage the backlog for RX packet processing
>
> net/mptcp/fastopen.c   |   4 +-
> net/mptcp/mib.c        |   1 -
> net/mptcp/mib.h        |   1 -
> net/mptcp/mptcp_diag.c |   3 +-
> net/mptcp/protocol.c   | 232 +++++++++++++++++++++++++++++------------
> net/mptcp/protocol.h   |  45 +++++++-
> 6 files changed, 214 insertions(+), 72 deletions(-)
>
> -- 
> 2.51.0
>
>
>
