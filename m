Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15FA54739
	for <mptcp@lists.linux.dev>; Wed, 29 Apr 2026 00:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777422398; cv=none; b=CW48+pETGcjAs5vmHx9JoN3WT/uYulPw/fU72UZ6IBeb4cQRheNMM4u339AqNjym31bVKi3Denn9NPHUZ7i+ivYzo2bFnI3iv4++ChJ/RaPrk1M7rixrDhwDzimIVZgcYbXEcjnW1GYumlMhp5m86OlYLLCfqdNzmKNwSn4nEJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777422398; c=relaxed/simple;
	bh=Tx0WVMe2jFrGQayCxeUAoXbxf9CFOqKc5kTs9O1ryzA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rVKbkenJ5WwtUqSqc6wBRxkI5yp0RwpHPA5rwFm6LDz/Yz58SqRHiOxOdfb8QVRsWpLjPbAv9mIuajm4JbPnUnlYJk7RVzjCXTAYlhFfy4ZcjqjFbfvwhE01ecIksmldRlUnv+vQz+GYKsE+QKlOw4XbbAVvISpgm0pUEJVr+f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7ZUcj6E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7ZUcj6E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4CCC2BCAF;
	Wed, 29 Apr 2026 00:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777422398;
	bh=Tx0WVMe2jFrGQayCxeUAoXbxf9CFOqKc5kTs9O1ryzA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=t7ZUcj6En5OG2eJZyiG9BwoflwAms2/FuMZgQ5gTW+QxayF9EeH+/zEw56kNFcgF0
	 n6S9ICD/oF1dZ+DA2cUaWRR5HPya79WsvqiQqF9AShvbYCDBbAXnIA+BBxpGqNh7z1
	 JAKrsHnrXCs3Lm6XR03wKEX6euV+XakpTm0WAmMgMGFs6IN5yGMWFwnxipAxL4gFEB
	 VIxqCjoyX7pdzo8UeSh1mWlSWz35a7oCByqvFgc3Mv4J/UubdmypokH0Hnuyoo4Z6+
	 6vTVh/8nwVb2RcDItPcY7ahkbxNVMZhwMaHgMYekxJg9dEkSfWLZRNytVHN9ea0Clv
	 nFH3RZ/LRzZaw==
Date: Tue, 28 Apr 2026 17:26:36 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: MPTCP Upstream <mptcp@lists.linux.dev>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: sockopt: increase seq in
 mptcp_setsockopt_all_sf
In-Reply-To: <20260424-mptcp-pm-sockopt-set-all-sf-v1-1-38e7023822f8@kernel.org>
Message-ID: <2d2f2e75-761c-2075-41cd-7e4b4da4962c@kernel.org>
References: <20260424-mptcp-pm-sockopt-set-all-sf-v1-1-38e7023822f8@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 24 Apr 2026, Matthieu Baerts (NGI0) wrote:

> mptcp_setsockopt_all_sf() was missing a call to sockopt_seq_inc(). This
> is required not to cause missing synchronization for newer subflows
> created later on.
>
> This helper is called each time a socket option is set on subflows, and
> future ones will need to inherit this option after their creation.
>
> Fixes: 51c5fd09e1b4 ("mptcp: add TCP_MAXSEG sockopt support")
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> net/mptcp/sockopt.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 79db15903e7a..30b45d2ab38c 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -812,6 +812,10 @@ static int mptcp_setsockopt_all_sf(struct mptcp_sock *msk, int level,
> 		if (ret)
> 			break;
> 	}
> +
> +	if (!ret)
> +		sockopt_seq_inc(msk);
> +

This only appears to be used for TCP_MAXSEG, and the limits checked for 
that sockopt are the same for every TCP socket - so there's currently no 
risk of having the setting applied to some subflows but not others and 
skipping the increment here seems like the right thing to do.

Not sure if that's true for all possible socket options!

Reviewed-by: Mat Martineau <martineau@kernel.org>

> 	return ret;
> }
>
>
> ---
> base-commit: 2b52586ab2905a2e2546a2fcd28448c86677306d
> change-id: 20260424-mptcp-pm-sockopt-set-all-sf-d14c92924e71
>
> Best regards,
> --
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
>
