Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1DD296159
	for <mptcp@lists.linux.dev>; Tue,  4 Nov 2025 07:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762241424; cv=none; b=kVi/XwZliOMzcRT6zTpZ4rrf3fvTpQizI0HBwQxgQh8tRVoagmkWk+0XGTZIXzOO9tlMt+I/6mq18zPLD4V0beYEUrf9/6OGvieNLNlRLk77if4zZG39c4qLo3x99QrQ3b3N+EAcLiGaNPxiBxz6ogXU/D+Dj2/f2sbyCMUo6Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762241424; c=relaxed/simple;
	bh=SA0Kx9jQ7WznsqAxH9eqYYMBLGhQlZw2J9LVOFZd1p0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=djj5CKm68micFaI3fKqtfsPr0LUwLnWDX1yQke6l+lwE8rv84J7gI34SUHcnR8FXhdrl9fKX+YcmQRkjPpxbPU/syt0NrDnSEzJR8jpdJiIpgQRYGrVWzjEiBoJ6JqkPCuF4EjDXYN/+7pmUUFXYJnD6Zu+FZrcaN3Av4n/RA5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgeaGEGF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgeaGEGF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8734BC4CEF7;
	Tue,  4 Nov 2025 07:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762241424;
	bh=SA0Kx9jQ7WznsqAxH9eqYYMBLGhQlZw2J9LVOFZd1p0=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=FgeaGEGFsh17Fa1bK2gE1weukAnNS1621Zd+D2ktNgtXxyJiSswle56FZfXl6AM7N
	 VMUipxlRGFZjY4tQ4+2GLk3TXMbNKhgalk4+u7UVNF5gaYPPHkpQYqcX29eu01oOIv
	 zrWhW31uSSmCvcocwQJOpH9y2BWp+9ZMpltBr88Sg1WGMdzq5UjKF7/l/9iKJXi8qQ
	 HDftFm14+kAO03aYyu1mMS75v5AGNP8c0GslWvAVqF8zHZC2QQncQIl+pqwIxbczlt
	 Qz/6peRjFJJJdWvSMvKcHfyDQc5kWzgcu8fUTL/O+cvp//7KeXZ9i0b0oydXPGPS9m
	 eOdE95FrwnGjg==
Message-ID: <46433282b63496fc4c49313fb629a378ddd8594a.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v2 0/6] selftests: mptcp: join: fix flaky tests
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Tue, 04 Nov 2025 15:30:20 +0800
In-Reply-To: <20251102-slft-join-inst-v2-0-b4f3ba15a7c4@kernel.org>
References: <20251102-slft-join-inst-v2-0-b4f3ba15a7c4@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Sun, 2025-11-02 at 12:30 +0100, Matthieu Baerts (NGI0) wrote:
> When looking at the recent CI results on NIPA and MPTCP CIs, a few
> MPTCP
> Join tests are marked as unstable. Here are some fixes for that.
> 
> - Patch 1: a small fix for mptcp_connect.sh, printing a note as
>   initially intended. For >=v5.13.
> 
> - Patch 2: avoid unexpected reset when closing subflows. For >= 5.13.
> 
> - Patches 3-4: longer transfer when not waiting for the end. For
> >=5.18.
> 
> - Patch 5: drop noisy plain RST packets when looking for
> MP_FASTCLOSE.
>   For >= 5.18.
> 
> - Patch 6: read all received data when expecting a reset. For >=
> v6.1.
> 
> When reviewing patches 2-6, please double check that I'm not hiding
> real
> issues by tweaking the tests suite.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

This set looks good to me!

Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> ---
> Changes in v2:
> - Patch 6: also handle EPIPE properly.
> - Link to v1:
> https://patch.msgid.link/20251101-slft-join-inst-v1-0-10572512a0b2@kernel.org
> 
> ---
> Matthieu Baerts (NGI0) (6):
>       selftests: mptcp: connect: fix fallback note due to OoO
>       selftests: mptcp: join: rm: set backup flag
>       selftests: mptcp: join: endpoints: longer transfer
>       selftests: mptcp: join: userspace: longer transfer
>       selftests: mptcp: join: fastclose: drop plain RST
>       selftests: mptcp: connect: trunc: read all recv data
> 
>  tools/testing/selftests/net/mptcp/mptcp_connect.c  | 18 ++--
>  tools/testing/selftests/net/mptcp/mptcp_connect.sh |  2 +-
>  tools/testing/selftests/net/mptcp/mptcp_join.sh    | 95
> +++++++++++++---------
>  3 files changed, 69 insertions(+), 46 deletions(-)
> ---
> base-commit: b9e1acc39cbc985ca8df781775718e39e421409b
> change-id: 20251029-slft-join-inst-e307faf42138
> 
> Best regards,

