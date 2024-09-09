Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BBB1741C3
	for <mptcp@lists.linux.dev>; Mon,  9 Sep 2024 05:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725860508; cv=none; b=q/0rv79M7JDkAmbuiXyV60Ep7n/VMTRs4G0DRpoOyzK/dWswZOlU9YvUJ0nklxyNt5HnPCvT3QjIAV4IDeW2yDNyveHqGiVFIwdwfwzdflGmyurTPXHH9kjJnWxXtXqEINvK3fjTQZeYFkwjF77kczu0R8KPDaegL8c4h8uF/VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725860508; c=relaxed/simple;
	bh=kBVxyqYOmHdGiyAY+Y9864bNHYCAYEVF+L/vno2P87g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ei2FIRD6XPPDSnTmLcxC35MdL5hSPqxU23Nrt3htx+2Ewmp6pe73Jgy6vzEf0nkagx1U5sEQ4zw2WD1t0mA5jZvkQ95VcVJajE0nxjD+j+YAppxZTWziWYqoaZ39n14cuI2X6j3SWvyRg8DQbs1SXCaG+PhERfvNh4qzDq1BVN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0yJuqkk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0yJuqkk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10FF6C4CEC5;
	Mon,  9 Sep 2024 05:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725860507;
	bh=kBVxyqYOmHdGiyAY+Y9864bNHYCAYEVF+L/vno2P87g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=W0yJuqkkFQOhxM0QFu1nEast3AuZv5zq5d1HgU4Do08Xbrtm9gIS1M7vJ+w9CPrB4
	 wDOYkkI1HgNzTcBwy9jJqtjiNtO+YT90B0umEbbIsFpHFzKk7xediihH044XHQ0dAP
	 IkV7A3+K75wpdD6NAebXy2QOfuKf+PWYYyni67qYbO0WalGbg78VWryB2S4HjJoppJ
	 oGHSXDLgFDJtxXsvptBFCRZe9Mq8fFypvei90L1GPQMOm91iQZIj2OIxPFvJ6RqtBM
	 Q5CKdFwukbcrKgO0YN6KYuqwzAAPGA2ZQEfA7+PP4/fnMZTyarsWqhOSd4tNC2nRch
	 6dHsExsbYyK9w==
Message-ID: <e8c52d53384dcac0ab6ff81fdf2033bdca86b642.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 2/2] mptcp: add back mptcp_pm_subflow_closed
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Mon, 09 Sep 2024 13:41:43 +0800
In-Reply-To: <eaf475e7335131061c3a0cea0e6320e956657084.1725853370.git.tanggeliang@kylinos.cn>
References: <cover.1725853370.git.tanggeliang@kylinos.cn>
	 <eaf475e7335131061c3a0cea0e6320e956657084.1725853370.git.tanggeliang@kylinos.cn>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2024-09-09 at 11:45 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The MPTCP path manager event handler mptcp_pm_subflow_closed
> interface
> is added in the commit "mptcp: Add path manager interface", but
> removed
> in the commit "mptcp: do not block subflows creation on errors".
> 
> This patch adds it back and changes its 2nd parameter from "u8 id" to
> "struct sock *ssk". Invoke mptcp_event with the
> MPTCP_EVENT_SUB_CLOSED
> event type in it.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/pm.c       | 7 +++++++
>  net/mptcp/protocol.c | 2 +-
>  net/mptcp/protocol.h | 1 +
>  3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 16c336c51940..23f73f07a9e7 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -176,6 +176,13 @@ void mptcp_pm_subflow_established(struct
> mptcp_sock *msk)
>  	spin_unlock_bh(&pm->lock);
>  }
>  
> +void mptcp_pm_subflow_closed(struct mptcp_sock *msk, struct sock
> *ssk)
> +{
> +	pr_debug("msk=%p", msk);

"\n" is missing, should be:

	pr_debug("msk=%p\n", msk);

Thanks,
-Geliang

> +
> +	mptcp_event(MPTCP_EVENT_SUB_CLOSED, msk, ssk, GFP_KERNEL);
> +}
> +
>  void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
>  				 const struct mptcp_subflow_context
> *subflow)
>  {
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index a12149d8f718..69859eb2d891 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2515,7 +2515,7 @@ void mptcp_close_ssk(struct sock *sk, struct
> sock *ssk,
>  	subflow->close_event_done = true;
>  
>  	if (sk->sk_state == TCP_ESTABLISHED)
> -		mptcp_event(MPTCP_EVENT_SUB_CLOSED, mptcp_sk(sk),
> ssk, GFP_KERNEL);
> +		mptcp_pm_subflow_closed(mptcp_sk(sk), ssk);
>  
>  	/* subflow aborted before reaching the fully_established
> status
>  	 * attempt the creation of the next subflow
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index d25d2dac88a5..0c8ab6071a3f 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -996,6 +996,7 @@ void mptcp_pm_fully_established(struct mptcp_sock
> *msk, const struct sock *ssk);
>  bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk);
>  void mptcp_pm_connection_closed(struct mptcp_sock *msk);
>  void mptcp_pm_subflow_established(struct mptcp_sock *msk);
> +void mptcp_pm_subflow_closed(struct mptcp_sock *msk, struct sock
> *ssk);
>  bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk);
>  void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
>  				 const struct mptcp_subflow_context
> *subflow);

