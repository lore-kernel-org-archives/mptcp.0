Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DEB2F8BDC
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 10:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758276904; cv=none; b=W8/g08Q8t3JpNoBA4qmLZN6jKQ15BoK8Ljcaxda0jLt6QembBhTkDQFXj5Gnm7WnT6etC5q756AvqYztlOfuNwJnpnxyLYxQeG6dezxhBE5bTF/C4ABM7K0fUsj7GrxwvLqfAvk9IQmwTdFRJgb8DD8CVmujXuIm9brFtzvuBrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758276904; c=relaxed/simple;
	bh=rEq9YKDhVVFH4uMjD9MkxG8IATT1g5IeAmbD/4Gfghc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LRR0GF9w6IPirkusNodjY65OxrDzpEpVNn+BW3ShaW75F2qCTzwT8pwEkJRSfRzJNWtY31ip6Pe+2dU0K9zCnnAlHRLGu0JlODTMKTSTp1l3GXqpY/t6ginDis2dpT8nwWGG+LafC9B8oE7QCCGDV0b8LW+wQhHBVpAzMxVH8Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GduiIt3L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GduiIt3L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14930C4CEF0;
	Fri, 19 Sep 2025 10:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758276903;
	bh=rEq9YKDhVVFH4uMjD9MkxG8IATT1g5IeAmbD/4Gfghc=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=GduiIt3LgNVZ8L8fOOzCaz6FofvTX7VZ30wojJp7paruoGnzJF2jVBi2KKr1sS+c+
	 7LFeYwE7bNB9txn0dj6/NO6eaJ5hKOfFFfrgAJqjE4Bo26A050Ue1NwdiSf5nqf8b9
	 uBn7SCQ6gg75fXVAIexUZnImlemV+b8QbEKRSff5clJrUAfjWFp5JhQsHPAODjJWsq
	 DZMnIX37chsnOUCsULd8OWWkKgU0mWnQHVje4uGeupnJWuCBZdnVXmoVt9jw60kcPO
	 p5qGZK21XA8QmZXVhh9yTaAEM9ikHaX/CQe2CBmjQzYapb9CYa87ZF42WGCQArnyX0
	 pS2uxj7219qYA==
Message-ID: <5307c126de5a6029a1bba744bcde32446f2ff2a6.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v2 0/2] mptcp: pm: in-kernel: usable client
 side with C-flag
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Fri, 19 Sep 2025 18:15:00 +0800
In-Reply-To: <20250916-pm-c-flag-client-default-v2-0-3be2c5bc4d6a@kernel.org>
References: <20250916-pm-c-flag-client-default-v2-0-3be2c5bc4d6a@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Tue, 2025-09-16 at 13:01 +0200, Matthieu Baerts (NGI0) wrote:
> When servers set the C-flag in their MP_CAPABLE to tell clients not
> to
> create subflows to the initial address and port, clients will likely
> not
> use their other endpoints. That's because the in-kernel path-manager
> uses the 'subflow' endpoints to create subflows only to the initial
> address and port.
> 
> The first patch fixes that, and the second one validates it.
> 
> More details:
> https://github.com/multipath-tcp/mptcp_net-next/issues/536
> 
> Please see the comment in the first patch, and don't hesitate to
> reply :)
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Thanks for this v2.

LGTM!

Reviewed-by: Geliang Tang <geliang@kernel.org>

-Geliang

> ---
> Changes in v2:
> - patch 1: move cond to new helper (Geliang) + rename var, squash
> comm.
> - patch 2: move accidental .c modif to the parent commit (Geliang)
> - Link to v1:
> https://lore.kernel.org/r/20250915-pm-c-flag-client-default-v1-0-6bb241e4d991@kernel.org
> 
> ---
> Matthieu Baerts (NGI0) (2):
>       mptcp: pm: in-kernel: usable client side with C-flag
>       selftests: mptcp: join: validate C-flag + def limit
> 
>  net/mptcp/pm.c                                  |  7 +++--
>  net/mptcp/pm_kernel.c                           | 37
> +++++++++++++++++++++++++
>  net/mptcp/protocol.h                            |  7 +++++
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 11 ++++++++
>  4 files changed, 60 insertions(+), 2 deletions(-)
> ---
> base-commit: 01d3ba86f43b6fe8e91cfd00ba178d6997095a04
> change-id: 20250912-pm-c-flag-client-default-f676d8acfdc7
> 
> Best regards,
