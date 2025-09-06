Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B974D1CFBA
	for <mptcp@lists.linux.dev>; Sat,  6 Sep 2025 14:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757167526; cv=none; b=hY8AHwh9nsIDF4qp0JxtvCO4c9qXuSqyZNh32+l45ermN9cFczgSZcuXbijGlEtfoRBLpvIGr+v2NnmHowikhUGcx3E4kG/645yhf23T9jQUgtfdhsLVGBKsVqQzQNqhbMvTJzeqY+h3wmUTQABZRChrD/uNMD/UWtYzp7zHTrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757167526; c=relaxed/simple;
	bh=cbWhKHP6aKExs1ZQrTLRf7LUrJ70pmwUIaaLqm968wI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A6tFNUZ+IjgCLRiBZ8yaQCMi3kX3WIj8qPEqJGAG2fRcq7dp6rz8kfmwzhye99nbYSAHmgAIgAkF4E8AeAczeq6S3GfVfb/Lo+8yTcpQ4x3DnIyyr+BVGPzMQA3GB54J6VaySTFMoWM4SN64Hp4/9OzJhEeT6B8ysG5L0PJz+5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sE7VUnFJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sE7VUnFJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9511EC4CEE7;
	Sat,  6 Sep 2025 14:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757167526;
	bh=cbWhKHP6aKExs1ZQrTLRf7LUrJ70pmwUIaaLqm968wI=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=sE7VUnFJtQCLi3kcGbRsJZ1sGVZJFR9wBQU9Y58louu8/u1hINfB+uzk7uPRGBfzC
	 XPETlrGst/mIDq8iukYEKovPzzxDAYRGsqOwqu+fRu8DaBpXT0mfW7jW5UHU158j1s
	 As2gIfQVBOWKEzDo6wTXlby9UWvxg/aTKRwb+0tFzjk6L87Ubq02QtJvUH2hlgHDzW
	 Fo9Bq9POkfznSRPUnsJ9zFBZt+P8ktmILK7DfnZdd8BXbDMSDEn2pWh98nj5sG2k26
	 58q5AAfMqiXPTK4S3i6coV/0axYcGNWTPKc+qWORmP2TNZv8Tv4VtFLO83aoWICFJH
	 TuzFsofU/XbEQ==
Message-ID: <1cdace482b0f833e68c95fad171e4323c1d1925e.camel@kernel.org>
Subject: Re: [PATCH mptcp-net 3/7] mptcp: tfo: record 'deny join id0' info
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Sat, 06 Sep 2025 22:05:23 +0800
In-Reply-To: <20250829-mptcp-pm-user-c-flag-v1-3-78b25dda7708@kernel.org>
References: <20250829-mptcp-pm-user-c-flag-v1-0-78b25dda7708@kernel.org>
	 <20250829-mptcp-pm-user-c-flag-v1-3-78b25dda7708@kernel.org>
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

Thanks for this fix.

On Fri, 2025-08-29 at 22:33 +0200, Matthieu Baerts (NGI0) wrote:
> When TFO is used, the check to see if the 'C' flag (deny join id0)
> was
> set was bypassed.
> 
> This flag can be set when TFO is used, so the check should also be
> done
> when TFO is used.
> 
> Fixes: dfc8d0603033 ("mptcp: implement delayed seq generation for
> passive fastopen")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/options.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index
> d47b8a9bc2df2f14645b1b3d3e10fea1b38567b1..cf531f2d815cdfbc772b837def6
> e7d558e64d558 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -985,14 +985,14 @@ static bool check_fully_established(struct
> mptcp_sock *msk, struct sock *ssk,
>  		return false;
>  	}
>  
> -	if (mp_opt->deny_join_id0)
> -		WRITE_ONCE(msk->pm.remote_deny_join_id0, true);
> -
>  	if (unlikely(!READ_ONCE(msk->pm.server_side)))
>  		/* DO-NOT-MERGE: use WARN i/o pr_warn: only for
> MPTCP export */
>  		WARN_ONCE(1, "bogus mpc option on established client
> sk");
>  
>  set_fully_established:
> +	if (mp_opt->deny_join_id0)
> +		WRITE_ONCE(msk->pm.remote_deny_join_id0, true);
> +

This set_fully_established label is not only jumped to during TFO but
also in several other scenarios. I think maybe instead of relocating
the deny_join_id0 check code after this label, we should add a new
label before the deny_join_id0 check and jump to the new label only in
the case of TFO.

WDYT?

Thanks,
-Geliang

>  	mptcp_data_lock((struct sock *)msk);
>  	__mptcp_subflow_fully_established(msk, subflow, mp_opt);
>  	mptcp_data_unlock((struct sock *)msk);
