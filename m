Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048D5847B
	for <mptcp@lists.linux.dev>; Wed, 21 Aug 2024 01:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724202431; cv=none; b=WHTVllJPtadFNEZ8xW+ImFWBm/t1N/hxtHADQ7ZwDBVf9ckUKeA3irAhQhZVL1uWgWyu5mk/wSIn/Lx5ZR/To9ZklstQgLERfgPG5hNjoh2bkfDjv7AQNByZxpb/lXups8JfytZnyspfOlvb7yQ/1unx23E5zT2s+5hpO+IB/C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724202431; c=relaxed/simple;
	bh=/k+I21bXnLnWBpG90qJOWLEvJq17LExLBVRIxQ91970=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=G2K0i9uedRy9GpqTumGp9VZQ+qv4MV5wNQCG+hh6WZeWXcpe/qWJEDIK6seY9BNH2imXO9z+yCCaCbNJKUvZAWVyERPlw8s1bNZFKHZBEMwnN4bZNULXDovLM9ZD/7Qk06jxx5M9U5hsZOSvcyBl06atcrzJgDQXhEOugO7eTys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2/t5Ilx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2/t5Ilx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88557C4AF09;
	Wed, 21 Aug 2024 01:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724202430;
	bh=/k+I21bXnLnWBpG90qJOWLEvJq17LExLBVRIxQ91970=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=L2/t5IlxbY4agFAAoBXayL3M2BBYvbDw9IVe3x7S0GZDFG0eJ4+tDTcjXaSJlp4iE
	 Xcfu6YFpeoL7bytiIzYU6UQ2roX+nCCDY7iZKtPwGh5ubggY3SXd8ztwzfunf4v63r
	 RcGnFW7KxWURvd111ly+ZrtCiTiWIdCOBCSbXAq46wUUfDkHEK7obva1/wG6Ekvz2f
	 5S30lhEoOw8/zDyD6rMVNi8l76EZ3LBiDVlR4XluFH/o9jUEYWyQXBKVfuT3fxdu/F
	 EHkqCV2YJIQYTXGDeAt/5UD5ytfTDjL1gGXwsfdxbNdC+FDEM7abOjqlDbuTa6nU4W
	 eruhTvZ4wGxfg==
Date: Tue, 20 Aug 2024 18:07:09 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v7 0/3] mptcp: pm: more fixes around the ID 0
In-Reply-To: <20240809-mptcp-pm-avail-v7-0-3d0916ba39b4@kernel.org>
Message-ID: <1df3dfba-fee6-ca4c-d5cb-61d44933dd63@kernel.org>
References: <20240809-mptcp-pm-avail-v7-0-3d0916ba39b4@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 9 Aug 2024, Matthieu Baerts (NGI0) wrote:

> The 8 first patches from the previous version have already been applied.
>
> Last fix: the subflow is not closed when receiving a TCP+FIN, when there
> are other available subflows.
>
> The last patch is not for -next. Something that sounds better to do.
>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Changes in v7:
> - See the individual changelog.
> - Link to v6: https://lore.kernel.org/r/20240802-mptcp-pm-avail-v6-0-964ba9ce279f@kernel.org
>

Thanks Matthieu, series LGTM (see #3 for responses to your questions 
there):

Reviewed-by: Mat Martineau <martineau@kernel.org>

> ---
> Matthieu Baerts (NGI0) (3):
>      mptcp: close subflow when receiving TCP+FIN
>      selftests: mptcp: join: cannot rm sf if closed
>      mptcp: pm: send ACK on non stale subflows
>
> net/mptcp/pm_netlink.c                          | 14 +++++++++++---
> net/mptcp/protocol.c                            |  5 ++++-
> net/mptcp/subflow.c                             |  8 ++++++--
> tools/testing/selftests/net/mptcp/mptcp_join.sh | 11 ++++-------
> 4 files changed, 25 insertions(+), 13 deletions(-)
> ---
> base-commit: beede3e0f15d8869512b5b51e580829ab6939f92
> change-id: 20240620-mptcp-pm-avail-f5e3957be441
>
> Best regards,
> -- 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
