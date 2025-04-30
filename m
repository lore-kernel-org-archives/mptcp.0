Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DA8219A8A
	for <mptcp@lists.linux.dev>; Wed, 30 Apr 2025 09:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746004512; cv=none; b=ZrzRLjliz6SFXgCGjRKvneWL00qH6ez38Cs1luFhT8wqsJA7Q/2YnGuHlLAaQw8Y9FI+s6bIE983NWZHJebmUEiWOXCtMycmJm6tBcdYM3ytTHyZKQSkW0+H3RdSP/ib/lM3x5S18+Xoi2qO/US7YWJOu6HMeQufAGED7bl/mM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746004512; c=relaxed/simple;
	bh=FanUIcM6xBh8VLBFK60OriOKbCObreGtqQM9/HPrbZ4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bgPAN712lfbO8gLk/72XV8e/rFgol+Y+9fq4JlcFbyC7EfhXwLMJxdcFDp2+SlqBlZbj1vvIMih2feFhovTDUUxYvHNO5grRHl/Fp6RZma+qCWaBBkqnsk3s7KFfRhdt4qX4XEo6Sk8VJqZLNNpkHzzQJiR2Wxmf+P6b6Jk37SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQL5Gwgr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQL5Gwgr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7E4C4CEEA;
	Wed, 30 Apr 2025 09:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746004511;
	bh=FanUIcM6xBh8VLBFK60OriOKbCObreGtqQM9/HPrbZ4=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=ZQL5GwgrTy8lgVSQV40SkLTZaTj5o9/5gGSSGtSd45dBlBhjBSd/MVeS19aHrKvqU
	 uiMer+o57UdgJ2Oh7G+x2QMD6zhESiQWQHeFikuzYW9de9z4ESzdKfU8w5JV3KtwyE
	 +nZ9pK6O2g54TevhwzTrjbo/RJjUE9CAjFvvva7o/bqmoQFe1QyjqK3Xa+jmRJdva+
	 LAISKNo4LTOzwH6WJHQ5o28OZFJqO8DiZ1t7UxaTx4i+YC4paXvX6CQmGYyAwJmXIS
	 eBSTJvVaZx79CGg22ntV/hQu507/zvrK+jbcM/Ry3HxJ3RIwPTeBnIclgpdeW5tiT5
	 4HVB7arYQhzPA==
Message-ID: <e89f06093e7837386e9f38fdeb2e660f67a3bad3.camel@kernel.org>
Subject: Re: [mptcp-net] mptcp: pm: Defer freeing of MPTCP userspace path
 manager entries
From: Geliang Tang <geliang@kernel.org>
To: Mat Martineau <martineau@kernel.org>, mptcp@lists.linux.dev
Date: Wed, 30 Apr 2025 17:15:05 +0800
In-Reply-To: <20250410025931.1882967-1-martineau@kernel.org>
References: <20250410025931.1882967-1-martineau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Mat,

On Wed, 2025-04-09 at 19:59 -0700, Mat Martineau wrote:
> When path manager entries are deleted from the local address list,
> they
> are first unlinked from the address list using list_del_rcu(). The
> entries must not be freed until after the RCU grace period, but the
> existing code immediately frees the entry.
> 
> Use kfree_rcu_mightsleep() and adjust sk_omem_alloc in open code
> instead
> of using the sock_kfree_s() helper. This code path is only called in
> a
> netlink handler, so the "might sleep" function is preferable to
> adding
> a rarely-used rcu_head member to struct mptcp_pm_addr_entry.
> 
> Signed-off-by: Mat Martineau <martineau@kernel.org>
> ---
> 
> My first implementation did add a sock_kfree_rcu_s() function like
> Geliang suggested, but kfree_rcu() is a macro so that approach got
> complicated. sock_kfree_rcu_s_mightsleep() seemed cumbersome, so I

I thought about this again recently, and I think sock_krfree_s() is a
better name, and it matches sock_kfree_s() and sock_kzfree_s() better.
I just sent a patch named "sock: add sock_krfree_s helper" for this to
MPTCP ML, please review it for me.

Thanks,
-Geliang

> went
> ahead and open-coded it. This should be applied after Geliang's v2,
> which will delete similar code in a helper function.
> 
> ---
>  net/mptcp/pm_userspace.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 7fc19b844384..959af1e42a97 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -337,7 +337,8 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb,
> struct genl_info *info)
>  
>  	release_sock(sk);
>  
> -	sock_kfree_s(sk, match, sizeof(*match));
> +	kfree_rcu_mightsleep(match);
> +	atomic_sub(sizeof(*match), &sk->sk_omem_alloc);
>  
>  	err = 0;
>  out:

