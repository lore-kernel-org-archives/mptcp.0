Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8261B4156;
	Sun, 24 Aug 2025 07:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756019494; cv=none; b=uHVusbgTILR5WBL0KHRagIthPgAZKUozT8Il6BeYRdDfqoJb4bgMyPjoWDWr+b+yeETjN7ntdU7XFBYjtIm66frPNiQlchwiaZLwajHxkBvoAaCIP8jQvskVrL56SXjgTNJtOD+U6yVYmx8TDTG4WfGktlVEa3gYGR6Jm05WzvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756019494; c=relaxed/simple;
	bh=MhSwn0ns/54Asb24fAh2elUQJaSE5u30kZ/8uVFtdEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZns6TD6hEmAuKK71IC3MYhVA7yHvRVT40ZajUWVN9VXhG/2kt5WO0TIpvLCnMS7bYZucPM/0Pohlu316xZgEVnoOhjf9yDfvbhc8PEVHv+IFQrSlLL2VRTf60m4Bz2BcZaZxgKcW9XLIUJyoUznDN/WHZ0K2rRuL53p8L471kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BnJRNXRm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BnJRNXRm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F41C4CEEB;
	Sun, 24 Aug 2025 07:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756019493;
	bh=MhSwn0ns/54Asb24fAh2elUQJaSE5u30kZ/8uVFtdEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BnJRNXRmvrQBqlzFWczOiHch+7RzVRdu1ZBHdFCEvF8uGJFH1a4BBa58FItJAsXaD
	 zPtIY1TEAq0cP7Lw8iFNgecPj5wAPxqMK5KlndanYv/sHaOpIF3K0ExPVOonUKHsKQ
	 j6ODUBd1q18v2la46zf2aQ2sZs5/22DVCVX0o6kI=
Date: Sun, 24 Aug 2025 09:11:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, stable@vger.kernel.org,
	Geliang Tang <tanggeliang@kylinos.cn>, sashal@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.1.y 1/3] mptcp: remove duplicate sk_reset_timer call
Message-ID: <2025082418-drier-exodus-1450@gregkh>
References: <20250822141124.49727-5-matttbe@kernel.org>
 <20250822141124.49727-6-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822141124.49727-6-matttbe@kernel.org>

On Fri, Aug 22, 2025 at 04:11:26PM +0200, Matthieu Baerts (NGI0) wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> commit 5d13349472ac8abcbcb94407969aa0fdc2e1f1be upstream.
> 
> sk_reset_timer() was called twice in mptcp_pm_alloc_anno_list.
> 
> Simplify the code by using a 'goto' statement to eliminate the
> duplication.
> 
> Note that this is not a fix, but it will help backporting the following
> patch. The same "Fixes" tag has been added for this reason.
> 
> Fixes: 93f323b9cccc ("mptcp: add a new sysctl add_addr_timeout")
> Cc: stable@vger.kernel.org
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Link: https://patch.msgid.link/20250815-net-mptcp-misc-fixes-6-17-rc2-v1-4-521fe9957892@kernel.org
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> [ Before commit e4c28e3d5c09 ("mptcp: pm: move generic PM helpers to
>   pm.c"), mptcp_pm_alloc_anno_list() was in pm_netlink.c. The same patch
>   can be applied there without conflicts. ]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/pm_netlink.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index bb1a02e3dc3f..59d6e701d854 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -383,9 +383,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
>  		if (WARN_ON_ONCE(mptcp_pm_is_kernel(msk)))
>  			return false;
>  
> -		sk_reset_timer(sk, &add_entry->add_timer,
> -			       jiffies + mptcp_get_add_addr_timeout(net));
> -		return true;
> +		goto reset_timer;
>  	}
>  
>  	add_entry = kmalloc(sizeof(*add_entry), GFP_ATOMIC);
> @@ -399,6 +397,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
>  	add_entry->retrans_times = 0;
>  
>  	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
> +reset_timer:
>  	sk_reset_timer(sk, &add_entry->add_timer,
>  		       jiffies + mptcp_get_add_addr_timeout(net));
>  
> -- 
> 2.50.0
> 
> 

Did not apply, something feels off here...

