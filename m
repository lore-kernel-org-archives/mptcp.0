Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB9428467B
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 09:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758014650; cv=none; b=NnphcdlsL1ceuKQngLKF2IxbyQQcVN5DVsY+PnxuHpI60xpAUCv45RA67X8gq2sJ1zvFZW7c6yYwfpAvJZUfWAC6u447BODvoIK0EOmiJMMb/o+/kjWM4UQ+NHtjA/pXKXeF7RPjlhwoF1hDtm5xba4rBiUdYcBIACDQKdnPoQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758014650; c=relaxed/simple;
	bh=LAYaqWsTgXCjH7S6gev9Dxd+XdGVUSPVUC3gHVR9cJ4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iEF3XHeinyFkrlSrgM2fA8hBDButWEN/yIk0BtH3qjbUdJwuFXn+xFkhXR6M0+LEEB6viRMP6sLtzpzk5eByStzGihyb/fKAGfi1eDOy8DY8IZ+65kpGvMvOkIwaS13qLH+k69sN9uFo/odybDsvEeZfcqVxzQtDaUL6Bkd8CDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Co3L/qhR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Co3L/qhR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38ADDC4CEEB;
	Tue, 16 Sep 2025 09:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758014649;
	bh=LAYaqWsTgXCjH7S6gev9Dxd+XdGVUSPVUC3gHVR9cJ4=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=Co3L/qhREGoXe10LBXs8HiWLkjbL0G+xp9QNX0pUmmXZBVOTEEn79Xr5zji9R3W4q
	 gK/SHnt8CBqXbisPC8750o96S+rvIONTRrepL7QsC5HmhNgztb3WTUeBQOVv8Zmeaq
	 Yq6+Wi27WKwnU88udgHZ2MlQOa7A3eaOWr32HACi5P1s6NSq26SxeFXY0yY/cG0hhH
	 7qa9U/zPRiU5OS1xODQ5ALHdO22aen6mEcrsaDm7a90wi0nR8PTGZfUaj6bmyr+DsN
	 te6hav+LPFYpruPpW8uIRL3zsEDpx2ajBaFOKqZ5fe153OP/w7XkX/qTlc1684mlxg
	 mJOfPbUXPHuIw==
Message-ID: <fc540d7f9ae539c3b9dac8757348b22a20ba7e09.camel@kernel.org>
Subject: Re: [PATCH mptcp-net 2/2] selftests: mptcp: join: validate C-flag +
 def limit
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Tue, 16 Sep 2025 17:24:03 +0800
In-Reply-To: <20250915-pm-c-flag-client-default-v1-2-6bb241e4d991@kernel.org>
References: <20250915-pm-c-flag-client-default-v1-0-6bb241e4d991@kernel.org>
	 <20250915-pm-c-flag-client-default-v1-2-6bb241e4d991@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2025-09-15 at 20:11 +0200, Matthieu Baerts (NGI0) wrote:
> The previous commit adds an exception for the C-flag case. The
> 'mptcp_join.sh' selftest is extended to validate this case.
> 
> In this subtest, there is a typical CDN deployment with a client
> where
> MPTCP endpoints have been 'automatically' configured:
> 
> - the server set net.mptcp.allow_join_initial_addr_port=0
> 
> - the client has multiple 'subflow' endpoints, and the default
> limits:
>   not accepting ADD_ADDRs.
> 
> Without the parent patch, the client is not able to establish new
> subflows using its 'subflow' endpoints. The parent commit fixes that.
> 
> The 'Fixes' tag here below is the same as the one from the previous
> commit: this patch here is not fixing anything wrong in the
> selftests,
> but it validates the previous fix for an issue introduced by this
> commit
> ID.
> 
> Fixes: df377be38725 ("mptcp: add deny_join_id0 in
> mptcp_options_received")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/pm.c                                  |  4 +++-
>  net/mptcp/pm_kernel.c                           |  1 +
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 11 +++++++++++
>  3 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index
> fda8d1880224dedbbfb20954f93a04da435346df..5d037f9d4e0b4d158beaaa5a48c
> 4efb50fe9b5cb 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -637,7 +637,9 @@ void mptcp_pm_add_addr_received(const struct sock
> *ssk,
>  		} else {
>  			__MPTCP_INC_STATS(sock_net((struct sock
> *)msk), MPTCP_MIB_ADDADDRDROP);
>  		}
> -	/* id0 should not have a different address ; special case
> for C-flag */
> +	/* - id0 should not have a different address
> +	 * - special case for C-flag: linked to
> fill_local_addresses_vec()
> +	 */

How about squashing this into patch 1.

>  	} else if ((addr->id == 0 &&
> !mptcp_pm_is_init_remote_addr(msk, addr)) ||
>  		   (addr->id > 0 && !READ_ONCE(pm->accept_addr) &&
>  		    (!READ_ONCE(msk->pm.remote_deny_join_id0) ||
> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index
> 408801e20ed6e874b80ccbf38af76abc13615a3a..aae9b92aea4715dabaf3101a034
> 1ab7eab16f407 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -394,6 +394,7 @@ static unsigned int
> fill_local_addresses_vec(struct mptcp_sock *msk,
>  
>  	pernet = pm_nl_get_pernet_from_msk(msk);
>  	subflows_max = mptcp_pm_get_subflows_max(msk);
> +	/* linked to conditions in mptcp_pm_add_addr_received() */

And squash this too.

WDYT?

Thanks,
-Geliang

>  	deny_join_id0 = remote->id && READ_ONCE(msk-
> >pm.remote_deny_join_id0) &&
>  			!READ_ONCE(msk->pm.accept_addr) &&
>  			msk->pm.local_addr_used == 0 &&
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index
> 6055ee5762e13108e5e2924a0e77d58da584d008..e80f90581a2531ac31339ae3543
> 604c68677c232 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -3306,6 +3306,17 @@ deny_join_id0_tests()
>  		run_tests $ns1 $ns2 10.0.1.1
>  		chk_join_nr 1 1 1
>  	fi
> +
> +	# default limit, server deny join id 0 + signal
> +	if reset_with_allow_join_id0 "default limit, server deny
> join id 0" 0 1; then
> +		pm_nl_set_limits $ns1 0 2
> +		pm_nl_set_limits $ns2 0 2
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> +		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr 2 2 2
> +	fi
>  }
>  
>  fullmesh_tests()
