Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D852F998D
	for <mptcp@lists.linux.dev>; Thu,  6 Nov 2025 07:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762415793; cv=none; b=jYQZbv4caJjupjDgatuqSn3ZWryjUEHjeXX8VmVhe03px6kUcfLgti+1me66J28AZnzCLzCUSrM2lSHYBEmfDsOd0KMFAERkHAApPzsUjjxlPwbdKEX8vJdk3Bila5pm2OMrNwD9EQD+ZO7+S0DYf3MLEX+qsvFgdCmpdJvy0mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762415793; c=relaxed/simple;
	bh=IF5vK2VoMjIoj02u4XvJ9s8rUsEpCuuXOoHwCdea0hM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I0aEj8o8rIK1hV9qQOwYSAyJ0bo8IpuyhDd9JnnpQUdEXZsnWWn+MA48dqaUj5BVi3zvU3k6+V0j85FaaY9hCEhdFhnVj4BtOJk4iNqU2Pi0pLMRsIkMp+IEoLQZqo1Tsaw8yZzxqeN05cb/DCzu7NxuejWS9pR8HoOeBIMbj6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gds5LGud; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gds5LGud"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F829C4CEF7;
	Thu,  6 Nov 2025 07:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762415793;
	bh=IF5vK2VoMjIoj02u4XvJ9s8rUsEpCuuXOoHwCdea0hM=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=Gds5LGudNIEqhznUXtHlGoFI8ymG9aj1UMc4jk/eqA5MmN4foeuAqi8ROF4hP8m/R
	 R3BBAcf3yN5C8uSzfKewEzSsDPL6dniLnElVU+iwvjhsKV7GmzqyK+/XDVMgRmPtp2
	 mTbWFuo+94POLDw0Hvo+nE3DkLISGKMCUj5E2mt51DJpQXviJFA7sjjPCVV57KhLqB
	 wvcaqUrOGqhQ8t3Se+Pj2ZuhnxE6Lzb//Ev3Qtlp9KtBGOIjB5/hG+7AzRPl4gIII9
	 YDNZFd9iUnnQX6bmTjXyF9l/31y7sUhXWNS1NtnpHrALguDhHqfchZdLD9oHV4iU/N
	 h4d6H1C1B30Qg==
Message-ID: <a778abeccfe59b89cbd92b892eb310dd8a6db79a.camel@kernel.org>
Subject: Re: [PATCH mptcp-net 2/2] mptcp: fix duplicate reset on fastclose
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, Matthieu Baerts <matttbe@kernel.org>, 
	mptcp@lists.linux.dev
Date: Thu, 06 Nov 2025 15:56:28 +0800
In-Reply-To: <0395b95bc89964254ad9a10a9e6da9fd58b6f7a7.1762354419.git.pabeni@redhat.com>
References: 
	<962efc0fd760155328967f4023a899e520e6f9a7.1762354419.git.pabeni@redhat.com>
	 <0395b95bc89964254ad9a10a9e6da9fd58b6f7a7.1762354419.git.pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paolo, Matt,

