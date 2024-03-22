Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593EF3FE5F
	for <mptcp@lists.linux.dev>; Fri, 22 Mar 2024 16:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711124576; cv=none; b=m3BPksHaNzf5O7q8zJSKN0IYIWY4aKAuV32JN9cp5773E64VDj6D0WyQKEEOc0EO1lwU7KFVe5j/m/3UVoCtMdtMTezwy/97AL186FxZNJcNMwMQFwS7tJecfLr4x/41qWTVNXGtbyCHnvg8vKtH7DQIJdr3OZBU/F4IYt0n1+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711124576; c=relaxed/simple;
	bh=18UCwKttSaNenQb6h7xHKvrhVR5FcirCY43UBh+0vBs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eCgTdPoY+DdaNUECty2d4zv6+F8qYyURrObBODvJSdNCxrwwXq9MJRN7Ob+kJsOhTVPQzVep0RrTJKVgESfz183d6zr6eGnDyInR0eJzyutAM9GSF5OGL3NrrDV6NLVY3LGBu2qeFoFKombdFToyAFXiJgxUS6QxybLMb7oDC+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArZ13I1x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArZ13I1x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB398C433F1;
	Fri, 22 Mar 2024 16:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711124576;
	bh=18UCwKttSaNenQb6h7xHKvrhVR5FcirCY43UBh+0vBs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=ArZ13I1xjtDVV1OnmcjEHWKBeyF658BuSxOWVM8EDY5pRdAKBu8iB5AkixSI9QR1v
	 e+kheQN/ksXuonR3GbQ+78k73bJ2NLPSwsO03f96G18o+YuWcqgPhWTQJTHuNN4QvJ
	 PyR1pImXUjpV6YMek+dtwY2Zuc0nVAONunjyzQ5IAHu/Tn/A+JifAOQ++bhfnXlq9n
	 m2dJzsgs2y+lOPG8SUAnnLKKWuZVa2CjLcuP/0QVU8BFeHF4RBCXIDdAak/vFuR5AH
	 Y/ntRROAyv5LFZXaceOUmtkg+syLKGWUBrhJS3/RkllwFgOwq/AP1DHFCpdLkry0GF
	 vsMH8pAMIMqRQ==
Date: Fri, 22 Mar 2024 09:22:55 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Davide Caratti <dcaratti@redhat.com>
cc: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v4] mptcp: don't account accept() of non-MPC
 client as fallback to TCP
In-Reply-To: <054bcffde84b87f588f788b30dce2b702a532f64.1710923679.git.dcaratti@redhat.com>
Message-ID: <80d75699-5e9a-08c8-4e23-c1fdb938c361@kernel.org>
References: <054bcffde84b87f588f788b30dce2b702a532f64.1710923679.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 20 Mar 2024, Davide Caratti wrote:

> Current MPTCP servers increment MPTcpExtMPCapableFallbackACK when they
> accept non-MPC connections. As reported by Christoph, this is "surprising"
> because the counter might become greater than MPTcpExtMPCapableSYNRX.
>
> MPTcpExtMPCapableFallbackACK counter's name suggests it should only be
> incremented when a connection was seen using MPTCP options, then a
> fallback to TCP has been done. Let's do that by incrementing it when
> the subflow context of an inbound MPC connection attempt is dropped.
> Also, update mptcp_connect.sh kselftest, to ensure that the
> above MIB does not increment in case a pure TCP client connects to a
> MPTCP server.
>
> Fixes: fc518953bc9c ("mptcp: add and use MIB counter infrastructure")
> Reported-by: Christoph Paasch <cpaasch@apple.com>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/449
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
>
> ---
> v4:
> - improve kselftest (thanks Mat + Matthieu)

Selftest changes LGTM, thanks Davide:

Reviewed-by: Mat Martineau <martineau@kernel.org>

> v3:
> - fix typo in the if() conditional (thanks Matthieu)
> - rephrase commit message to target "-net" tree (thanks Matthieu)
> - add kselftest (thanks Matthieu)
> v2:
> - fix reporter's name
> ---
> net/mptcp/protocol.c                               | 2 --
> net/mptcp/subflow.c                                | 2 ++
> tools/testing/selftests/net/mptcp/mptcp_connect.sh | 9 +++++++++
> 3 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index cdf9ec67795e..556b3b95c537 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3937,8 +3937,6 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
> 				mptcp_set_state(newsk, TCP_CLOSE);
> 		}
> 	} else {
> -		MPTCP_INC_STATS(sock_net(ssk),
> -				MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
> tcpfallback:
> 		newsk->sk_kern_sock = kern;
> 		lock_sock(newsk);
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 1626dd20c68f..6042a47da61b 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -905,6 +905,8 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
> 	return child;
>
> fallback:
> +	if (fallback)
> +		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
> 	mptcp_subflow_drop_ctx(child);
> 	return child;
> }
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> index 4c4248554826..4131f3263a48 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -383,12 +383,14 @@ do_transfer()
> 	local stat_cookierx_last
> 	local stat_csum_err_s
> 	local stat_csum_err_c
> +	local stat_tcpfb_last_l
> 	stat_synrx_last_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableSYNRX")
> 	stat_ackrx_last_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableACKRX")
> 	stat_cookietx_last=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesSent")
> 	stat_cookierx_last=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesRecv")
> 	stat_csum_err_s=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtDataCsumErr")
> 	stat_csum_err_c=$(mptcp_lib_get_counter "${connector_ns}" "MPTcpExtDataCsumErr")
> +	stat_tcpfb_last_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableFallbackACK")
>
> 	timeout ${timeout_test} \
> 		ip netns exec ${listener_ns} \
> @@ -457,11 +459,13 @@ do_transfer()
> 	local stat_cookietx_now
> 	local stat_cookierx_now
> 	local stat_ooo_now
> +	local stat_tcpfb_now_l
> 	stat_synrx_now_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableSYNRX")
> 	stat_ackrx_now_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableACKRX")
> 	stat_cookietx_now=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesSent")
> 	stat_cookierx_now=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesRecv")
> 	stat_ooo_now=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtTCPOFOQueue")
> +	stat_tcpfb_now_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableFallbackACK")
>
> 	expect_synrx=$((stat_synrx_last_l))
> 	expect_ackrx=$((stat_ackrx_last_l))
> @@ -508,6 +512,11 @@ do_transfer()
> 		fi
> 	fi
>
> +	if [ ${stat_ooo_now} -eq 0 ] && [ ${stat_tcpfb_last_l} -ne ${stat_tcpfb_now_l} ]; then
> +		mptcp_lib_pr_fail "unexpected fallback to TCP"
> +		rets=1
> +	fi
> +
> 	if [ $cookies -eq 2 ];then
> 		if [ $stat_cookietx_last -ge $stat_cookietx_now ] ;then
> 			extra+=" WARN: CookieSent: did not advance"
> -- 
> 2.44.0
>
>
