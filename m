Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5201F8906
	for <mptcp@lists.linux.dev>; Tue, 21 Jan 2025 23:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737500412; cv=none; b=jv/kuZQUU5915Dtc28ITdfRDKSNACQd6tOx81Emk4IsdxS/KIpJe91F0H8J6/zHc2iJvw+ClYpoITU1Z1P+u8spiHmcW299lUe6VB7TnHzvc2AHnmUNJM9DNQuGBdMB8jC5aGNxwK/q5CY+hJDdpDCOJdzlosgA4R8IdbVUgFZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737500412; c=relaxed/simple;
	bh=Ci263cfnmmE91vzOOiS+UGiC+PuGoI5Oc/Gc6s3i070=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=U4H6f1wzIs2NWpIC3z/j7a/smG9vuESgYSJw9LP5hy0k3iIVDHv+vNY0nw82c6xnisXd3THhaep7DH/BM78ji10OHDfI4//GsRZh/KlHpsQ4cOv8RG/DFLRXKi3ofF95gPcaMqmvPdlsuV+2V8X8EFfhA+DF55cEsu7eterHc1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=as2OawAq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="as2OawAq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68901C4CEDF;
	Tue, 21 Jan 2025 23:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737500411;
	bh=Ci263cfnmmE91vzOOiS+UGiC+PuGoI5Oc/Gc6s3i070=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=as2OawAqXF7jl4v8OZPACIQ47eUxnolxlReS7ogEUeLzPRNCQntRaRtq93ciJqQSK
	 iQxymYzt9WboNmyQsk1r3Oa3lSfy4Dt0Cdv2WQNVPYQ1sZ8BsJk8qgwUAbszQdwCFw
	 WkbP03/bqXUWoXzTh84mdIZJZtRfp7nFTfQ3WbGl2cCCvk38iIIf/0T3K6EFImcrVw
	 y5BeakMUgI8uiwWDmJMP3Hqa4Z1KOsvdlLwbntFiuJ1mhFN2elz2++KPshzRyIbCPB
	 SGQUe4uFeDlQzg36tJqkGdQc30SBezmG/RSUgtVfh9U7PZgIfOsfDG/Lfo1qBwHN3D
	 A/qNTEYPrrvWA==
Date: Tue, 21 Jan 2025 15:00:11 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v2 2/3] mptcp: pm: remove unused ret value to
 set flags
In-Reply-To: <20250117-mptcp-issue-540-v2-2-a194740fb380@kernel.org>
Message-ID: <60182b35-e847-8766-cc9b-9c53841bdd3d@kernel.org>
References: <20250117-mptcp-issue-540-v2-0-a194740fb380@kernel.org> <20250117-mptcp-issue-540-v2-2-a194740fb380@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 17 Jan 2025, Matthieu Baerts (NGI0) wrote:

> The returned value is not used, it can then be dropped.
>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Thanks Matthieu

Reviewed-by: Mat Martineau <martineau@kernel.org>

> ---
> net/mptcp/pm_netlink.c | 10 ++++------
> 1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 99705a9c2238c6be96e320e8cd1d12bfa0e0e7f0..ff1e5695dc1db5e32d5f45bef7cf22e43aea0ef1 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1922,13 +1922,11 @@ static void mptcp_pm_nl_fullmesh(struct mptcp_sock *msk,
> 	spin_unlock_bh(&msk->pm.lock);
> }
>
> -static int mptcp_nl_set_flags(struct net *net,
> -			      struct mptcp_addr_info *addr,
> -			      u8 bkup, u8 changed)
> +static void mptcp_nl_set_flags(struct net *net, struct mptcp_addr_info *addr,
> +			       u8 bkup, u8 changed)
> {
> 	long s_slot = 0, s_num = 0;
> 	struct mptcp_sock *msk;
> -	int ret = -EINVAL;
>
> 	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
> 		struct sock *sk = (struct sock *)msk;
> @@ -1938,7 +1936,7 @@ static int mptcp_nl_set_flags(struct net *net,
>
> 		lock_sock(sk);
> 		if (changed & MPTCP_PM_ADDR_FLAG_BACKUP)
> -			ret = mptcp_pm_nl_mp_prio_send_ack(msk, addr, NULL, bkup);
> +			mptcp_pm_nl_mp_prio_send_ack(msk, addr, NULL, bkup);
> 		if (changed & MPTCP_PM_ADDR_FLAG_FULLMESH)
> 			mptcp_pm_nl_fullmesh(msk, addr);
> 		release_sock(sk);
> @@ -1948,7 +1946,7 @@ static int mptcp_nl_set_flags(struct net *net,
> 		cond_resched();
> 	}
>
> -	return ret;
> +	return;
> }
>
> int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
>
> -- 
> 2.47.1
>
>
>
