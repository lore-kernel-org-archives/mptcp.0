Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5007136E37
	for <mptcp@lists.linux.dev>; Mon, 24 Mar 2025 10:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742811369; cv=none; b=IBgM2sFVu8Hnz+HnKWGoJgxDNtdfObHxM0e4d8evenUhH7XT35kndxUB26lLGeh+iQKk5WIiSg6AbcbcMqUMmnr10w9IJNT9D5SMy5qn3cGZJDOGzXlqLoT4k4Vd4SiQDkbBQFnBcfuaLQ1GNjxK1Sm+iFXHKIeRIyZk0aNtbJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742811369; c=relaxed/simple;
	bh=usxVOsjkuASwxxwwjS7l5RGqrqkttKUYlFTyeytKOj0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qt4LW+FeWgLhyFhhR/kYeDwyn92ebjGhoj5UZS4GN0K+gfFkdrGSIITPOd9GuvwUPGt/OcyBdCUy/sHS9Bq5ez6Jmw7JkBwbEoJ9xiXIsuaoLfTCNOTz+dK+/35YY0UrQTKzag/j5GOTbHkwEb6KGOktIX7tdWFVHTdD9eXPS+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P533fb/o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P533fb/o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6310EC4CEE4;
	Mon, 24 Mar 2025 10:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742811369;
	bh=usxVOsjkuASwxxwwjS7l5RGqrqkttKUYlFTyeytKOj0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=P533fb/oY2nF+d3wNqzgb1bXJNlgWb6A2dyBpLQ/xCiDbXJPsaA9/4tDiqwIp+C2g
	 JriBGWzsKCaZhrVd4Cuqf6UZmDN5+wucV0E5rNTTwhbZDiaNA6dNDwhRy2HMxmJy24
	 s7Fd2ONpzbwTs5DV55Y6hDTwmW47YoO4sgbCwoO9CG2iAhjROoKWCFqOeiBN0tCXyS
	 gp8BtW6CGiQ7FIGvlWggrWABHxqXenGZoEsdXvnSezT1e+NZsAZIrI4X2lZ35IYfLn
	 lkTf+LRfRmq0uwUds2fRidfY5qNOLESuUQVL3+TWxgr05ciBBTAj6iM4pDSL4M17gP
	 QWTzqhq7aKlIw==
Message-ID: <6e82b555f5a3b3dd0b032743880c1258673b6ed9.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v4 6/9] mptcp: pm: add rm_addr_received()
 interface
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Mon, 24 Mar 2025 18:16:05 +0800
In-Reply-To: <73e63af9c3dc74deb1b6aa79a9b7ed57f331ba33.1742804266.git.tanggeliang@kylinos.cn>
References: <cover.1742804266.git.tanggeliang@kylinos.cn>
	 <73e63af9c3dc74deb1b6aa79a9b7ed57f331ba33.1742804266.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2025-03-24 at 16:19 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch adds an optional .rm_addr_received interface for struct
> mptcp_pm_ops and invokes it in mptcp_pm_rm_addr_or_subflow().
> 
> This interface is only implemented in the in-kernel PM as a wrapper
> of mptcp_pm_nl_rm_addr().
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  include/net/mptcp.h   | 1 +
>  net/mptcp/pm.c        | 4 ++--
>  net/mptcp/pm_kernel.c | 6 ++++++
>  3 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 5118d11d2ee9..3f06fbd2a908 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -128,6 +128,7 @@ struct mptcp_pm_ops {
>  	void (*established)(struct mptcp_sock *msk);
>  	void (*subflow_established)(struct mptcp_sock *msk);
>  	void (*add_addr_received)(struct mptcp_sock *msk);
> +	void (*rm_addr_received)(struct mptcp_sock *msk, u8 id);
>  
>  	char			name[MPTCP_PM_NAME_MAX];
>  	struct module		*owner;
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 71589cd5dee7..bf3c19defe98 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -703,8 +703,8 @@ static void mptcp_pm_rm_addr_or_subflow(struct
> mptcp_sock *msk,
>  
>  		if (rm_type == MPTCP_MIB_RMADDR) {
>  			__MPTCP_INC_STATS(sock_net(sk), rm_type);
> -			if (removed && mptcp_pm_is_kernel(msk))
> -				mptcp_pm_nl_rm_addr(msk, rm_id);
> +			if (removed && msk->pm.ops-
> >rm_addr_received)
> +				msk->pm.ops->rm_addr_received(msk,
> rm_id);
>  		}
>  	}
>  }
> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index 4f4791620072..1a71676bdf43 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -1391,6 +1391,11 @@ static void
> mptcp_pm_kernel_add_addr_received(struct mptcp_sock *msk)
>  	mptcp_pm_nl_add_addr_received(msk);
>  }
>  
> +static void mptcp_pm_kernel_rm_addr_received(struct mptcp_sock *msk,
> u8 id)
> +{
> +	mptcp_pm_nl_rm_addr(msk, id);

Now we can make mptcp_pm_nl_rm_addr static.
Will update this in v5.

Thanks,
-Geliang

> +}
> +
>  static void mptcp_pm_kernel_init(struct mptcp_sock *msk)
>  {
>  	bool subflows_allowed = !!mptcp_pm_get_subflows_max(msk);
> @@ -1417,6 +1422,7 @@ struct mptcp_pm_ops mptcp_pm_kernel = {
>  	.established		= mptcp_pm_kernel_established,
>  	.subflow_established	=
> mptcp_pm_kernel_subflow_established,
>  	.add_addr_received	= mptcp_pm_kernel_add_addr_received,
> +	.rm_addr_received	= mptcp_pm_kernel_rm_addr_received,
>  	.init			= mptcp_pm_kernel_init,
>  	.name			= "kernel",
>  	.owner			= THIS_MODULE,

