Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1F52236E3
	for <mptcp@lists.linux.dev>; Thu, 14 May 2026 03:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778728649; cv=none; b=u8cBp2Ij10Ol8DbkyiAZMHrlP11un6pxVXCLzqWg6f+AEpuRX+qb/DNgPdjzmqd+x8U48F+9qMFrCE7u5txzpI5PgGMHheLE4J8KlMqSIkPYW95Kv6dSrskxeKrqeGjjpm+gVlX1h9jMtjNgkdYf1gzqRjz6Z5Lce9dRnCsay+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778728649; c=relaxed/simple;
	bh=fyUlOvQ5FoD8GQJ3qn/vXIDERWmsDl+84MYtyf+0/D8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TNxdKAM7mmszfo2LNP87SutyPnR5M2exyczjR477eGJvhFtcfHMXb16yq1x4ACt5KnOGW4Ghh1uopMnWwhu9ehghSQRDXq7bndzj+zuzE9EfOrH3A7Hqmj26Gr2mHYQzaPhOyUw0LvaQMvcYKUCimAlFhP1IKVvAwCGRFtU4Vu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCH29p4Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCH29p4Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF1BC19425;
	Thu, 14 May 2026 03:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778728649;
	bh=fyUlOvQ5FoD8GQJ3qn/vXIDERWmsDl+84MYtyf+0/D8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=QCH29p4ZuH5WG3uv4xgc+JSoJp+EObv3YVTrreIwi2warK/tQiHo+NysDoawj22Q3
	 pxsxEr1Yj0BxdL7ZxHmnKWxUiZ6D/JPV7ZSyx8AZse0N5jLGFBM/nfzwaaL1W3CYdO
	 AhNZiFlO4S6cPRW1vnk04AMxHVMV2Ghe1dMc+/gfPFeQyQbhs0pj4Fs8YDAXaCcCoy
	 BAQ+TazrlYA2QtLj/5e5dJDpMg1tnzN4MaYtCJWthUEs5TfF8lNUQFzEnIyOOLjinw
	 oYzOgrREqkWmXSLGSb+MsS9IVecoaAcGUw1gC00pSGlOw8gAHLZ2HI72HWp8V81vvf
	 UKm3W+fIDSucA==
Message-ID: <e1ea8d0d953314192acea3480460116c0a52e02e.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 2/2] mptcp: pm: fix extra_subflows u8
 underflow in userspace PM
From: Geliang Tang <geliang@kernel.org>
To: Tao Cui <cuitao@kylinos.cn>, matttbe@kernel.org, martineau@kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: horms@kernel.org, mptcp@lists.linux.dev
Date: Thu, 14 May 2026 11:17:23 +0800
In-Reply-To: <20260509075629.217791-2-cuitao@kylinos.cn>
References: <20260509075629.217791-1-cuitao@kylinos.cn>
	 <20260509075629.217791-2-cuitao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 2026-05-09 at 15:56 +0800, Tao Cui wrote:
> extra_subflows is a u8 field in struct mptcp_pm_data.  Two paths in
> the
> userspace PM can cause it to underflow from 0 to 255, after which the
> counter is permanently corrupted and future subflow creation is
> blocked.
> 
> 1) __mptcp_subflow_connect() calls mptcp_pm_close_subflow() on
> failure
>    to roll back the pre-increment done by kernel PM's fill_*()
> helpers.
>    The userspace PM does not pre-increment — it only increments after
>    __mptcp_subflow_connect() succeeds — so this decrement is
> spurious.
> 
> 2) mptcp_pm_subflow_check_next() decrements unconditionally for the
>    userspace PM without checking that the counter is non-zero.
> 
> Fix (1) by gating mptcp_pm_close_subflow() on the PM type and fix (2)
> by adding an underflow guard.

Please split this patch into two patches, one for (1), the other for
(2).

Thanks,
-Geliang

> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>  net/mptcp/pm.c      | 3 ++-
>  net/mptcp/subflow.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 3c152bf66cd5..a83a56b467f9 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -655,7 +655,8 @@ void mptcp_pm_subflow_check_next(struct
> mptcp_sock *msk,
>  	if (mptcp_pm_is_userspace(msk)) {
>  		if (update_subflows) {
>  			spin_lock_bh(&pm->lock);
> -			pm->extra_subflows--;
> +			if (pm->extra_subflows)
> +				pm->extra_subflows--;
>  			spin_unlock_bh(&pm->lock);
>  		}
>  		return;
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index d562e149606f..c45ad67cb650 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1716,7 +1716,8 @@ int __mptcp_subflow_connect(struct sock *sk,
> const struct mptcp_pm_local *local,
>  	/* we account subflows before the creation, and this
> failures will not
>  	 * be caught by sk_state_change()
>  	 */
> -	mptcp_pm_close_subflow(msk);
> +	if (!mptcp_pm_is_userspace(msk))
> +		mptcp_pm_close_subflow(msk);
>  	return err;
>  }
>  
