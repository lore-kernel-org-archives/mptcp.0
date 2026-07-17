Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686CA38F658
	for <mptcp@lists.linux.dev>; Fri, 17 Jul 2026 18:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784314691; cv=none; b=HXrgaoibA+noIEQwA2WtthAGLrGtC+Aew9Ic9AM2zCE99f4CAsOJlZl2jHXT9yAmIhwsE1IGlEpLUWYr6AqhzsoTF3ayfGQPSVeSPsmet/P+WuLISwA6yXZnrXPh+LSAX6VfRolNjiQVn0K22xJIyt/oii5e3XwT+sLRyCmGRto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784314691; c=relaxed/simple;
	bh=VS07qy7w6qpbawR9I7y/+Wk+6hu8Z54u//P9uWkzguE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gY0/6HzIo2oskKLrnqtfXZOIauckKR4JhJOeseuhMzNgHwgr1IaHB2DbO8z9AEQ5qilrxYRMPJj73Z8kDTcboQ2BmNwz4SX7qC3PyeAYjpzOOeryBYfGK7UhgzAqDXhugZ5WaGNbizlQYxtTnoGTkTj0w3LHpaY6Nt6IQ/pJAkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lp7cPhfY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lp7cPhfY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD291F000E9;
	Fri, 17 Jul 2026 18:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784314689;
	bh=vvKmYJCP+Cy59ROmtIRrwdCufuvkKnjHhHRFQ6fsJME=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=lp7cPhfYccPwwnBytOeClbv830/TOGzgLLU47fsCohsNLqxpGItRnWmjjgvx2N07E
	 A4/HxhXJ3ZcSArAJLHAxqMjSt7NbEvMK/kaCpRda7T8zy6ephzGgY0BlPLNDVGAOhZ
	 s37n9xHQXw4meovBvEAd1iydA33JZA7P/oeVTFHamfAKj6Bj3yjnbBrWubqohFXXKb
	 MgsnTy393PFmC1ZGdICs/R8h3hTOtIhUhY9a0O491fmlJAvt8GqL1X0HB0qf7oi3o+
	 SI4PX5JMHc1VNcC2dgsE4KoDcAUy/BTe3B0/skxq0r7MkyCAFLluyb1gx3jCNxt2hr
	 qgKymts21XKqg==
Date: Fri, 17 Jul 2026 11:58:08 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: MPTCP Linux <mptcp@lists.linux.dev>, Frank Ranner <frank.ranner@intel.com>, 
    kernel test robot <lkp@intel.com>
Subject: Re: [PATCH mptcp-net] mptcp: fix BUILD_BUG_ON on legacy ARM config
In-Reply-To: <20260707-mptcp-opt-fix-config_aeabi-v1-1-f428d0aa0318@kernel.org>
Message-ID: <96b90ef0-7786-ee9b-063e-83498e8e3dc7@kernel.org>
References: <20260707-mptcp-opt-fix-config_aeabi-v1-1-f428d0aa0318@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 7 Jul 2026, Matthieu Baerts (NGI0) wrote:

> The 0-day bot managed to find kernel configs that cause build failures,
> e.g. when using the StrongARM SA1100 target (ARMv4).
>
> On such legacy ARM architecture, all structures are apparently aligned
> to 32 bits, causing build issue here. Indeed, on such architecture,
> 'flags' size is not equivalent to sizeof(u16) as expected, but to
> sizeof(u32).
>
> Instead, use memset(). It was not used before to ensure a simple clear
> operation was used by the compiler. But at the end, it shouldn't matter,
> and the compiler should optimise this to the same operation with or
> without memset() when -O above 0 is used. So let's switch to memset() to
> fix this issue, and reduce this complexity.
>
> Fixes: 5e939544f9d2 ("mptcp: fix uninit-value in mptcp_established_options")
> Suggested-by: Frank Ranner <frank.ranner@intel.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202605312026.Srgsz7Tp-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202607031100.upQfRZTM-lkp@intel.com/
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> net/mptcp/options.c | 5 +----
> 1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 0ca60314d667..47d4a1b520d8 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -571,10 +571,7 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
> 	bool ret = false;
>
> 	/* Zero `use_ack` and `use_map` flags with one shot. */
> -	BUILD_BUG_ON(sizeof_field(struct mptcp_ext, flags) != sizeof(u16));
> -	BUILD_BUG_ON(!IS_ALIGNED(offsetof(struct mptcp_ext, flags),
> -				 sizeof(u16)));
> -	*(u16 *)&opts->ext_copy.flags = 0;
> +	memset(&opts->ext_copy.flags, 0, sizeof(opts->ext_copy.flags));
> 	opts->csum_reqd = READ_ONCE(msk->csum_enabled);
> 	mpext = skb ? mptcp_get_ext(skb) : NULL;

This change LGTM, thanks Matthieu

Reviewed-by: Mat Martineau <martineau@kernel.org>

