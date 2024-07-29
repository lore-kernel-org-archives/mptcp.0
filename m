Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06628F72
	for <mptcp@lists.linux.dev>; Mon, 29 Jul 2024 01:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722215353; cv=none; b=BviswugRjrQpnyH7zIpDtj5ljzzeKmJvCVKTSitCFFg/t/xtySCI/SJP56H/ZxbWiWXZ0sdmasEhjPpGzEw3zH4uTGPs8qi+bM3w9nn8EKiYXEC/XcRcEhiSqvTXfLO6dEZOxIGPYecmXM8aMPMs5UcoK7aAuxnZczasgIljvDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722215353; c=relaxed/simple;
	bh=2yxy3eKZuS8xiPw0JTNJGt0MEUEFT6XG8zSrO4rJhj4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VfmvfTKUxh5B+R4ViEk4sykgf50U4Q5Phxt3Q3B9jmKjyUGI7O0HkceM/XzD5wbnAuCc2HAogWWzL3ZFASkpj/bncPawH14mwVuWWT29wnYW22DzK+hFsSBNSEBoW9J5uLZWAwxYE3lX+9jDqNb0JM84+1yZaBEybrxNmCjcCHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7oAyBj0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7oAyBj0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DEF5C32782;
	Mon, 29 Jul 2024 01:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722215353;
	bh=2yxy3eKZuS8xiPw0JTNJGt0MEUEFT6XG8zSrO4rJhj4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=A7oAyBj0rHzSORqjirafgs149tyKiCCjHbZxwCz1CmmA0sxiuOf5j0LfnoI4fitdp
	 5ylHpa3q9qiyAF2YyE+DZNPh83yUAaapipJ8as+pNvPbp9HQvL4olW/yaeemtGSur0
	 B4qfw9gz5aKQeFqY2sk1OKbW0maIO7MA58MJyd1/8GuST9TZ7gDOnr6wNAFYC35lmN
	 LeRgkrQ2Upi+QkNbzGl1s6Zd0aoT4oGcCxdvwlghtB+s2G2ch2zYI2o+4iXv+5cbti
	 2ym8T/pyya3E1xxTGdCwhMYV7LL0dDn9EQGe9evCRnov/aAZFI/N8hOmCHO2C+8FHs
	 IuI7t7iVhyBig==