On Wed, 2025-11-05 at 15:54 +0100, Paolo Abeni wrote:
> The CI reports sporadic failures of the fastclose self-tests. The
> root
> cause is a duplicate reset, not carrying the relevant MPTCP option.
> In the failing scenario the bad reset is received by the peer before
> the fastclose one, preventing the reception of the latter.
> 
> Indeed there is window of opportunity at fastclose time for the
> following
> race:
> 
> mptcp_do_fastclose
>   __mptcp_close_ssk
>     __tcp_close()
>       tcp_set_state() [1]
>       tcp_send_active_reset() [2]
> 
> After [1] the stack will send reset to in-flight data reaching the
> now
> closed port. Such reset may race with [2].
> 
> Address the issue explicitly sending a single reset on fastclose
> before
> explicitly moving the subflow to close status.
> 
> Fixes: d21f83485518 ("mptcp: use fastclose on more edge scenarios");
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/596
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/mptcp/protocol.c                          | 34 ++++++++++++-----
> --
>  .../testing/selftests/net/mptcp/mptcp_join.sh |  2 --
>  2 files changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 7c66300c9fe1..200d8040cf12 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2451,20 +2451,13 @@ static void __mptcp_close_ssk(struct sock
> *sk, struct sock *ssk,
>  
>  	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
>  
> -	if ((flags & MPTCP_CF_FASTCLOSE) &&
> !__mptcp_check_fallback(msk)) {
> -		/* be sure to force the tcp_close path
> -		 * to generate the egress reset
> -		 */
> -		ssk->sk_lingertime = 0;
> -		sock_set_flag(ssk, SOCK_LINGER);
> -		subflow->send_fastclose = 1;
> -	}
> +	if (subflow->send_fastclose && ssk->sk_state != TCP_CLOSE)
> +		tcp_set_state(ssk, TCP_CLOSE);
>  
>  	need_push = (flags & MPTCP_CF_PUSH) &&
> __mptcp_retransmit_pending_data(sk);
>  	if (!dispose_it) {
>  		__mptcp_subflow_disconnect(ssk, subflow, flags);
>  		release_sock(ssk);
> -
>  		goto out;
>  	}
>  
> @@ -2762,9 +2755,26 @@ static void mptcp_do_fastclose(struct sock
> *sk)
>  	struct mptcp_sock *msk = mptcp_sk(sk);
>  
>  	mptcp_set_state(sk, TCP_CLOSE);
> -	mptcp_for_each_subflow_safe(msk, subflow, tmp)
> -		__mptcp_close_ssk(sk,
> mptcp_subflow_tcp_sock(subflow),
> -				  subflow, MPTCP_CF_FASTCLOSE);

It seems that the MPTCP_CF_FASTCLOSE check in
__mptcp_subflow_disconnect() can also be removed. In this case, the
third parameter "flags" of __mptcp_subflow_disconnect() will no longer
be useful and can be deleted as well. At the same time, the
MPTCP_CF_FASTCLOSE macro definition can also be removed.

> +
> +	/* Explicitly send the fastclose reset as need */
> +	if (__mptcp_check_fallback(msk))
> +		return;
> +
> +	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +
> +		lock_sock(ssk);
> +
> +		/* Some subflow socket states don't allow/need a
> reset.*/
> +		if ((1 << ssk->sk_state) & (TCPF_LISTEN |
> TCPF_CLOSE))
> +			goto unlock;
> +
> +		subflow->send_fastclose = 1;
> +		tcp_send_active_reset(ssk, ssk->sk_allocation,
> +				     
> SK_RST_REASON_TCP_ABORT_ON_CLOSE);
> +unlock:
> +		release_sock(ssk);
> +	}
>  }
>  
>  static void mptcp_worker(struct work_struct *work)
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 4faf58fecc94..663ea9ece31d 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -3646,7 +3646,6 @@ fullmesh_tests()
>  fastclose_tests()
>  {
>  	if reset_check_counter "fastclose test"
> "MPTcpExtMPFastcloseTx"; then
> -		MPTCP_LIB_SUBTEST_FLAKY=1

MPTCP_LIB_SUBTEST_FLAKY has already been deleted in the commit
"selftests: mptcp: join: fastclose: drop plain RST". It seems that with
this patchset, "selftests: mptcp: join: fastclose: drop plain RST" can
be reverted. Is that correct?

Thanks,
-Geliang

>  		test_linkfail=1024 fastclose=client \
>  			run_tests $ns1 $ns2 10.0.1.1
>  		chk_join_nr 0 0 0
> @@ -3655,7 +3654,6 @@ fastclose_tests()
>  	fi
>  
>  	if reset_check_counter "fastclose server test"
> "MPTcpExtMPFastcloseRx"; then
> -		MPTCP_LIB_SUBTEST_FLAKY=1
>  		test_linkfail=1024 fastclose=server \
>  			run_tests $ns1 $ns2 10.0.1.1
>  		join_rst_nr=1 \

