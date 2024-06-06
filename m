Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10C54E1CA
	for <mptcp@lists.linux.dev>; Thu,  6 Jun 2024 18:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717700322; cv=none; b=eq0linMFFXS4iE4AeUdRKO9i0c1TJsQdpz1v8S+0TvW9uAkwOj2Qmqf1qEjKyVm+vc6cbJdH2d+wP/JCTxfuR+r0heSFKN7swAFjB27utayjxBbFLKlhTg2bklwtuEHSGptL+VDghkCojKo+50yIfNunexE1vBwQdSaHLadCTHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717700322; c=relaxed/simple;
	bh=nB1QNND1z7idwp9v8vZ9F2SF9OyZmK7KTyxVFlE+hcg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Bdzi5ZJuOf8FREBOsEelhQE5ZQExa219K9AoAyDgepHTh727Hwg4LOml1CjB2WWSrkPBrc8HstJ9EpJL76yxxaSgxM9u+UE+gOIdCYoTvYhKmncRzguu4cqFXwfrpUNVRdaNmgguCsXFh/eDd41xZdGOkrNWAffkZ4FfqhXWjUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lpu/xDDh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lpu/xDDh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50FDEC2BD10;
	Thu,  6 Jun 2024 18:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717700322;
	bh=nB1QNND1z7idwp9v8vZ9F2SF9OyZmK7KTyxVFlE+hcg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Lpu/xDDh8jyyT5mYxFHNAeFT2AIiXI6aLbKzxZVUgLyClTIHNqV6jhHGjhuTJJdhl
	 uSJLkoGmAkrMXeeNDp0ewynjTl32fVKpFVUCz+g9E3/CcDMfcwTtucku/mDf5H9k2r
	 5wuXhd6fPDEbRphrHla7PC78454C8smmt3RuFiWghdRZmRSf85ToheDnogsA6G0U0M
	 hqA2ktJYvWPaFCHTZyjeiboKwmrdt0qTSmwcHQ5OgMZ1tdDxS6pIsvxjbTfr4jlCoi
	 op+sG9MP3tcaPcT5Ihl4ZFlH2U7SkzHxzA3dsxg8gmEi3sI16qWas/mDBCwoBqRvkx
	 qF3lo9jAt+P2Q==
Date: Thu, 6 Jun 2024 11:58:41 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev, YonglongLi <liyonglong@chinatelecom.cn>
Subject: Re: [PATCH mptcp-net v2] mptcp: pm: update add_addr counters after
 connect
In-Reply-To: <20240606-mptcp-pm-inc-cnt-sf-create-v2-1-67c4759a4885@kernel.org>
Message-ID: <02951816-fe62-4d3b-4d78-20c293e1df26@kernel.org>
References: <20240606-mptcp-pm-inc-cnt-sf-create-v2-1-67c4759a4885@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 6 Jun 2024, Matthieu Baerts (NGI0) wrote:

> From: YonglongLi <liyonglong@chinatelecom.cn>
>
> The creation of new subflows can fail for different reasons. If no
> subflow have been created using the received ADD_ADDR, the related
> counters should not be updated, otherwise they will never be decremented
> for events related to this ID later on.
>
> For the moment, the number of accepted ADD_ADDR is only decremented upon
> the reception of a related RM_ADDR, and only if the remote address ID is
> currently being used by at least one subflow. In other words, if no
> subflow can be created with the received address, the counter will not
> be decremented. In this case, it is then important not to increment
> pm.add_addr_accepted counter, and not to modify pm.accept_addr bit.
>
> Note that this patch does not modify the behaviour in case of failures
> later on, e.g. if the MP Join is dropped or rejected.
>
> The "remove invalid addresses" MP Join subtest has been modified to
> validate this case. The broadcast IP address is added before the "valid"
> address that will be used to successfully create a subflow, and the
> limit is decreased by one: without this patch, it was not possible to
> create the last subflow, because:
>
> - the broadcast address would have been accepted even if it was not
>  usable: the creation of a subflow to this address results in an error,
>
> - the limit of 2 accepted ADD_ADDR would have then been reached.
>
> Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
> Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: YonglongLi <liyonglong@chinatelecom.cn>
> ---
> v2 (from Matt):
> - Clarify the commit message
> - Replace the Fixes tag
> - No new line after the Fixes tag
> - Use 'sf_created' instead 'subflow_added'
> - Use '__mptcp_subflow_connect() == 0' instead of '!__mptcp_subflow_connect'
> - Validate the modification in the selftests
> - Added my Co-dev tag
> - Link to v1: https://lore.kernel.org/mptcp/1716543865-37448-1-git-send-email-liyonglong@chinatelecom.cn

v2 lgtm, thanks Matthieu and Yonglong Li:

Reviewed-by: Mat Martineau <martineau@kernel.org>

> ---
> net/mptcp/pm_netlink.c                          | 16 ++++++++++------
> tools/testing/selftests/net/mptcp/mptcp_join.sh |  4 ++--
> 2 files changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 766a8409fa67..ea9e5817b9e9 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -677,6 +677,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
> 	unsigned int add_addr_accept_max;
> 	struct mptcp_addr_info remote;
> 	unsigned int subflows_max;
> +	bool sf_created = false;
> 	int i, nr;
>
> 	add_addr_accept_max = mptcp_pm_get_add_addr_accept_max(msk);
> @@ -704,15 +705,18 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
> 	if (nr == 0)
> 		return;
>
> -	msk->pm.add_addr_accepted++;
> -	if (msk->pm.add_addr_accepted >= add_addr_accept_max ||
> -	    msk->pm.subflows >= subflows_max)
> -		WRITE_ONCE(msk->pm.accept_addr, false);
> -
> 	spin_unlock_bh(&msk->pm.lock);
> 	for (i = 0; i < nr; i++)
> -		__mptcp_subflow_connect(sk, &addrs[i], &remote);
> +		if (__mptcp_subflow_connect(sk, &addrs[i], &remote) == 0)
> +			sf_created = true;
> 	spin_lock_bh(&msk->pm.lock);
> +
> +	if (sf_created) {
> +		msk->pm.add_addr_accepted++;
> +		if (msk->pm.add_addr_accepted >= add_addr_accept_max ||
> +		    msk->pm.subflows >= subflows_max)
> +			WRITE_ONCE(msk->pm.accept_addr, false);
> +	}
> }
>
> void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index aea314d140c9..108aeeb84ef1 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -2249,10 +2249,10 @@ remove_tests()
> 	if reset "remove invalid addresses"; then
> 		pm_nl_set_limits $ns1 3 3
> 		pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
> -		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
> 		# broadcast IP: no packet for this address will be received on ns1
> 		pm_nl_add_endpoint $ns1 224.0.0.1 flags signal
> -		pm_nl_set_limits $ns2 3 3
> +		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
> +		pm_nl_set_limits $ns2 2 2
> 		addr_nr_ns1=-3 speed=10 \
> 			run_tests $ns1 $ns2 10.0.1.1
> 		chk_join_nr 1 1 1
>
> ---
> base-commit: 91419da702aaa1ad2b0110a07fd50a1a38bade6c
> change-id: 20240606-mptcp-pm-inc-cnt-sf-create-dfc49d798f13
>
> Best regards,
> -- 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
>
