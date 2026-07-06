Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAA13E6DCA
	for <mptcp@lists.linux.dev>; Mon,  6 Jul 2026 06:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783319684; cv=none; b=WytjRywv/lfiQlQTTmSAnaqN3MfK5QOJjxjVPqOBJM1TAxElv3DbC8oZKFHONeNdRWxj+7WEVllvSRnltlKm2+DLedXwSWnJU12ADtDuFeDHeu/BGw+kwdL+4H7EVby4bNiM1X5xRaqnsEBQapD7zSTFCczUkjLtw+pELcQXlpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783319684; c=relaxed/simple;
	bh=9ffiCBJFzttWzHHs4pI+EhMn0IE7+vKVlPqEAdNIXKE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nu7ozMYMxRZqO9SASCWKsyxxLIqf2491C6D7wWx0g6n9ZR3nO5KraPVTxnwBe03PLiw2yVyJr0fHETwd9bUTxKbwD/APb33gqZEZLC/z7R1sHUiwvoYCrqHxF1lbW7m1BwM7Xs5sAx5e/TkRGk1oQNxB4rp2A4x+7s4EnqoJdII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxQWo2Kc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxQWo2Kc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43DF11F000E9;
	Mon,  6 Jul 2026 06:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783319673;
	bh=v1Y0pmT7PnH1cbC844KaWqHfMf8ytseIDYxMaHv0+Y0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FxQWo2Kc1E/fdwLyvvFPGg9pls139tuOPZfgHqxb6n0RflFp3Rh+eqBRPpE82huoQ
	 DLnlCA2qjoyoxMThcZcXzen6MrKuIjFzSHS0W5MXJXOH1NDINmwC542bWCMG/YvpNu
	 oZFtYrwNUAbWmb9BZbDrLpuDeeRvI0Ds7S++rUXkkuBZrT/N2HzLjubud9LMFSDfzQ
	 GjKnxfhzg5sV21UUPDhkWZ2l1GTuL0nkvnSlGVT4HvK6NGyKsNH0HmhPOVXoKmnF3d
	 Xbz+XjZGwW8+iksyG6rpc9v7uBkLrQhF0ofI7/uVbjedoosye2cUZoXQcYXWTeFVJY
	 V7TEeCMdN10eQ==
Message-ID: <0dc8e723ee2af76224d2fe23eca6c4891207fbe0.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 2/5] Squash to "bpf: Export mptcp packet
 scheduler helpers"
From: Geliang Tang <geliang@kernel.org>
To: Shardul Bankar <shardul.b@mpiricsoftware.com>, mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
 kalpan.jani@mpiricsoftware.com, janak@mpiric.us, shardulsb08@gmail.com
Date: Mon, 06 Jul 2026 14:34:14 +0800
In-Reply-To: <20260703-mptcp_bpf_kfunc_fixes-v2-2-87ae3c64dc7e@mpiricsoftware.com>
References: 
	<20260703-mptcp_bpf_kfunc_fixes-v2-0-87ae3c64dc7e@mpiricsoftware.com>
	 <20260703-mptcp_bpf_kfunc_fixes-v2-2-87ae3c64dc7e@mpiricsoftware.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Shardul,

Thanks for this v2. It's much better now.

On Fri, 2026-07-03 at 22:27 +0530, Shardul Bankar wrote:
> mptcp_pm_subflow_chk_stale() is exposed to BPF MPTCP packet
> schedulers as
> a kfunc taking a generic "struct sock *ssk", but it treats ssk as a
> subflow TCP socket: it derives the subflow context with
> mptcp_subflow_ctx(), an unchecked cast of inet_csk(ssk)-
> >icsk_ulp_data,
> then reads and writes through it. The verifier only proves ssk is a
> trusted struct sock, not that it is one of msk's subflows, so a
> mistyped
> or foreign socket would make the helper operate on a bogus context.
> 
> Register a bpf_mptcp_pm_subflow_chk_stale() wrapper that validates
> ssk is
> a full MPTCP subflow TCP socket belonging to the passed msk before
> calling
> the helper, which assumes both but checks neither. This mirrors
> bpf_mptcp_subflow_ctx(). A scheduler passing one of its own subflows
> is
> unaffected; the in-tree burst scheduler selftest is updated to the
> wrapper
> name in a separate squash-to.
> 
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
> ---
>  net/mptcp/bpf.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index 9355fb53e89d5..e2d2c3394ad71 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -306,6 +306,18 @@ __bpf_kfunc static void
> bpf_mptcp_set_timeout(struct mptcp_sock *msk)
>  	mptcp_set_timeout((struct sock *)msk);
>  }
>  
> +__bpf_kfunc static void
> +bpf_mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct
> sock *ssk)
> +{
> +	if (ssk && sk_fullsock(ssk) && ssk->sk_type == SOCK_STREAM
> &&
> +	    ssk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(ssk)) {
> +		struct mptcp_subflow_context *subflow =
> mptcp_subflow_ctx(ssk);
> +
> +		if (subflow && subflow->conn == (const struct sock
> *)msk)

Sashiko complained that the rcu lock is not held here [1]. It seems we
can add the lock, something like:

    rcu_read_lock();
    subflow = mptcp_subflow_ctx(ssk);
    if (subflow && subflow->conn == (const struct sock *)msk)
            mptcp_pm_subflow_chk_stale(msk, ssk);
    rcu_read_unlock();


WDYT?

Thanks,
-Geliang

[1]
https://sashiko.dev/#/patchset/20260703-mptcp_bpf_kfunc_fixes-v2-0-87ae3c64dc7e@mpiricsoftware.com?part=2

> +			mptcp_pm_subflow_chk_stale(msk, ssk);
> +	}
> +}
> +
>  __bpf_kfunc_end_defs();
>  
>  BTF_KFUNCS_START(bpf_mptcp_iter_kfunc_ids)
> @@ -327,7 +339,7 @@ BTF_ID_FLAGS(func, mptcp_subflow_active)
>  BTF_ID_FLAGS(func, bpf_mptcp_set_timeout)
>  BTF_ID_FLAGS(func, mptcp_wnd_end)
>  BTF_ID_FLAGS(func, bpf_sk_stream_memory_free)
> -BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_mptcp_pm_subflow_chk_stale, KF_SLEEPABLE)
>  BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
>  
>  static int bpf_mptcp_common_kfunc_filter(const struct bpf_prog
> *prog, u32 kfunc_id)