Message-ID: <6b0f7eff5552b0b0e45813e12f397b71fce54098.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v5 04/13] mptcp: pm: only mark 'subflow' endp
 as available
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>
Date: Mon, 29 Jul 2024 09:09:07 +0800
In-Reply-To: <20240726-mptcp-pm-avail-v5-4-fb1117ddeef6@kernel.org>
References: <20240726-mptcp-pm-avail-v5-0-fb1117ddeef6@kernel.org>
	 <20240726-mptcp-pm-avail-v5-4-fb1117ddeef6@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 TO0tfEdfAX7IENcV87h2yAFBZkaA==
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.0-1build2 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Fri, 2024-07-26 at 16:28 +0200, Matthieu Baerts (NGI0) wrote:
> Adding the following warning ...
> 
>   WARN_ON_ONCE(msk->pm.local_addr_used == 0)
> 
> ... before decrementing the local_addr_used counter helped to find a
> bug
> when running the "remove single address" subtest from the
> mptcp_join.sh
> selftests.
> 
> Removing a 'signal' endpoint will trigger the removal of all subflows
> linked to this endpoint via mptcp_pm_nl_rm_addr_or_subflow() with
> rm_type == MPTCP_MIB_RMSUBFLOW. This will decrement the
> local_addr_used
> counter, which is wrong in this case because this counter is linked
> to
> 'subflow' endpoints, and here it is a 'signal' endpoint that is being
> removed.
> 
> Now, the counter is decremented, only if the ID is being used outside
> of mptcp_pm_nl_rm_addr_or_subflow(), only for 'subflow' endpoints,
> and
> if the ID is not 0 -- local_addr_used is not taking into account
> these
> ones. This marking of the ID as being available, and the decrement is
> done no matter if a subflow using this ID is currently available,
> because the subflow could have been closed before.
> 
> Fixes: 06faa2271034 ("mptcp: remove multi addresses and subflows in
> PM")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/pm_netlink.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 8a28fdaf3bb6..3ea417b52ff4 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -833,10 +833,10 @@ static void
> mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
>  			if (rm_type == MPTCP_MIB_RMSUBFLOW)
>  				__MPTCP_INC_STATS(sock_net(sk),
> rm_type);
>  		}
> -		if (rm_type == MPTCP_MIB_RMSUBFLOW)
> -			__set_bit(rm_id ? rm_id : msk-
> >mpc_endpoint_id, msk->pm.id_avail_bitmap);
> -		else if (rm_type == MPTCP_MIB_RMADDR)
> +
> +		if (rm_type == MPTCP_MIB_RMADDR)
>  			__MPTCP_INC_STATS(sock_net(sk), rm_type);
> +
>  		if (!removed)
>  			continue;
>  
> @@ -846,8 +846,6 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct
> mptcp_sock *msk,
>  		if (rm_type == MPTCP_MIB_RMADDR) {
>  			msk->pm.add_addr_accepted--;
>  			WRITE_ONCE(msk->pm.accept_addr, true);
> -		} else if (rm_type == MPTCP_MIB_RMSUBFLOW) {
> -			msk->pm.local_addr_used--;


Is it necessary to call __mark_subflow_endp_available() here? I'm not
sure.

>  		}
>  	}
>  }
> @@ -1443,6 +1441,14 @@ static bool mptcp_pm_remove_anno_addr(struct
> mptcp_sock *msk,
>  	return ret;
>  }
>  
> +static void __mark_subflow_endp_available(struct mptcp_sock *msk, u8
> id)
> +{
> +	/* If it was marked as used, and not ID 0, decrement
> local_addr_used */
> +	if (!__test_and_set_bit(id ? : msk->mpc_endpoint_id, msk-
> >pm.id_avail_bitmap) &&
> +	    id && !WARN_ON_ONCE(msk->pm.local_addr_used == 0))
> +		msk->pm.local_addr_used--;
> +}
> +
>  static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
>  						   const struct
> mptcp_pm_addr_entry *entry)
>  {
> @@ -1476,11 +1482,11 @@ static int
> mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
>  			spin_lock_bh(&msk->pm.lock);
>  			mptcp_pm_nl_rm_subflow_received(msk, &list);
>  			spin_unlock_bh(&msk->pm.lock);
> -		} else if (entry->flags &
> MPTCP_PM_ADDR_FLAG_SUBFLOW) {
> -			/* If the subflow has been used, but now
> closed */
> +		}
> +
> +		if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
>  			spin_lock_bh(&msk->pm.lock);
> -			if (!__test_and_set_bit(entry->addr.id, msk-
> >pm.id_avail_bitmap))
> -				msk->pm.local_addr_used--;
> +			__mark_subflow_endp_available(msk, entry-
> >addr.id);
>  			spin_unlock_bh(&msk->pm.lock);
>  		}
>  
> @@ -1518,6 +1524,7 @@ static int
> mptcp_nl_remove_id_zero_address(struct net *net,
>  		spin_lock_bh(&msk->pm.lock);
>  		mptcp_pm_remove_addr(msk, &list);
>  		mptcp_pm_nl_rm_subflow_received(msk, &list);
> +		__mark_subflow_endp_available(msk, 0);
>  		spin_unlock_bh(&msk->pm.lock);
>  		release_sock(sk);
>  
> @@ -1919,6 +1926,7 @@ static void mptcp_pm_nl_fullmesh(struct
> mptcp_sock *msk,
>  
>  	spin_lock_bh(&msk->pm.lock);
>  	mptcp_pm_nl_rm_subflow_received(msk, &list);
> +	__mark_subflow_endp_available(msk, addr->id);
>  	mptcp_pm_create_subflow_or_signal_addr(msk);
>  	spin_unlock_bh(&msk->pm.lock);
>  }
> 

