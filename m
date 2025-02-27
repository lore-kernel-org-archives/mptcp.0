Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE0C4683
	for <mptcp@lists.linux.dev>; Thu, 27 Feb 2025 02:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740621801; cv=none; b=gHXYKNM8at8AJR353hBRuc0Q/W/Z+y3/oey7/xr+XRxEr44helT7zIUh8i7XJpMGdTXu016swHHE2X7us5YR2R64mRypDv/mrgLL+pSXHRYdwAYnCZMJkRGqXx24uFfXYjccEo4ZsOckTa5Oh5A2QBvzviogzCnc3dQWRCvcitM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740621801; c=relaxed/simple;
	bh=lYNU6U/DwqDUDQ+YusgTJdT0+9nH0GEsUpCxL9de0Ro=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I9xbC04j8hHJn9XEYEt4Jha7UU0fvprkIphTbzyFwyuPljvQ5QE+DFRQYkR7cmA6BTC2ot+28FDPk4Gnn2AdiJftTYWBUyb6ccy+PVbjOjHcsJXGQvOzdkh2A6ZGxRXYOWPb0AovDmpdLToHq3Hll4JWlVV7KIbUkX1F1ZckGf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgtL2i2N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgtL2i2N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12CACC4CED6;
	Thu, 27 Feb 2025 02:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740621801;
	bh=lYNU6U/DwqDUDQ+YusgTJdT0+9nH0GEsUpCxL9de0Ro=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=dgtL2i2NIxisywaLrf8y+okqg0/C62h6gZ2QDuPk4u2zoyHI6Zwzp0q1/VqQB57CD
	 3crs5Cfkjzz8v3e2hzwUZloPDso4yxqL/30NveJJUoBebIv39cKrx0GTBczKHurMxV
	 LXLbNl5LsCYUdrm820G9T8ee5Q2IK+y0ue/hzzYMhx4GqAScdSDrR5o/3zx/+zo8Rh
	 XhbS9ijTgKoBkOsWDDDJDd6+JGlCCE0az+gRUJGDTFh4i7piVMjDB4NHh+LS2DY4+0
	 tQkiSHRC3g/+MpXCQCRpXYpJGoIyNeGFnOnrGOLX4Ts0Xr4RxlqHX3KzSOTxvRro84
	 C/7ZaP7gZ5pDw==
Message-ID: <9f669869ee804aeb6dbe7fd1511034b0ca9bf8c4.camel@kernel.org>
Subject: Re: [PATCH mptcp-next] Squash to "bpf: Add mptcp_subflow bpf_iter"
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Cc: Mat Martineau <martineau@kernel.org>
Date: Thu, 27 Feb 2025 10:03:15 +0800
In-Reply-To: <20250226180727.2499531-2-matttbe@kernel.org>
References: <20250226180727.2499531-2-matttbe@kernel.org>
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

On Wed, 2025-02-26 at 19:07 +0100, Matthieu Baerts (NGI0) wrote:
> From what we understood, when being used from a CG [gs]etsockopt
> hook,
> the socket lock will be held. It seems that the BPF infra will make
> sure
> in this case. Mat will try to get the confirmation.
> 
> The idea is then to add this msk_owned_by_me() check to make sure the
> assumption is correct, and will continue to be: the new selftest
> should
> complain if not when used with a debug kconfig. In other words, if
> the
> tests continue to pass with this patch, the Squash-to series can
> probably be applied.
> 
> Note that this is just a debug check, hoping that the selftest will
> cover all cases. We can then not use this check to return an error if
> it
> is not held.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Thanks for updating this for me.

LGTM!

Reviewed-by: Geliang Tang <geliang@kernel.org>

> ---
> Based-on: <cover.1740368110.git.tanggeliang@kylinos.cn>

I changed the state of this set, Squash to "Add mptcp_subflow bpf_iter
support" v4, together with this squash-to patch, as "Queued".

Thanks,
-Geliang

> Cc: Geliang Tang <geliang@kernel.org>
> Cc: Mat Martineau <martineau@kernel.org>
> ---
>  net/mptcp/bpf.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index ac7744c6006f..9e8c24c88022 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -252,6 +252,9 @@ bpf_iter_mptcp_subflow_new(struct
> bpf_iter_mptcp_subflow *it,
>  		return -EINVAL;
>  
>  	msk = mptcp_sk(sk);
> +
> +	msk_owned_by_me(msk);
> +
>  	kit->msk = msk;
>  	kit->pos = &msk->conn_list;
>  	return 0;

